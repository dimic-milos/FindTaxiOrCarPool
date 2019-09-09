//
//  Vehicle.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/23/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import os

struct Vehicle: Decodable {
    
    private enum CodingKeys: CodingKey {
        case id
        case coordinate
        case fleetType
        case heading
    }
    
    let id: Int
    let coordinate: Coordinate
    let fleetType: String
    let heading: Double
    
    init(from decoder: Decoder) throws {
        os_log(.info, log: .codable, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        coordinate = try container.decode(Coordinate.self, forKey: .coordinate)
        fleetType = try container.decode(String.self, forKey: .fleetType)
        heading = try container.decode(Double.self, forKey: .heading)
    }
    
}
