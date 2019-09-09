//
//  Extensions.swift
//  DimicMilosCodingChallengeTests
//
//  Created by Dimic Milos on 8/25/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import XCTest
@testable import DimicMilosCodingChallenge

extension Coordinate {
    static let zeroLatZeroLon = Coordinate(latitude: 0, longitude: 0)
}

extension Fleet {
    static let validFleetTypeTaxiString = "taxi"
    static let validFleetTypePoolingString = "pooling"
    static let invalidFleetTypeString = "$%#%$#@#$%"
}

extension Double {
    static let validVehicleDirectionAngle = 0.0
    static let invalidVehicleDirectionAngle = 400.0
}

extension VehicleMapViewModel {    
    static func makeSUT(vehicleCoordinate: Coordinate = .zeroLatZeroLon, vehicleDirectionAngle: Double = .validVehicleDirectionAngle, fleetType: String = Fleet.validFleetTypeTaxiString,userCoordinate: Coordinate = .zeroLatZeroLon) -> VehicleMapViewModel? {
        return VehicleMapViewModel(vehicleCoordinate: vehicleCoordinate, vehicleDirectionAngle: vehicleDirectionAngle , fleetType: fleetType , userCoordinate: userCoordinate)
    }
}

