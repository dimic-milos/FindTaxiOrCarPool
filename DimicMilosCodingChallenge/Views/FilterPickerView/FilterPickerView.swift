//
//  FilterPickerView.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/25/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import os
import UIKit

class FilterPickerView: UIView {

    // MARK: - Outlets
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: - Properties
    
    weak var delegate: FilterPickerViewDelegate?
    
    // MARK: - Action methods
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        os_log(.info, log: .action, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        delegate?.indexChanged(toNewIndex: sender.selectedSegmentIndex)
    }
    
}
