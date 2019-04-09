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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraManager.resumeCaptureSession()
        statusBarShouldBeHidden = true
        UIView.animate(withDuration: 0.25) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
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
}
