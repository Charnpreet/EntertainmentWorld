//
//  VideoViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 23/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
import YouTubePlayer
import AVFoundation
class VideoPlayerViewHolder: UIViewController, YouTubePlayerDelegate {
    var videoUrl : String?
        var player : YouTubePlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.layer.borderColor = UIColor.red.cgColor
        self.view.backgroundColor = .clear
        setUpVieoForYouTubePlayer()
        // Do any additional setup after loading the view.
    }
    func setUpVieoForYouTubePlayer(){
        player = YouTubePlayerView(frame: CGRect(x: 10, y: 20, width: Constants.IOS_SCREEN_WIDTH-20, height: Constants.IOS_SCREEN_HEIGHT/2))
        player.layer.borderWidth = 6
        player.layer.borderColor = UIColor.red.cgColor
        self.view.addSubview(player)
        guard let videoUrl = videoUrl else{return}
        player.loadVideoID(videoUrl)
        
    }

}
