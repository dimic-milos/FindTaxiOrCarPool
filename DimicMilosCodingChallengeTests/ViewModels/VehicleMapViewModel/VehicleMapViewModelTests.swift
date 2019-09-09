//
//  VehicleMapViewModelTests.swift
//  DimicMilosCodingChallengeTests
//
//  Created by Dimic Milos on 8/25/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import XCTest
@testable import DimicMilosCodingChallenge

class VehicleMapViewModelTests: XCTestCase {

    func test_Init_AllParametersProvidedAreValid_SutIsNotNil() {
        let sut = VehicleMapViewModel.makeSUT(vehicleCoordinate: .zeroLatZeroLon, vehicleDirectionAngle: .validVehicleDirectionAngle , fleetType: Fleet.validFleetTypeTaxiString , userCoordinate: .zeroLatZeroLon)
        XCTAssertNotNil(sut)
    }
    
    func test_Init_WhenInvalidVehicleDirectionAngleProvided_SutIsNil() {
        let sut = VehicleMapViewModel.makeSUT(vehicleDirectionAngle: .invalidVehicleDirectionAngle)
        XCTAssertNil(sut)
    }
    
    func test_Init_WhenInvalidFleetTypeStringProvided_SutIsNil() {
        let sut = VehicleMapViewModel.makeSUT(fleetType: Fleet.invalidFleetTypeString)
        XCTAssertNil(sut)
    }
    
    func test_VehicleImage_WhenFleetTypeIsTaxi_ResultIsAsExpected() {
        let expectedResult = Image.taxi
        let sut = VehicleMapViewModel.makeSUT(fleetType: Fleet.validFleetTypeTaxiString)
        XCTAssertEqual(expectedResult, sut?.vehicleImage)
    }
    
    func test_VehicleImage_WhenFleetTypeIsPooling_ResultIsAsExpected() {
        let expectedResult = Image.carPool
        let sut = VehicleMapViewModel.makeSUT(fleetType: Fleet.validFleetTypePoolingString)
        XCTAssertEqual(expectedResult, sut?.vehicleImage)
    }
    
    func test_FleetTypeDescription_WhenFleetTypeIsTaxi_ResultIsAsExpected() {
        let expectedResult = Fleet.init(rawValue: Fleet.validFleetTypeTaxiString)?.description
        let sut = VehicleMapViewModel.makeSUT(fleetType: Fleet.validFleetTypeTaxiString)
        XCTAssertEqual(expectedResult, sut?.fleetTypeDescription)
    }
    
    func test_FleetTypeDescription_WhenFleetTypeIsPooling_ResultIsAsExpected() {
        let expectedResult = Fleet.init(rawValue: Fleet.validFleetTypePoolingString)?.description
        let sut = VehicleMapViewModel.makeSUT(fleetType: Fleet.validFleetTypePoolingString)
        XCTAssertEqual(expectedResult, sut?.fleetTypeDescription)
    }
    
    func test_VehicleDistanceInMeters_WhenUserCoordinateIsTheSameAsVehicleCoordinate_ResultIsAsExpected() {
        let expectedResult = 0.0
        let sut = VehicleMapViewModel.makeSUT()
        XCTAssertEqual(expectedResult, sut?.vehicleDistanceInMeters)
    }
    
    func test_VehicleDistanceInMeters_WhenUserLatitudeAndVehicleLatitudeAreOneDegreeApart_ResultIsAsExpected() {
        let expectedResult = 111000.00
        if let sut = VehicleMapViewModel.makeSUT(userCoordinate: Coordinate(latitude: 1.0, longitude: 0)) {
            XCTAssertEqual(expectedResult, sut.vehicleDistanceInMeters, accuracy: 1000)
        } else {
            XCTFail()
        }
    }
    
    func test_VehicleDirectionString_WhenVehicleDirectionAngleIsZero_ResultIsAsExpected() {
        if let vehicleDirectionName = VehicleDirection.init(angle: 0)?.name {
            let expectedResult = VehicleMapViewModel.Constants.VehicleDirectionPrefix + vehicleDirectionName
            let sut = VehicleMapViewModel.makeSUT()
            XCTAssertEqual(expectedResult, sut?.vehicleDirectionString)
        } else {
            XCTFail()
        }
    }
    
    func test_VehicleDirectionString_WhenVehicleDirectionAngleIsAsprovided_ResultIsAsExpected() {
        let providedAngle = 180.0
        if let vehicleDirectionName = VehicleDirection.init(angle: providedAngle)?.name {
            let expectedResult = VehicleMapViewModel.Constants.VehicleDirectionPrefix + vehicleDirectionName
            let sut = VehicleMapViewModel.makeSUT(vehicleDirectionAngle: providedAngle)
            XCTAssertEqual(expectedResult, sut?.vehicleDirectionString)
        } else {
            XCTFail()
        }
    }
    
    func test_VehicleDistanceString_WhenDistanceIsZero_ResultIsAsExpected() {
        let expectedResult = "0.0" + VehicleMapViewModel.Constants.VehicleDistanceSuffix
        let sut = VehicleMapViewModel.makeSUT()
        XCTAssertEqual(expectedResult, sut?.vehicleDistanceString)
    }
    
    func test_Coordinate_MustBeTheSameAsProvidedVehicleCoordinates() {
        let vehicleCoordinate = Coordinate(latitude: 11.22, longitude: 33.44)
        let expectedResult = vehicleCoordinate
        let sut = VehicleMapViewModel.makeSUT(vehicleCoordinate: vehicleCoordinate)
        XCTAssertEqual(expectedResult.latitude, sut?.coordinate.latitude)
        XCTAssertEqual(expectedResult.longitude, sut?.coordinate.longitude)
    }
}
