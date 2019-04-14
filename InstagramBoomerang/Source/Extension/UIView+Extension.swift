//
//  UIView+Extension.swift
//  IGBoomerang
//
//  Created by Boominadha Prakash on 09/04/19.
//  Copyright © 2019 DrawRect. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    private static let kRotationAnimationKey = "rotationanimationkey"
    func startRotating(withDuration duration: Double = 1) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }
    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
    func makeRound(with cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.clipsToBounds = true
    }
    func addGradientLayer(with cornerRadius: CGFloat, lineWidth: CGFloat) {
        //Remove if there are any layer properties
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0
        
        //Apply gradient layer
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: .zero, size: self.frame.size)
        gradient.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        
        let shape = CAShapeLayer()
        shape.lineWidth = lineWidth
        shape.path = UIBezierPath(rect: self.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        gradient.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.addSublayer(gradient)
    }
}
