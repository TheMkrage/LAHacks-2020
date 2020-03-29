//
//  LanguagePickViewController.swift
//  LAHacks 2020
//
//  Created by Matthew Krager on 3/27/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit

class LanguagePickViewController: UIViewController {

    @IBOutlet weak var countryLabel: UILabel!
    var activeButton: UIButton?
    
    private func activateBorder() {
        activeButton?.borderWidth = 6
        activeButton?.borderColor = UIColor.init(named: "Jobbo Flag Corner")
        activeButton?.cornerRadius = 15
    }
    
    @IBAction func pickMexico(_ sender: UIButton) {
        countryLabel.text = "Mexico"
        activeButton?.borderWidth = 0
        activeButton = sender
        activateBorder()
        NetworkingStore.shared.language = Languages.spanish.rawValue
    }
    @IBAction func pickChina(_ sender: UIButton) {
        countryLabel.text = "China"
        activeButton?.borderWidth = 0
        activeButton = sender
        activateBorder()
        NetworkingStore.shared.language = Languages.chinese.rawValue
    }
    @IBAction func pickFrance(_ sender: UIButton) {
        countryLabel.text = "France"
        activeButton?.borderWidth = 0
        activeButton = sender
        activateBorder()
        NetworkingStore.shared.language = Languages.french.rawValue
    }
    @IBAction func pickSpain(_ sender: UIButton) {
        countryLabel.text = "Spain"
        activeButton?.borderWidth = 0
        activeButton = sender
        activateBorder()
        NetworkingStore.shared.language = Languages.spanish.rawValue
    }
    @IBAction func pickJapan(_ sender: UIButton) {
        countryLabel.text = "Japan"
        activeButton?.borderWidth = 0
        activeButton = sender
        activateBorder()
        NetworkingStore.shared.language = Languages.japanese.rawValue
    }
    @IBAction func pickIndia(_ sender: UIButton) {
        countryLabel.text = "India"
        activeButton?.borderWidth = 0
        activeButton = sender
        activateBorder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
