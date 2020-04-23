//
//  BottomSheetViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 18/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
class BottomSheetViewController: UIViewController {
    var rating: Float!
    var videoUrl : String?
    var hasVideo : Bool!
    fileprivate var voteLabel = UILabel(frame: CGRect(x: 15, y: 20, width: 40, height: 30))
    let cp = CircularAnimationView(frame: CGRect(x: 10, y: 20, width: 50, height: 30))
    fileprivate var buttonImage = UIImage(named: "play")
    fileprivate var noVideButtonImage = UIImage(named: "noPlay")
    let fullView: CGFloat = 10
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 80
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        InitalSetup()
        LoadCircularAnimation()
        cp.LoadingBarAnimation(toValue: rating/10)
    }
    
    func InitalSetup(){
        setupButton()
        setUplabel()
    }
    func LoadCircularAnimation(){
        cp.progressColor =  .systemPink
        view.addSubview(cp)
    }
    func setupButton(){
        let button = UIButton(frame: CGRect(x: Constants.IOS_SCREEN_WIDTH-60, y: 15, width: 40, height: 40))
        button.backgroundColor = .clear
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(PlayVideo), for: .touchUpInside)
        view.addSubview(button)
    }
    @objc func PlayVideo(){
        if let mvc = UIStoryboard(name: "VideoPlayerViewHolder", bundle: nil).instantiateViewController(withIdentifier: "VideoPlayerViewHolder") as? VideoPlayerViewHolder {
            mvc.videoUrl = self.videoUrl
            self.present(mvc, animated: true, completion: nil)
        }
    }
    //
    func setUplabel(){
        voteLabel.text = "\(rating ?? 0.0)"
        voteLabel.textAlignment = .center
        voteLabel.textColor = .white
        voteLabel.font = UIFont.boldSystemFont(ofSize: 16)
        voteLabel.backgroundColor = .clear
        view.addSubview(voteLabel)
    }
    
    func prepareBackgroundView(){
        //view.backgroundColor = .clear
        let blurEffect = UIBlurEffect.init(style: .systemThinMaterialDark)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        //  bluredView.contentView.addSubview(visualEffect)
        visualEffect.backgroundColor = UIColor.black
        visualEffect.isOpaque  = false
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        
        view.insertSubview(bluredView, at: 0)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        prepareBackgroundView()
        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame
            let yComponent = self?.partialView
            self?.view.frame = CGRect(x: 0, y: yComponent!, width: frame!.width, height: frame!.height-100)
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
