//
//  CultureTip.swift
//  LAHacks 2020
//
//  Created by Matthew Krager on 3/27/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit

class CultureTip: NSObject {
    var tip: String
    var language: Languages
    
    init(language: Languages, tip: String) {
        self.language = language
        self.tip = tip
    }
}
