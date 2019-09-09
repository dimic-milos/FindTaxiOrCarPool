//
//  MapFlowCoordinatorDelegate.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/24/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

protocol MapFlowCoordinatorDelegate: class {
    func showInTheList(vehiclesMapViewModels: [VehicleMapViewModel], mapFlowCoordinator: MapFlowCoordinator)
    func boundsChanged(to newBounds: Bounds, newCenter: Coordinate, mapFlowCoordinator: MapFlowCoordinator)
}
