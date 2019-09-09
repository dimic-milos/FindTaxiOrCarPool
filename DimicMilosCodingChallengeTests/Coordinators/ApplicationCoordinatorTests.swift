//
//  ApplicationCoordinatorTests.swift
//  DimicMilosCodingChallengeTests
//
//  Created by Dimic Milos on 8/25/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import XCTest
@testable import DimicMilosCodingChallenge

class ApplicationCoordinatorTests: XCTestCase {

    func test_Init() {
        let sut = ApplicationCoordinator(window: UIWindow(), vehicleObtainable: NetworkingService(), parserService: ParserService(), rootViewController: MainNavigationController())
        XCTAssertNotNil(sut)
    }
    
    func test_DidTapButtonShowVehiclesInTheList_MakesGetVehiclesNetworkCall() {
        let mockVehicleObtainable = MockVehicleObtainable()
        let sut = ApplicationCoordinator(window: UIWindow(), vehicleObtainable: mockVehicleObtainable, parserService: ParserService(), rootViewController: MainNavigationController())
        sut.didTapButtonShowVehiclesInTheList(FlowPickerViewController())
        XCTAssertTrue(mockVehicleObtainable.isGetVehiclesCalled)
    }
    
    func test_DidTapButtonShowVehiclesInTheList_RequestsVehiclesForExpectedBounds() {
        let mockVehicleObtainable = MockVehicleObtainable()
        let sut = ApplicationCoordinator(window: UIWindow(), vehicleObtainable: mockVehicleObtainable, parserService: ParserService(), rootViewController: MainNavigationController())
        let expectedBounds = sut.userDefinedBounds
        sut.didTapButtonShowVehiclesInTheList(FlowPickerViewController())
        XCTAssertEqual(expectedBounds, mockVehicleObtainable.requestedBounds)
    }
    
    func test_DidTapButtonShowVehiclesOnTheMap_AddsMapFlowCoordinatorAsChildCoordinator() {
        let sut = ApplicationCoordinator(window: UIWindow(), vehicleObtainable: NetworkingService(), parserService: ParserService(), rootViewController: MainNavigationController())
        sut.didTapButtonShowVehiclesOnTheMap(FlowPickerViewController())

        let exp = expectation(description: "Test after timeout")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(sut.childCoordinators["MapFlowCoordinator"] is MapFlowCoordinator)
        } else {
            XCTFail("timedOut")
        }
    }
    
    func test_DidTapButtonShowVehiclesOnTheMap_PopViewControllerIsCalled() {
        let spyNavigationController = SpyNavigationController()
        let sut = ApplicationCoordinator(window: UIWindow(), vehicleObtainable: NetworkingService(), parserService: ParserService(), rootViewController: spyNavigationController)
        sut.viewControllers.append(UIViewController())
        sut.didTapButtonShowVehiclesOnTheMap(FlowPickerViewController())
        XCTAssertTrue(spyNavigationController.isPopViewControllerCalled)
    }
}

extension ApplicationCoordinatorTests {
    
    class MockVehicleObtainable: VehicleObtainable {
        
        var isGetVehiclesCalled = false
        var requestedBounds: Bounds?
        
        func getVehicles(inBounds bounds: Bounds, apiResponse: APIResponse?) {
            isGetVehiclesCalled = true
            requestedBounds = bounds
        }
    }
    
    class SpyNavigationController: UINavigationController {
        
        var isPopViewControllerCalled = false
        
        override func popViewController(animated: Bool) -> UIViewController? {
            isPopViewControllerCalled = true
            return UIViewController()
        }
    }
}
