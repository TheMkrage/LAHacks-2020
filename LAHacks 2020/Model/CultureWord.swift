//
//  CultureWord.swift
//  LAHacks 2020
//
//  Created by Matthew Krager on 3/28/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit

class CultureWord: NSObject {

    var word: String
    var definition: String
    
    init(definition: String, word: String) {
        self.definition = definition
        self.word = word
    }
}
