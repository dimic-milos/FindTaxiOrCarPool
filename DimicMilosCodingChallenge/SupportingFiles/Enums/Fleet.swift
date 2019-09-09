//
//  Fleet.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/23/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//
import os
import UIKit

enum Fleet: String {
    
    case pooling
    case taxi
    
    var image: UIImage {
        switch self {
            
        case .pooling:
            return Image.carPool
        case .taxi:
            return Image.taxi
        }
    }
    
    var description: String {
        switch self {
            
        case .pooling:
            return self.rawValue.uppercased()
        case .taxi:
            return self.rawValue.uppercased()
        }
    }
    
    init?(_ index: Int) {
        os_log(.info, log: .initialization, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        switch index {
            
        case 1:
            self = .taxi
        case 2:
            self = .pooling
        default:
            return nil
        }            
    }
}
