//
//  NearbyVehiclesListViewController.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/23/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import os
import UIKit

class NearbyVehiclesListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private (set) var filterPickerView: FilterPickerView!
    weak var delegate: NearbyVehiclesListViewControllerDelegate?
    
    // MARK: - Computed Properties
    
    private (set) var vehicleMapViewModels: [VehicleMapViewModel] = [] {
        didSet {
            reloadTableView()
        }
    }
    
    private (set) var filterByFleetType: Fleet? {
        didSet {
            reloadTableView()
        }
    }
    
    private var filteredVehicleMapViewModels: [VehicleMapViewModel] {
        if let filterByFleetType = filterByFleetType {
            return vehicleMapViewModels.filter { $0.fleetType == filterByFleetType }
        } else {
            return vehicleMapViewModels
        }
    }

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
        
        registerCells()
        setupFilterPickerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        os_log(.info, log: .ui, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        os_log(.info, log: .ui, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
    }
    
    // MARK: - Private methods
    
    private func reloadTableView() {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)

        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
                return
            }
            guard let tableView = self.tableView else {
                os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
                return
            }
            tableView.reloadData()
        }
    }
    
    private func registerCells() {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        tableView.register(DetailVehicleTableViewCell.nib, forCellReuseIdentifier: DetailVehicleTableViewCell.reuseIdentifier())
    }
    
    private func setupFilterPickerView() {
        filterPickerView = FilterPickerView.fromNib()
        guard let filterPickerView = filterPickerView else {
            os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
            return
        }
        filterPickerView.translatesAutoresizingMaskIntoConstraints = false
        filterPickerView.delegate = self
        
        viewContainer.addSubview(filterPickerView)
        viewContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[filterPickerView]-(0)-|", options: [], metrics: nil, views: ["filterPickerView": filterPickerView]))
        viewContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[filterPickerView]|", options: [], metrics: nil, views: ["filterPickerView": filterPickerView]))
    }
    
    // MARK: - Action methods
    
    @IBAction func buttonShowVehiclesOnMapTapped(_ sender: UIButton) {
        os_log(.info, log: .action, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        delegate?.didTapButtonShowVehiclesOnMap(self)
    }
    
}

extension NearbyVehiclesListViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        os_log(.info, log: .frequent, "function: %s, line: %i, \nfile: %s", #function, #line, #file)

        return filteredVehicleMapViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        os_log(.info, log: .frequent, "function: %s, line: %i, \nfile: %s", #function, #line, #file)

        let cell = tableView.dequeueReusableCell(withIdentifier: DetailVehicleTableViewCell.reuseIdentifier()) as! DetailVehicleTableViewCell
        cell.configureCell(withVehiclePresentable: filteredVehicleMapViewModels[indexPath.row])
        return cell
    }
}

extension NearbyVehiclesListViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension NearbyVehiclesListViewController: FilterPickerViewDelegate {
    
    // MARK: - FilterPickerViewDelegate
    
    func indexChanged(toNewIndex index: Int) {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        filterByFleetType = Fleet(index)
    }
}

extension NearbyVehiclesListViewController: VehiclesUpdatable  {
    
    // MARK: - VehiclesUpdatable
    
    func update(vehiclesMapViewModels: [VehicleMapViewModel]) {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)

        self.vehicleMapViewModels = vehiclesMapViewModels
    }
}
