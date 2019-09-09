//
//  FlowPickerViewControllerDelegate.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/24/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

protocol FlowPickerViewControllerDelegate: class {
    func didTapButtonShowVehiclesInTheList(_ flowPickerViewController: FlowPickerViewController)
    func didTapButtonShowVehiclesOnTheMap(_ flowPickerViewController: FlowPickerViewController)
}
