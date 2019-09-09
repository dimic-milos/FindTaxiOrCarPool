//
//  VehicleMapViewModel.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/23/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import os
import Foundation
import MapKit

class VehicleMapViewModel: NSObject {
    
    struct Constants {
        static let VehicleDirectionPrefix = "Vehicle direction: "
        static let VehicleDistanceSuffix = "KM from currently selected location"
        
        static let OneThousand = 1000.00
        static let oneDecimalStringFormat = "%.1f"
    }
    
    // MARK: - Properties
    
    private let vehicleCoordinate: CLLocationCoordinate2D
    private let userCoordinate: CLLocationCoordinate2D
    private let vehicleDirection: VehicleDirection
    let fleetType: Fleet
    
    // MARK: - Computed Properties
    
    var vehicleDistanceInMeters: Double {
        let vehicleLocation = CLLocation(latitude: vehicleCoordinate.latitude, longitude: vehicleCoordinate.longitude)
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        return userLocation.distance(from: vehicleLocation)
    }
    
    // MARK: - Init
    
    init?(vehicleCoordinate: Coordinate, vehicleDirectionAngle: Double, fleetType: String, userCoordinate: Coordinate) {
        os_log(.info, log: .initialization, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        guard let fleetType = Fleet(rawValue: fleetType) else {
            os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
            return nil
        }
        
        guard let vehicleDirection = VehicleDirection(angle: vehicleDirectionAngle) else {
            os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
            return nil
        }
        
        self.fleetType = fleetType
        self.vehicleDirection = vehicleDirection
        self.vehicleCoordinate = CLLocationCoordinate2D(latitude: vehicleCoordinate.latitude, longitude: vehicleCoordinate.longitude)
        self.userCoordinate = CLLocationCoordinate2D(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
    }
}

extension VehicleMapViewModel: VehiclePresentable {
    
    // MARK: - VehiclePresentable
    
    var vehicleImage: UIImage {
        return fleetType.image
    }
    
    var fleetTypeDescription: String {
        return fleetType.description
    }
    
    var vehicleDirectionString: String {
        return Constants.VehicleDirectionPrefix + vehicleDirection.name
    }
    
    var vehicleDistanceString: String {
        let distanceInKM = vehicleDistanceInMeters / Constants.OneThousand
        return String(format: Constants.oneDecimalStringFormat, distanceInKM) + Constants.VehicleDistanceSuffix
    }
}

extension VehicleMapViewModel: MKAnnotation {

    // MARK: - MKAnnotation
    
    var coordinate: CLLocationCoordinate2D {
        return vehicleCoordinate
    }
    
    public var title: String? {
        return fleetTypeDescription
    }
    
    public var subtitle: String? {
        return vehicleDistanceString
    }
}
