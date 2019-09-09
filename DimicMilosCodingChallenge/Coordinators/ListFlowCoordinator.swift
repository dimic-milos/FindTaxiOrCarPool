//
//  ListFlowCoordinator.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/23/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import os
import UIKit

class ListFlowCoordinator: NavigationCoordinator {
    
    // MARK: - Properties
    
    private let vehiclesMapViewModels: [VehicleMapViewModel]
    private var nearbyVehiclesListViewController: NearbyVehiclesListViewController!
    
    weak var delegate: ListFlowCoordinatorDelegate?
    
    // MARK: - Init methods
    
    init(vehiclesMapViewModels: [VehicleMapViewModel], rootViewController: UINavigationController) {
        os_log(.info, log: .initialization, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        self.vehiclesMapViewModels = vehiclesMapViewModels
        super.init(rootViewController: rootViewController)
    }
    
    // MARK: - Override methods
    
    override func start() {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        nearbyVehiclesListViewController = NearbyVehiclesListViewController()
        nearbyVehiclesListViewController.delegate = self
        nearbyVehiclesListViewController.loadViewIfNeeded()
        rootOut(with: nearbyVehiclesListViewController)
        
        let vehicles = Vehicles(vehicleMapViewModels: vehiclesMapViewModels)
        vehicles.configure(vehiclePresentable: nearbyVehiclesListViewController)
    }
}

extension ListFlowCoordinator: NearbyVehiclesListViewControllerDelegate {
    
    // MARK: - NearbyVehiclesListViewControllerDelegate
    
    func didTapButtonShowVehiclesOnMap(_ nearbyVehiclesListViewController: NearbyVehiclesListViewController) {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)

        pop()
        delegate?.showVehiclesOnMap(self)
    }
}
