//
//  WhiteCardView.swift
//  LAHacks 2020
//
//  Created by Matthew Krager on 3/28/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit

extension UIView {
    func addDropShadow() {
        layer.masksToBounds = false
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 25).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor

        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        shadowLayer.shadowOpacity = 0.25
        shadowLayer.shadowRadius = 10

        layer.insertSublayer(shadowLayer, at: 0)
    }
}

class WhiteCardView: UIView {
    
    private var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addDropShadow()
    }
}
