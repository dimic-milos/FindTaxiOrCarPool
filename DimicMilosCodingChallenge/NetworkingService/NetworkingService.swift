//
//  NetworkingService.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/23/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import os
import Foundation

class NetworkingService: VehicleObtainable {
    
    private struct Constants {
        static let firstPositionLatitude     = "p1Lat="
        static let firstPositionLongitude    = "p1Lon="
        static let secondPositionLatitude    = "p2Lat="
        static let secondPositionLongitude   = "p2Lon="
    }
    
    private enum Server {
        case development
        case production
        
        var baseURL: String {
            switch self {

            case .development:
                return "https://fake-poi-api.mytaxi.com/?"
            case .production:
                return "https://fake-poi-api.mytaxi.com/?"
            }
        }
    }
    
    enum APIRequestError: Error {
        case invalidEndpoint
        case serializationFailed
        case responseIsNotHTTPURL
        case statusCodeNotSuccessful(error: Error?)
        case dataIsNil
        case dataIsEmpty
        
        var description: String {
            return String(describing: self)
        }
    }
    
    typealias Parameters = [String: Any]
    
    enum HTTPMethod: String {
        case get     = "GET"
        case post    = "POST"
        case put     = "PUT"
    }
    
    // MARK: - Properties
    
    #if DEVELOPMENT
    private let baseURL = Server.development.baseURL
    #else
    private let baseURL = Server.production.baseURL
    #endif
    
    private let session = URLSession.shared
    private var dataTask: URLSessionDataTask?
    
    // MARK: - Public methods
    
    func getVehicles(inBounds bounds: Bounds, apiResponse: APIResponse?) {
        os_log(.info, log: .network, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        dataTask?.cancel()
        
        let endpoint = baseURL + Constants.firstPositionLatitude + bounds.firstPositionLatitudeString + "&" +
                                 Constants.firstPositionLongitude + bounds.firstPositionLongitudeString + "&" +
                                 Constants.secondPositionLatitude + bounds.secondPositionLatitudeString + "&" +
                                 Constants.secondPositionLongitude + bounds.secondPositionLongitudeString
        
        guard let url = URL(string: endpoint) else {
            os_log(.error, log: .network, "error: %s, function: %s, line: %i, \nfile: %s", APIRequestError.invalidEndpoint.description, #function, #line, #file)
            apiResponse?(.failure(APIRequestError.invalidEndpoint))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            defer {
                self.dataTask = nil
            }
            
            guard let HTTPURLResponse = response as? HTTPURLResponse else {
                os_log(.error, log: .network, "error: %s, function: %s, line: %i, \nfile: %s", APIRequestError.responseIsNotHTTPURL.description, #function, #line, #file)
                apiResponse?(.failure(APIRequestError.responseIsNotHTTPURL))
                return
            }
            
            switch HTTPURLResponse.statusCode {
                
            case 200..<300:
                guard let data = data else {
                    os_log(.error, log: .network, "error: %s, function: %s, line: %i, \nfile: %s", APIRequestError.dataIsNil.description, #function, #line, #file)
                    apiResponse?(.failure(APIRequestError.dataIsNil))
                    return
                }
                
                os_log(.info, log: .network, "success, statusCode: %{public}d, function: %s, line: %i, \nfile: %s", HTTPURLResponse.statusCode, #function, #line, #file);
                apiResponse?(.success(data))
            default:
                os_log(.error, log: .network, "error: %s, statusCode %{public}d, function: %s, line %i, \nfile: %s", APIRequestError.statusCodeNotSuccessful(error: error).description, HTTPURLResponse.statusCode, #function, #line, #file)
                apiResponse?(.failure(APIRequestError.statusCodeNotSuccessful(error: error)))
            }
        }
        dataTask?.resume()
    }
}
