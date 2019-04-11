//
//  ActivityViewPresenter.swift
//  Instagram_Boomerang
//
//  Created by Boominadha Prakash on 11/04/19.
//  Copyright © 2019 DrawRect. All rights reserved.
//

import Foundation
import UIKit

protocol ActivityViewPresenter {
    func presentActivityView()
    func dismissActivityView()
}

extension ActivityViewPresenter where Self: UIViewController {
    var popUpViewTagValue: Int {
        return 1000
    }
    
    var keyWindow: UIWindow {
        return UIApplication.shared.keyWindow!
    }
    
    func presentActivityView() {
        let activityView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.center = keyWindow.center
        activityView.startAnimating()
        
        let popUpView = UIView(frame: CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: keyWindow.frame.height))
        popUpView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        popUpView.addSubview(activityView)
        popUpView.tag = popUpViewTagValue
        keyWindow.addSubview(popUpView)
    }
    func dismissActivityView() {
        if let popUpView = keyWindow.subviews.filter({$0.tag == popUpViewTagValue}).first {
            popUpView.removeFromSuperview()
        }
    }
}

