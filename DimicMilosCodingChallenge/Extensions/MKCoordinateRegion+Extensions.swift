//
//  MKCoordinateRegion+Extensions.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/24/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import MapKit

extension MKCoordinateRegion {
    
    init(coordinates: [CLLocationCoordinate2D]) {
        var minLatitude: CLLocationDegrees = 90.0
        var maxLatitude: CLLocationDegrees = -90.0
        var minLongitude: CLLocationDegrees = 180.0
        var maxLongitude: CLLocationDegrees = -180.0
        
        coordinates.forEach {
            
            let latitude = $0.latitude
            let longitude = $0.longitude
            
            if latitude < minLatitude {
                minLatitude = latitude
            }
            if longitude < minLongitude {
                minLongitude = longitude
            }
            if latitude > maxLatitude {
                maxLatitude = latitude
            }
            if longitude > maxLongitude {
                maxLongitude = longitude
            }
        }
        
        let span = MKCoordinateSpan(latitudeDelta: maxLatitude - minLatitude, longitudeDelta: maxLongitude - minLongitude)
        let center = CLLocationCoordinate2DMake((maxLatitude - span.latitudeDelta / 2), (maxLongitude - span.longitudeDelta / 2))
        self.init(center: center, span: span)
    }
}
