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
    func makeRound(with cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.clipsToBounds = true
    }
}
