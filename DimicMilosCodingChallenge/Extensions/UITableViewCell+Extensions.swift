//
//  UITableViewCell+Extensions.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/23/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    open class func reuseIdentifier() -> String {
        let descriptionParts = description().split(separator: ".")
        let finalResult = "DimicMilosCodingChallenge." + String(descriptionParts.last ?? "")
        return finalResult
    }
}
