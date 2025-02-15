//
//  BottomSheetViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 18/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
import YouTubePlayer
class BottomSheetViewController: UIViewController {
    var videoUrl : [String] = []
    var player : YouTubePlayerView!
    var table : CustomTable!
    var rating: Float!
    var totalVotes: String?
    var totalVideosLabel = UILabel(frame: Frames.TOTAL_VIDEOS_LABEL_FRAME_CG_REACT)
    fileprivate var totalVotesLabel = UILabel(frame: Frames.TOTAL_VOTES_LABEL_FRAME_CG_REACT)
    fileprivate var ratingLabel = UILabel(frame: Frames.RATING_LABEL_FRAME_CG_REACT)
    let cp = CircularAnimationView(frame: Frames.CIRCULAR_ANIMATION_VIEW_FRAME_CG_REACT)
    var playButton: UIButton!
    fileprivate var noVideButtonImage = UIImage(named: Constants.NO_PLAY_VIDEO_BUTTON_IMAGE)
    let fullView: CGFloat = Constants.IOS_SCREEN_HEIGHT/3
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 120
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        InitalSetup()
        roundViews()
    }
    func InitalSetup(){
        setUptopView()
        setUpPanGesture()
        setUpTableView()
        
    }
    
    //
    func setUptopView(){
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.IOS_SCREEN_WIDTH, height: 100))
        topView.backgroundColor = .clear
        setupButton(view: topView)
        setUplabel(view: topView)
        LoadCircularAnimation(view: topView)
        self.view.addSubview(topView)

    }
    //
    func setUplabel(view: UIView){
        guard let rating = rating else{return}
        //
        //
        labelsetup(label: ratingLabel, text: "\(rating)", view: view)
        guard let totalVotes = totalVotes else {return}
        //
        //
        labelsetup(label: totalVotesLabel, text: totalVotes, view: view)
        totalVotesLabel.font = UIFont.boldSystemFont(ofSize: 10)
        totalVideosLabel.textAlignment = .left
        
        labelsetup(label: totalVideosLabel, text: "0 videos", view: view) //
        totalVideosLabel.font = UIFont.boldSystemFont(ofSize: 10)
        totalVideosLabel.textAlignment = .left
    }
    
    func LoadCircularAnimation(view: UIView){
        cp.progressColor =  .red
           view.addSubview(cp)
           cp.LoadingBarAnimation(toValue: rating/10)
       }
    
    //
    //
    func setupButton(view: UIView){
        playButton = UIButton(frame: Frames.PLAY_VIDEO_BUTTON_FRAME_CG_REACT)
          guard let playButton = playButton else{return}
          playButton.backgroundColor = .clear
          playButton.setImage( noVideButtonImage, for: .normal)
          playButton.isUserInteractionEnabled = false
        playButton.addTarget(self, action: #selector(BottomSheetViewController.ExpandBottamViewSheet), for: .touchUpInside)
          view.addSubview(playButton)
      }
    //
    //
    fileprivate func labelsetup(label: UILabel, text: String, view: UIView){
        label.text = text
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.backgroundColor = .clear
        view.addSubview(label)
       }
    
    //
    //
    fileprivate func setUpPanGesture(){
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(BottomSheetViewController.panGesture))
        view.addGestureRecognizer(gesture)
    }
    //
    //
    fileprivate func setUpTableView(){
        let height = fullView+100
        let frame = CGRect(x: 0, y: 120, width: Constants.IOS_SCREEN_WIDTH, height: self.view.frame.height - height)
        table = CustomTable(frame: frame, style: .plain)
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: Constants.TABLE_VIEW_CELL_IDENTIFIER)
        self.table.dataSource = self
        self.table.delegate = self
        self.view.addSubview(table)
    }
    
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        let velocity = recognizer.velocity(in: self.view)

        
        if recognizer.state == .ended {
            UIView.animate(withDuration: 1.0, animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                } else {
                    self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                }
            })
        }
    }
    @objc func ExpandBottamViewSheet(){
        
        UIView.animate(withDuration: 0.9, animations: {
            self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
        })
        
    }
    func roundViews() {
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
    }
    
    func setUpVieoForYouTubePlayer(width: CGFloat, height: CGFloat) ->YouTubePlayerView{
        player = YouTubePlayerView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        return player
    }
    
    func prepareBackgroundView(){
        let blurEffect = UIBlurEffect.init(style: .dark)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        bluredView.alpha = 0.2
        view.insertSubview(bluredView, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        prepareBackgroundView()
        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame
            let yComponent = self?.partialView
            // force unrap needs to fixed
            // can crash your app
            self?.view.frame = CGRect(x: 0, y: yComponent!, width: frame!.width, height: frame!.height-85)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}
