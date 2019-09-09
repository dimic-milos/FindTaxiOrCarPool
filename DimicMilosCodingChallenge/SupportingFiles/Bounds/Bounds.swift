//
//  Bounds.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/23/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import os

struct Bounds: Equatable {
    
    // MARK: - Properties
    
    let firstPositionLatitude: Double
    let firstPositionLongitude: Double
    
    let secondPositionLatitude: Double
    let secondPositionLongitude: Double
    
    // MARK: - Init
    
    init(firstPositionLatitude: Double, firstPositionLongitude: Double, secondPositionLatitude: Double, secondPositionLongitude: Double) {
        os_log(.info, log: .initialization, "function: %s, line: %i, \nfile: %s", #function, #line, #file)

        self.firstPositionLatitude = firstPositionLatitude
        self.firstPositionLongitude = firstPositionLongitude
        self.secondPositionLatitude = secondPositionLatitude
        self.secondPositionLongitude = secondPositionLongitude
    }
    
    // MARK: - Computed properties
    
    var firstPositionLatitudeString: String {
        return String(firstPositionLatitude)
    }
    var firstPositionLongitudeString: String {
        return String(firstPositionLongitude)
    }
    
    var secondPositionLatitudeString: String{
        return String(secondPositionLatitude)
    }
    
    var secondPositionLongitudeString: String {
        return String(secondPositionLongitude)
    }
}
