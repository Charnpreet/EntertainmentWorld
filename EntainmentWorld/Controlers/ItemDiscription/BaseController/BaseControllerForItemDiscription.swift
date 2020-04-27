//
//  BaseControllerForItemDiscription.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 23/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
class BaseControllerForItemDiscription<T> : UIViewController {
        fileprivate var noVideButtonImage = UIImage(named: "noPlay")
        fileprivate var buttonImage = UIImage(named: "play")
    var item: T!
    var navBarImg: UIImage!
    var firstLabel :  UILabel!
    var titleTextLabel : UILabel!
    var videos : [VideoDetails] = []
    var bottomSheetVC : BottomSheetViewController!
    let db =  DBConnection()
    @IBOutlet var backGroundImage: UIImageView! = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        SetUpTitleLabel()
    }
    
    func loadImage(){
        
    }
    
    func loadVideo(){
     }
    
     func playButtonState(){
           if(self.bottomSheetVC.videoUrl.count>0){
               guard let button = self.bottomSheetVC.playButton else{return}
               button.setImage(self.buttonImage, for: .normal)
                button.isUserInteractionEnabled = true
           }
       }
    fileprivate func SetUpTitleLabel(){
        titleTextLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Constants.IOS_SCREEN_WIDTH, height: 40))
        titleTextLabel.textAlignment = .center
        titleTextLabel.textColor =  .white
        self.view.addSubview(titleTextLabel)
        titleTextLabel.center = self.view.center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        ClearNavigationBar()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        firstLabel.removeFromSuperview()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    public func AddLabelToNavigationBar(){
        let firstFrame = CGRect(x: 0, y: 0, width: Constants.IOS_SCREEN_WIDTH, height: navigationController?.navigationBar.frame.height ?? 40)
        firstLabel = UILabel(frame: firstFrame)
        firstLabel.textAlignment = .center
        firstLabel.textColor = .white
        guard let firstLabel = firstLabel else {return}
        self.navigationController?.navigationBar.addSubview(firstLabel)
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    fileprivate func ClearNavigationBar(){
        navBarImg = UIImage()
        guard let navBarImg = navBarImg else {return}
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.95
        self.navigationController?.navigationBar.setBackgroundImage(navBarImg, for: .default)
        self.navigationController?.navigationBar.shadowImage = navBarImg
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
}
