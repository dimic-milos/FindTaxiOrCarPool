//
//  VehiclePresentable.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/25/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import UIKit

protocol VehiclePresentable {
    var vehicleImage: UIImage { get }
    var fleetTypeDescription: String { get }
    var vehicleDistanceString: String { get }
    var vehicleDirectionString: String { get }
}
