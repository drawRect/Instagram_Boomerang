//
//  BVCameraController.swift
//  BoomerangVideo
//
//  Created by Boominadha Prakash on 09/04/19.
//  Copyright © 2019 DrawRect. All rights reserved.
//

import UIKit

class BVCameraController: UIViewController {

    let bvCameraView = BVCameraView(frame: UIScreen.main.bounds)
    lazy var cameraManager: CameraManager = {
        let cm = CameraManager()
        cm.shouldEnableExposure = true
        cm.shouldFlipFrontCameraImage = false
        cm.showAccessPermissionPopupAutomatically = false
        cm.cameraOutputQuality = CameraOutputQuality.high
        cm.flashMode = CameraFlashMode.auto
        cm.burstModeEnabled = true
        cm.burstModePictureCount = 4
        return cm
    }()
    var statusBarShouldBeHidden = false
    
    override func loadView() {
        view = bvCameraView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cameraStatusCheck()
        bvCameraView.cameraButton.addTarget(self, action: #selector(takePicture(sender:)), for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        cameraManager.resumeCaptureSession()
        statusBarShouldBeHidden = true
        UIView.animate(withDuration: 0.25) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.setNeedsLayout()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        cameraManager.stopCaptureSession()
    }
//    override func viewDidLayoutSubviews() {
//        bvCameraView.cameraButtonView.makeRound(with: bvCameraView.cameraButtonView.frame.width/2, borderWidth: 3, borderColor: .white)
//        bvCameraView.cameraButton.makeRound(with: bvCameraView.cameraButton.frame.width/2, borderWidth: 0, borderColor: .clear)
//    }
    deinit {
        if cameraManager.captureSession?.isRunning == true {
            cameraManager.stopCaptureSession()
        }
    }
    override var prefersStatusBarHidden: Bool {
        return statusBarShouldBeHidden
    }
}

extension BVCameraController {
    func cameraStatusCheck() {
        switch cameraManager.currentCameraStatus() {
        case .notDetermined:
            askCameraPermission()
        case .ready:
            addCamera()
        default:
            askCameraPermission()
        }
    }
    func askCameraPermission() {
        cameraManager.askUserForCameraPermission({ permissionGranted in
            if permissionGranted {
                self.addCamera()
            } else {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                } else {
                    // Fallback on earlier versions
                }
            }
        })
    }
    func addCamera() {
        cameraManager.addPreviewLayerToView(bvCameraView.cameraView, newCameraOutputMode: CameraOutputMode.stillImage)
    }
    @objc func takePicture(sender: UIButton) {
        switch cameraManager.cameraOutputMode {
        case .stillImage:
            cameraManager.capturePictureWithCompletion { (result) in
                switch result {
                case .failure(let error):
                    self.cameraManager.showErrorBlock("Error occurred", "\(error)")
                case .success(content: let content):
                    if let imageArray = content.asArrayOfImages {
                        DispatchQueue.main.async {
                            let cameraPreviewVC = BVCameraPreviewController()
                            cameraPreviewVC.arrayOfImages = imageArray
                            self.navigationController?.pushViewController(cameraPreviewVC, animated: false)
                        }
                    }
                }
            }
        default:
            break
        }
    }
}
