//
//  BVCameraPreviewController.swift
//  BoomerangVideo
//
//  Created by Boominadha Prakash on 09/04/19.
//  Copyright © 2019 DrawRect. All rights reserved.
//

import UIKit

class BVCameraPreviewController: UIViewController {

    var arrayOfImages: [UIImage] = []
    lazy var imageView: UIImageView = {
        let iv = UIImageView(frame: self.view.frame)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let animatedImage = UIImage.animatedImage(with: arrayOfImages, duration: 0.5)
        imageView.image = animatedImage
        self.view.addSubview(imageView)
        imageView.startAnimating()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        imageView.stopAnimating()
    }
}
