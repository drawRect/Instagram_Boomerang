//
//  IGCameraView.swift
//  IGBoomerang
//
//  Created by Sonata on 09/04/19.
//  Copyright © 2019 DrawRect. All rights reserved.
//

import Foundation
import UIKit

class BVCameraView: UIView {
    
    //MARK: - iVars
    lazy var cameraView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .black
        return cv
    }()
    lazy var bottomView: UIView = {
        let bv = UIView()
        bv.translatesAutoresizingMaskIntoConstraints = false
        bv.backgroundColor = UIColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 1.0)
        return bv
    }()
    lazy var cameraButtonView: UIView = {
        let cbv = UIView()
        cbv.backgroundColor = .clear
        cbv.translatesAutoresizingMaskIntoConstraints = false
        return cbv
    }()
    lazy var cameraButton: UIButton = {
        let cb = UIButton(type: .custom)
        cb.backgroundColor = .white
        cb.setTitle("", for: .normal)
        cb.translatesAutoresizingMaskIntoConstraints = false
        return cb
    }()
    
    //MARK: - Init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUIElements()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUIElements()
    }
    override func layoutSubviews() {
        cameraButtonView.makeRound(with: cameraButtonView.frame.width/2, borderWidth: 3, borderColor: .white)
        cameraButton.makeRound(with: cameraButton.frame.width/2, borderWidth: 0, borderColor: .clear)
    }
    
    //Mark: - Private methods
    private func setUpUIElements() {
        self.addSubview(cameraView)
        cameraButtonView.addSubview(cameraButton)
        bottomView.addSubview(cameraButtonView)
        addSubview(bottomView)
        setUpConstraints()
    }
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            cameraView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cameraView.topAnchor.constraint(equalTo: topAnchor),
            trailingAnchor.constraint(equalTo: cameraView.trailingAnchor),
            bottomView.topAnchor.constraint(equalTo: cameraView.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.topAnchor.constraint(equalTo: cameraView.bottomAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 70)
            ])
        NSLayoutConstraint.activate([
            cameraButtonView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            cameraButtonView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            cameraButtonView.widthAnchor.constraint(equalToConstant: 65),
            cameraButtonView.heightAnchor.constraint(equalToConstant: 65)
            ])
        NSLayoutConstraint.activate([
            cameraButton.centerXAnchor.constraint(equalTo: cameraButtonView.centerXAnchor),
            cameraButton.centerYAnchor.constraint(equalTo: cameraButtonView.centerYAnchor),
            cameraButton.widthAnchor.constraint(equalToConstant: 57),
            cameraButton.heightAnchor.constraint(equalToConstant: 57)
            ])
    }
}
