//
//  IGCameraController.swift
//  Instagram_Boomerang
//
//  Created by Boominadha Prakash on 09/04/19.
//  Copyright © 2019 DrawRect. All rights reserved.
//

import UIKit

class IGCameraController: UIViewController, CaptureBurstModeDelegate {
    
    let igCameraView = IGCameraView(frame: UIScreen.main.bounds)
    lazy var cameraManager: CameraManager = {
        let cm = CameraManager()
        cm.shouldEnableExposure = true
        cm.shouldFlipFrontCameraImage = false
        cm.showAccessPermissionPopupAutomatically = false
        cm.cameraOutputQuality = CameraOutputQuality.high
        cm.flashMode = CameraFlashMode.auto
        cm.burstModeEnabled = true
        return cm
    }()
    var statusBarShouldBeHidden = false
    
    override func loadView() {
        view = igCameraView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cameraStatusCheck()
        igCameraView.cameraButton.addTarget(self, action: #selector(takePicture(sender:)), for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        igCameraView.cameraButton.isEnabled = true
        cameraManager.captureBurstModeDelegate = self
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
        igCameraView.cameraButtonView.stopRotating()
        cameraManager.stopCaptureSession()
    }
    deinit {
        if cameraManager.captureSession?.isRunning == true {
            cameraManager.stopCaptureSession()
        }
    }
    override var prefersStatusBarHidden: Bool {
        return statusBarShouldBeHidden
    }
    
    func didBurstModeComplete(resultImages: [UIImage]) {
        DispatchQueue.main.async {
            let cameraPreviewVC = IGCameraPreviewController()
            cameraPreviewVC.arrayOfImages = resultImages
            self.navigationController?.pushViewController(cameraPreviewVC, animated: false)
        }
    }
}

extension IGCameraController {
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
        cameraManager.addPreviewLayerToView(igCameraView.cameraView, newCameraOutputMode: CameraOutputMode.stillImage)
    }
    @objc func takePicture(sender: UIButton) {
        self.igCameraView.cameraButton.isEnabled = false
        self.igCameraView.cameraButtonView.addGradientLayer(with: self.igCameraView.cameraButtonView.frame.width/2, lineWidth: 4)
        self.igCameraView.cameraButtonView.startRotating()
        switch cameraManager.cameraOutputMode {
        case .stillImage:
            cameraManager.capturePictureWithBurstMode()
        default:
            break
        }
    }
}
