//
//  FlowPickerViewController.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/24/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import os
import UIKit

class FlowPickerViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: FlowPickerViewControllerDelegate?
    
    // MARK: - Init methods
    
    init() {
        os_log(.info, log: .initialization, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        os_log(.info, log: .ui, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        os_log(.info, log: .ui, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        os_log(.info, log: .ui, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
    }

    // MARK: - Action methods
    
    @IBAction func buttonShowVehiclesInTheListTapped(_ sender: UIButton) {
        os_log(.info, log: .action, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        delegate?.didTapButtonShowVehiclesInTheList(self)
    }
    @IBAction func buttonShowVehiclesOnTheMapTapped(_ sender: UIButton) {
        os_log(.info, log: .action, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        delegate?.didTapButtonShowVehiclesOnTheMap(self)
    }
}
