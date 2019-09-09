//
//  VehiclesMapViewController.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/24/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import os
import UIKit
import MapKit

class VehiclesMapViewController: UIViewController, MKMapViewDelegate {

    // MARK:  - Outlets
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties
    
    private var filterPickerView: FilterPickerView!
    private var bounds: Bounds
    
    weak var delegate: VehiclesMapViewControllerDelegate?

    // MARK: - Computed Properties
    
    private var filterByFleetType: Fleet? {
        didSet {
            updateAnnotations()
        }
    }
    
    private var vehiclesMapViewModels: [VehicleMapViewModel] = [] {
        didSet {
            updateAnnotations()
        }
    }
    
    // MARK: - Init methods
    
    init(withBounds bounds: Bounds) {
        os_log(.info, log: .initialization, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        self.bounds = bounds
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        os_log(.info, log: .ui, "function: %s, line: %i, \nfile: %s", #function, #line, #file)

        setupFilterPickerView()
        centerMapOnLocation(locationWithCoordinates: [CLLocationCoordinate2D(latitude: bounds.firstPositionLatitude, longitude: bounds.firstPositionLongitude), CLLocationCoordinate2D(latitude: bounds.secondPositionLatitude, longitude: bounds.secondPositionLongitude)])
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
    
    private func updateAnnotations() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
                return
            }
            self.removeAnnotations()
            self.addAnnotations()
        }
    }
    
    private func setupFilterPickerView() {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)

        filterPickerView = FilterPickerView.fromNib()
        guard let filterPickerView = filterPickerView else {
            os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
            return
        }
        filterPickerView.translatesAutoresizingMaskIntoConstraints = false
        filterPickerView.delegate = self
        
        viewContainer.addSubview(filterPickerView)
        viewContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat : "H:|-(0)-[filterPickerView]-(0)-|", options: [], metrics: nil, views: ["filterPickerView" : filterPickerView]))
        viewContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat : "V:|[filterPickerView]|", options: [], metrics: nil, views: ["filterPickerView" : filterPickerView]))
    }
    
    private func centerMapOnLocation(locationWithCoordinates coordinates: [CLLocationCoordinate2D]) {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)

        let coordinateRegion = MKCoordinateRegion(coordinates: coordinates)
        mapView.setRegion(coordinateRegion, animated: false)
    }
    
    private func addAnnotations() {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)

        if let filterByFleetType = filterByFleetType {
            mapView.addAnnotations(vehiclesMapViewModels.filter { $0.fleetType == filterByFleetType})
        } else {
            mapView.addAnnotations(vehiclesMapViewModels)
        }
    }
    
    private func removeAnnotations() {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        mapView.removeAnnotations(mapView.annotations)
    }
    
    // MARK: - Action methods
    
    @IBAction func buttonShowListOfVehilclesLocatedInCurrentBounds(_ sender: UIButton) {
        os_log(.info, log: .action, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        delegate?.didTapShowInTheList(vehiclesMapViewModels: vehiclesMapViewModels, in: self)
    }
}

extension VehiclesMapViewController {
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        guard let viewModel = annotation as? VehicleMapViewModel else {
            os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: viewModel, reuseIdentifier: nil)
        annotationView.image = viewModel.vehicleImage
        annotationView.canShowCallout = true
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        os_log(.info, log: .action, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        bounds = mapView.bounds()
        let newCenterCoordinate2D = MKCoordinateRegion(coordinates: [CLLocationCoordinate2D(latitude: bounds.firstPositionLatitude, longitude: bounds.firstPositionLongitude), CLLocationCoordinate2D(latitude: bounds.secondPositionLatitude, longitude: bounds.secondPositionLongitude)]).center
        let newCenterCoordinate = Coordinate(latitude: newCenterCoordinate2D.latitude, longitude: newCenterCoordinate2D.longitude)
        delegate?.regionDidChange(toNewBounds: bounds, newCenter: newCenterCoordinate, vehiclesMapViewController: self)
    }
}

extension VehiclesMapViewController: FilterPickerViewDelegate {
    
    // MARK: - FilterPickerViewDelegate
    
    func indexChanged(toNewIndex index: Int) {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        filterByFleetType = Fleet.init(index)
    }
}

extension VehiclesMapViewController: VehiclesUpdatable {
    
    // MARK: - VehiclesUpdatable
    
    func update(vehiclesMapViewModels: [VehicleMapViewModel]) {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)

        self.vehiclesMapViewModels = vehiclesMapViewModels
    }
}
