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
    var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showVideo()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    deinit {
        player?.pause()
        player = nil
        playerLayer = nil
        NotificationCenter.default.removeObserver(self)
    }
    func showVideo() {
        presentActivityView()
        VideoGenerator.current.generate(withImages: arrayOfImages, andAudios: [], andType: VideoGenerator.VideoGeneratorType.multiple, { (progress) in
            //
        }, success: { url in
            self.dismissActivityView()
            let asset = AVAsset(url: url)
            let item = AVPlayerItem(asset: asset)
            self.player = AVPlayer(playerItem: item)
            self.playerLayer = AVPlayerLayer(player: self.player)
            DispatchQueue.main.async {
                if let avPlayer = self.player, let pLayer = self.playerLayer {
                    pLayer.videoGravity = .resizeAspectFill
                    pLayer.frame = self.view.bounds
                    self.view.layer.addSublayer(pLayer)
                    avPlayer.play()
                    self.loopVideo(videoPlayer: avPlayer)
                }
            }
        }) { error in
            debugPrint("Video generator error: \(error)")
        }
    }
    func loopVideo(videoPlayer: AVPlayer) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
            videoPlayer.seek(to: CMTime.zero)
            videoPlayer.play()
        }
    }
}
