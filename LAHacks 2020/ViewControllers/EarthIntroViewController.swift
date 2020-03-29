//
//  EarthIntroViewController.swift
//  LAHacks 2020
//
//  Created by Matthew Krager on 3/27/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit
import SwiftyGif

class EarthIntroViewController: UIViewController {

    @IBOutlet weak var earthyImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let gif = try UIImage(gifName: "earthy")
            earthyImageView.setGifImage(gif)
        } catch {
            print(error)
        }
        
        // Initialize gradient layer.
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        // UIColor.init(hex: "854DFF")
        // .init(hex: "2C1A55")
        gradientLayer.colors = [UIColor.red, UIColor.green]

        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: view.bounds.height)

        // Insert gradient layer into view's layer heirarchy.
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
