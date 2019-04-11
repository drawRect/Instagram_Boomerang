//
//  BVCameraPreviewController.swift
//  Instagram_Boomerang
//
//  Created by Boominadha Prakash on 09/04/19.
//  Copyright © 2019 DrawRect. All rights reserved.
//

import UIKit
import AVKit

class IGCameraPreviewController: UIViewController, ActivityViewPresenter {
    
    var arrayOfImages: [UIImage] = []
    lazy var imageView: UIImageView = {
        let iv = UIImageView(frame: self.view.frame)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(imageView)
        showAnimatedImages()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        imageView.stopAnimating()
    }
    func showAnimatedImages() {
        let totalImages = arrayOfImages + arrayOfImages.reversed()
        let animatedImages = UIImage.animatedImage(with: totalImages, duration: 1.0)
        imageView.image = animatedImages
        imageView.startAnimating()
    }
}
