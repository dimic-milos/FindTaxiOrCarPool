//
//  MapFlowCoordinator.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/24/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import os
import UIKit

class MapFlowCoordinator: NavigationCoordinator {

    // MARK: - Properties
        
    private var bounds: Bounds
    private lazy var vehiclesMapViewController = VehiclesMapViewController(withBounds: bounds)
    
    weak var delegate: MapFlowCoordinatorDelegate?
    
    // MARK: - Init methods
    
    init(bounds: Bounds, rootViewController: UINavigationController) {
        os_log(.info, log: .initialization, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        self.bounds = bounds
        super.init(rootViewController: rootViewController)
    }
    
    // MARK: - Override methods
    
    override func start() {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        vehiclesMapViewController.delegate = self
        rootOut(with: vehiclesMapViewController)
    }

    // MARK: - Public methods
    
    func update(vehiclesMapViewModels: [VehicleMapViewModel]) {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)

        let vehicles = Vehicles(vehicleMapViewModels: vehiclesMapViewModels)
        vehicles.configure(vehiclePresentable: vehiclesMapViewController)
    }
}

extension MapFlowCoordinator: VehiclesMapViewControllerDelegate {
    
    // MARK: - VehiclesMapViewControllerDelegate
    
    func regionDidChange(toNewBounds newBounds: Bounds, newCenter: Coordinate, vehiclesMapViewController: VehiclesMapViewController) {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        bounds = newBounds
        delegate?.boundsChanged(to: newBounds, newCenter: newCenter, mapFlowCoordinator: self)
    }
    
    func didTapShowInTheList(vehiclesMapViewModels: [VehicleMapViewModel], in vehiclesMapViewController: VehiclesMapViewController) {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        pop()
        delegate?.showInTheList(vehiclesMapViewModels: vehiclesMapViewModels, mapFlowCoordinator: self)
    }

}
