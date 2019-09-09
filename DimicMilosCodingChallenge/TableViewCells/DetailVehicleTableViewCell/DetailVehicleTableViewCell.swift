//
//  DetailVehicleTableViewCell.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/23/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import os
import UIKit

class DetailVehicleTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var imageViewFleetType: UIImageView!
    @IBOutlet weak var labelFleetType: UILabel!
    @IBOutlet weak var labelDistance: UILabel!
    @IBOutlet weak var labelDirection: UILabel!
    
    // MARK: - Public methods
    
    func configureCell(withVehiclePresentable vehiclePresentable: VehiclePresentable) {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)

        imageViewFleetType.image = vehiclePresentable.vehicleImage
        labelFleetType.text = vehiclePresentable.fleetTypeDescription
        labelDistance.text = vehiclePresentable.vehicleDistanceString
        labelDirection.text = vehiclePresentable.vehicleDirectionString
    }
    
}
