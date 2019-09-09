//
//  NearbyVehiclesListViewControllerTests.swift
//  DimicMilosCodingChallengeTests
//
//  Created by Dimic Milos on 8/25/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import XCTest
@testable import DimicMilosCodingChallenge

class NearbyVehiclesListViewControllerTests: XCTestCase {

    var sut: NearbyVehiclesListViewController!
    
    override func setUp() {
        sut = NearbyVehiclesListViewController()
    }
    
    func test_SutHasTableView() {
        sut.beginAppearanceTransition(true, animated: false)
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_SutHasViewContainer() {
        sut.beginAppearanceTransition(true, animated: false)
        XCTAssertNotNil(sut.viewContainer)
    }
    
    func test_ButtonShowVehiclesOnMapTapped_NotifesDelegate() {
        let mockNearbyVehiclesListViewControllerDelegate = MockNearbyVehiclesListViewControllerDelegate()
        sut.delegate = mockNearbyVehiclesListViewControllerDelegate
        sut.buttonShowVehiclesOnMapTapped(UIButton())
        XCTAssertTrue(mockNearbyVehiclesListViewControllerDelegate.isDelegateNotified)
    }
    
    func test_ViewDidLoad_SetupsFilterPickerView() {
        sut.beginAppearanceTransition(true, animated: false)
        XCTAssertNotNil(sut.filterPickerView)
    }
    
    func test_IndexChangedToNewIndex_SetsFilterByFleetTypeToExpectedResult() {
        let index = 1
        let expectedResult = Fleet(index)
        sut.indexChanged(toNewIndex: 1)
        XCTAssertEqual(expectedResult, sut.filterByFleetType)
    }
    
    func test_UpdateVehiclesMapViewModels_SetsVehicleMapViewModelsToExpectedResult() {
        let expectedResult = [VehicleMapViewModel.makeSUT(fleetType: Fleet.validFleetTypePoolingString),VehicleMapViewModel.makeSUT(userCoordinate: .zeroLatZeroLon)].compactMap { $0 }
        sut.update(vehiclesMapViewModels: expectedResult)
        XCTAssertEqual(expectedResult, sut.vehicleMapViewModels)
    }
    
    func test_viewDidLoad_tableViewCanDequeDetailVehicleTableViewCell() {
        sut.beginAppearanceTransition(true, animated: false)
        XCTAssertNotNil(sut.tableView.dequeueReusableCell(withIdentifier: DetailVehicleTableViewCell.reuseIdentifier()))
    }
}

extension NearbyVehiclesListViewControllerTests {
    
    class MockNearbyVehiclesListViewControllerDelegate: NearbyVehiclesListViewControllerDelegate {
        
        var isDelegateNotified = false
        
        func didTapButtonShowVehiclesOnMap(_ nearbyVehiclesListViewController: NearbyVehiclesListViewController) {
            isDelegateNotified = true
        }
    }
}
