//
//  Direction.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/23/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import os

struct VehicleDirection {
    
    private enum Direction: String {
        case n
        case nne
        case ne
        case ene
        case e
        case ese
        case se
        case sse
        case s
        case ssw
        case sw
        case wsw
        case w
        case wnw
        case nw
        case nnw
    }
    
    // MARK: -  Properties
    
    private var direction: Direction!
    
    // MARK: -  Computed Properties
    
    var name: String {
        return direction.rawValue.uppercased()
    }
    
    // MARK: -  Init
    
    init?(angle: Double) {
        os_log(.info, log: .frequent, "function: %s, line: %i, \nfile: %s", #function, #line, #file)

        guard let direction = getDirection(fromAngle: angle) else {
            os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
            return nil
        }
        self.direction = direction
    }
    
    // MARK: - Private methods
    
    private func getDirection(fromAngle angle: Double) -> Direction? {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
        
        
        switch angle.rounded() {
            
        case 349...360:
            return .n
        case 0...11:
            return .n
        case 12...33:
            return .nne
        case 34...56:
            return .ne
        case 57...78:
            return .ene
        case 79...101:
            return .e
        case 102...123:
            return .ese
        case 124...146:
            return .se
        case 147...168:
            return .sse
        case 169...191:
            return .s
        case 192...213:
            return .ssw
        case 214...236:
            return .sw
        case 237...258:
            return .wsw
        case 259...281:
            return .w
        case 282...303:
            return .wnw
        case 304...326:
            return .nw
        case 327...348:
            return .nnw
        default:
            os_log(.error, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)
            return nil
        }
    }
}
