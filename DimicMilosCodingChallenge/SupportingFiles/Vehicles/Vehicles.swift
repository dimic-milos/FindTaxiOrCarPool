//
//  Vehicles.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/25/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import os

struct Vehicles {
    
    // MARK: - Properties
    
    private let vehicleMapViewModels: [VehicleMapViewModel]
    
    // MARK: - Init
    
    init(vehicleMapViewModels: [VehicleMapViewModel]) {
        os_log(.info, log: .initialization, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        self.vehicleMapViewModels = vehicleMapViewModels
    }
    
    // MARK: - Public methods
    
    func configure(vehiclePresentable: VehiclesUpdatable) {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        vehiclePresentable.update(vehiclesMapViewModels: self.vehicleMapViewModels)
    }
}
