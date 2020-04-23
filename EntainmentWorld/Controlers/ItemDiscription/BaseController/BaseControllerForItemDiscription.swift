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
    var item: T!
    var navBarImg: UIImage!
    var firstLabel :  UILabel!
    var videos : [VideoDetails] = []
    var bottomSheetVC : BottomSheetViewController!
    let db =  DBConnection()
    @IBOutlet var backGroundImage: UIImageView! = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        loadImage()
        // Do any additional setup after loading the view.
    }
    
    func loadImage(){
        
    }
    
    func loadVideo(){
     }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        ClearNavigationBar()
              //loadVideo()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        firstLabel.removeFromSuperview()
    }
    public func AddLabelToNavigationBar(){
        let firstFrame = CGRect(x: 0, y: 0, width: Constants.IOS_SCREEN_WIDTH, height: navigationController?.navigationBar.frame.height ?? 40)
        firstLabel = UILabel(frame: firstFrame)
        firstLabel.textAlignment = .center
        firstLabel.textColor = .white
        self.navigationController?.navigationBar.addSubview(firstLabel)
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    fileprivate func ClearNavigationBar(){
        navBarImg = UIImage()
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.95
        self.navigationController?.navigationBar.setBackgroundImage(navBarImg, for: .default)
        self.navigationController?.navigationBar.shadowImage = navBarImg
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
}
