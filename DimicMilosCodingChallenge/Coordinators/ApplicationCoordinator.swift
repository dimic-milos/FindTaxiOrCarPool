//
//  ApplicationCoordinator.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/23/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import os
import UIKit

class ApplicationCoordinator: NavigationCoordinator {
    
    // MARK: - Properties
    
    private let window: UIWindow
    private let vehicleObtainable: VehicleObtainable
    private let parserService: ParserService
    
    private (set) var userDefinedCoordinate: Coordinate
    private (set) var userDefinedBounds: Bounds
    
    // MARK: - Init methods
    
    init(window: UIWindow, vehicleObtainable: VehicleObtainable, parserService: ParserService, rootViewController: UINavigationController) {
        os_log(.info, log: .initialization, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        self.window = window
        self.vehicleObtainable = vehicleObtainable
        self.parserService = parserService
        
        self.userDefinedCoordinate = Constants.HamburgCenter
        self.userDefinedBounds = Constants.HamburgBounds
        
        super.init(rootViewController: rootViewController)
    }
    
    // MARK: - Override methods
    
    override func start() {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        window.set(rootViewController: rootViewController)
        rootViewController.setNavigationBarHidden(true, animated: false)
        
        showFlowPicker()
    }
    
    // MARK: - Private methods
    
    private func showFlowPicker() {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)

        let flowPickerViewController = FlowPickerViewController()
        flowPickerViewController.delegate = self
        rootOut(with:flowPickerViewController)
    }
    
    private func openListFlow(withVehiclesMapViewModels: [VehicleMapViewModel]) {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
                return
            }
        
            let listFlowCoordinator = ListFlowCoordinator(vehiclesMapViewModels: withVehiclesMapViewModels, rootViewController: self.rootViewController)
            listFlowCoordinator.delegate = self
            self.add(childCoordinator: listFlowCoordinator)
            listFlowCoordinator.start()
        }
    }
    
    private func getVehiclesData(inBounds bounds: Bounds, completion: @escaping (Result<Data, Error>) -> ()) {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        vehicleObtainable.getVehicles(inBounds: bounds) { (response) in
            
            switch response {
                
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
                os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s, \nerror: %s", #function, #line, #file, String(describing: error))
            }
        }
    }
    
    private func parsePointsOfInterest(fromData data: Data) -> [Vehicle]? {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        let parseResult = parserService.parsePointsOfInterest(fromData: data)
        
        switch parseResult {
            
        case .success(let vehicles):
            return vehicles
        case .failure(let error):
            os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s, \nerror: %s", #function, #line, #file, String(describing: error))
            return nil
        }
    }
    
    private func getVehicleMapViewModels(fromVehicles vehicles: [Vehicle]) -> [VehicleMapViewModel] {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        var vehiclesMapViewModels: [VehicleMapViewModel] = []
        
        vehicles.forEach {
            let vehicleCoordinate = Coordinate(latitude:  $0.coordinate.latitude, longitude: $0.coordinate.longitude)
            guard let vehiclesMapViewModel = VehicleMapViewModel(vehicleCoordinate: vehicleCoordinate, vehicleDirectionAngle: $0.heading, fleetType: $0.fleetType.lowercased(), userCoordinate: userDefinedCoordinate) else {
                os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
                return
            }
            vehiclesMapViewModels.append(vehiclesMapViewModel)
        }
        return vehiclesMapViewModels
    }
    
    private func sortByDistance(_ vehiclesMapViewModels: [VehicleMapViewModel]) -> [VehicleMapViewModel] {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)

        return vehiclesMapViewModels.sorted(by: { (v1, v2) -> Bool in
            return  v1.vehicleDistanceInMeters < v2.vehicleDistanceInMeters
        })
    }
    
    private func startVehiclesInTheListFlow(withVehicleMapViewModels vehicleMapViewModels: [VehicleMapViewModel]) {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        openListFlow(withVehiclesMapViewModels: vehicleMapViewModels)
    }
    
    private func startVehiclesOnTheMapFlow() {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
                return
            }
            
            let mapFlowCoordinator = MapFlowCoordinator(bounds: self.userDefinedBounds, rootViewController: self.rootViewController)
            mapFlowCoordinator.delegate = self
            self.add(childCoordinator: mapFlowCoordinator)
            mapFlowCoordinator.start()
        }
    }
    
    private func getVehicles(inBounds bounds: Bounds, completion: @escaping ([VehicleMapViewModel]?) -> ()) {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        getVehiclesData(inBounds: bounds) { [weak self] (response) in
            guard let self = self else {
                os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
                return
            }
            
            switch response {
                
            case .success(let data):
                guard let vehicles = self.parsePointsOfInterest(fromData: data) else {
                    os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
                    break
                }
                let vehicleMapViewModels = self.getVehicleMapViewModels(fromVehicles: vehicles)
                let sortedVehicleMapViewModels = self.sortByDistance(vehicleMapViewModels)
                completion(sortedVehicleMapViewModels)
    
            case .failure(let error):
                os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s, \nerror: %s", #function, #line, #file, String(describing: error))
                completion(nil)
            }
        }
    }
}


extension ApplicationCoordinator: FlowPickerViewControllerDelegate {
    
    // MARK: - FlowPickerViewControllerDelegate
    
    func didTapButtonShowVehiclesInTheList(_ flowPickerViewController: FlowPickerViewController) {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        pop()
        getVehicles(inBounds: userDefinedBounds) { [weak self] (vehicleMapViewModels) in
            guard let self = self else {
                os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
                return
            }
            guard let vehicleMapViewModels = vehicleMapViewModels else {
                os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
                return
            }
            self.startVehiclesInTheListFlow(withVehicleMapViewModels: vehicleMapViewModels)
        }
    }
    
    func didTapButtonShowVehiclesOnTheMap(_ flowPickerViewController: FlowPickerViewController) {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        pop()
        startVehiclesOnTheMapFlow()
    }
}

extension ApplicationCoordinator: ListFlowCoordinatorDelegate {

    // MARK: - ListFlowCoordinatorDelegate
    
    func showVehiclesOnMap(_ listFlowCoordinator: ListFlowCoordinator) {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        remove(childCoordinator: listFlowCoordinator)
        startVehiclesOnTheMapFlow()
    }
}

extension ApplicationCoordinator: MapFlowCoordinatorDelegate {

    // MARK: - MapFlowCoordinatorDelegate

    func boundsChanged(to newBounds: Bounds, newCenter: Coordinate, mapFlowCoordinator: MapFlowCoordinator) {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        userDefinedBounds = newBounds
        userDefinedCoordinate = newCenter
        getVehicles(inBounds: newBounds) { (vehicleMapViewModels) in
            guard let vehicleMapViewModels = vehicleMapViewModels else {
                os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
                return
            }
            mapFlowCoordinator.update(vehiclesMapViewModels: vehicleMapViewModels)
        }
    }
    
    func showInTheList(vehiclesMapViewModels: [VehicleMapViewModel], mapFlowCoordinator: MapFlowCoordinator) {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        remove(childCoordinator: mapFlowCoordinator)
        startVehiclesInTheListFlow(withVehicleMapViewModels: vehiclesMapViewModels)
    }
}
