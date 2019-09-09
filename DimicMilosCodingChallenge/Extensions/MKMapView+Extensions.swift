//
//  MKMapView+Extensions.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/24/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import MapKit

extension MKMapView {
    
    func bounds() -> Bounds {
        let nePoint = CGPoint(x: self.bounds.maxX, y: self.bounds.origin.y)
        let swPoint = CGPoint(x: self.bounds.minX, y: self.bounds.maxY)
        let neCoord = self.convert(nePoint, toCoordinateFrom: self)
        let swCoord = self.convert(swPoint, toCoordinateFrom: self)
        return Bounds(firstPositionLatitude: neCoord.latitude, firstPositionLongitude: neCoord.longitude, secondPositionLatitude: swCoord.latitude, secondPositionLongitude: swCoord.longitude)
    }
}
