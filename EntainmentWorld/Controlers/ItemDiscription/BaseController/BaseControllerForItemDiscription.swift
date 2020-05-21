//
//  BaseControllerForItemDiscription.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 23/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//
import Foundation
import UIKit
//UIViewController
class BaseControllerForItemDiscription<T> : UIViewController{
    var persistentManager: PersistentDataManager?
    fileprivate var noVideButtonImage = UIImage(named: Constants.NO_PLAY_VIDEO_BUTTON_IMAGE)
    fileprivate var buttonImage = UIImage(named: Constants.PLAY_VIDEO_BUTTON_IMAGE)
    var item: T!
    let favImage = UIImage(named: "fav")
    let favImageSelected = UIImage(named: "favSaved")
    var navBarImg: UIImage!
    var noNetworkView: UIView!
    var favMovie : Bool = false
    var titleTextLabel : UILabel!
    var videos : [VideoDetails] = []
    var bottomSheetVC : BottomSheetViewController!
    let db =  DBConnection()
    @IBOutlet var backGroundImage: UIImageView! = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BackGroundColor.getBackgrndClr()
        SetUpTitleLabel()
    }
    
    func CustomizingNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"", style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped(){
        
    }
    
    private func startAnimation(UiView: UIView, label: UILabel){
        UiView.frame = CGRect(x: 10, y: 90, width: Constants.IOS_SCREEN_WIDTH - 20, height: 50)
          label.frame = CGRect(x: 0, y: 0, width: UiView.frame.width, height: UiView.frame.height)
             self.view.layoutIfNeeded()
    }
    private func stopAnimation(UiView: UIView){
        UiView.transform = CGAffineTransform(scaleX: 1, y: 0.00001)
          self.view.layoutIfNeeded()
    }
    
    private func removeViews(UiView: UIView, label: UILabel){
        label.removeFromSuperview()
        UiView.removeFromSuperview()
    }
    // added fav view
    // this should we visible only when user click on add to fav collection icon
    func DisplayView(text: String, clr : UIColor){
        let UiView = UIView(frame: CGRect(x: 10, y: 90, width: Constants.IOS_SCREEN_WIDTH - 20, height: 0))
        let label = UILabel()
        label.textColor = .white
        UiView.addSubview(label)
        label.textAlignment = .center
        self.view.addSubview(UiView)
        UiView.backgroundColor = clr
        UiView.layer.borderColor = UIColor.red.cgColor
        label.text = text
        UIView.animate(withDuration: 0.6, delay: 0.0, options: .curveEaseInOut, animations: {
            self.startAnimation(UiView: UiView, label: label)
          }, completion:{
            _ in UIView.animate(withDuration: 1.6, delay: 0.0, options: .curveEaseInOut, animations: {
                 self.stopAnimation(UiView:UiView)
            }, completion: { _ in
                self.removeViews(UiView: UiView, label: label)
            })
          })
    }
    //
    public func noNetworkViewSetup(){
        noNetworkView   = NoNetworkViews.getNoNetworkViews()
        self.view.addSubview(noNetworkView)
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
        titleTextLabel = UILabel(frame: Frames.TITLE_TEXT_LABEL_FRAME_CG_REACT_FOR_ITEM_DISC_VC)
        titleTextLabel.textAlignment = .center
        titleTextLabel.textColor =  .white
        self.view.addSubview(titleTextLabel)
        titleTextLabel.center = self.view.center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        persistentManager = PersistentDataManager.shared
        ClearNavigationBar()
        CustomizingNavigationBar()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
    }
    public func AddLabelToNavigationBar(){
        self.navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
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
