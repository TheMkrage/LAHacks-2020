//
//  FeedbackViewController.swift
//  LAHacks 2020
//
//  Created by Matthew Krager on 3/28/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var feedback1: UILabel!
    @IBOutlet weak var feedback2Label: UILabel!
    
    var question: String!
    var feedback: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = question
        feedback1.text = feedback.first ?? ""
        feedback2Label.text = feedback.count > 1 ? feedback[1] : ""
    }
}
