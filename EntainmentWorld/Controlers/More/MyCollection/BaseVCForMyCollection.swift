//
//  BaseVCForMyCollection.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 21/5/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
class BaseVCForMyCollection: UIViewController {
    var segmentController : UISegmentedControl!
    lazy var myTvShowCollectionVC =
        UIStoryboard(name:"Mycollection", bundle: nil).instantiateViewController(withIdentifier: "tvShowCollectionVC")
    lazy var myMovieCollectionVC =
        UIStoryboard(name:"Mycollection", bundle: nil).instantiateViewController(withIdentifier: "MovieCollectionVC")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BackGroundColor.getBackgrndClr()
         initalSetup()
    }
    
    private func initalSetup(){
        UISegmentSetup()
        self.extendedLayoutIncludesOpaqueBars = true
        addViewControllerToParent(childVC: myMovieCollectionVC)
        addViewControllerToParent(childVC: myTvShowCollectionVC)
        if(segmentController.selectedSegmentIndex == 0){
            UpdateViews(VCToShow: myMovieCollectionVC, VCToHide: myTvShowCollectionVC)
        }
    }
    func UISegmentSetup() {
        let frame = CGRect(x: Constants.IOS_SCREEN_WIDTH/4, y: 0, width: Constants.IOS_SCREEN_WIDTH/2, height: Constants.IOS_SCREEN_HEIGHT/20)
        let segmentItems = ["Movies", "TV Shows"]
        segmentController = UISegement.getSegmentedControll(frame: frame, items: segmentItems, bgColr: .black, sitemTintClr: .white)
        segmentController.selectedSegmentIndex = 0
        segmentController.backgroundColor = BackGroundColor.getBackgrndClr()
        segmentController.addTarget(self, action: #selector(LoadChildVC), for: .valueChanged)
        self.navigationController?.navigationBar.addSubview(segmentController)
    }
    
    private func addViewControllerToParent(childVC: UIViewController){
        
        let frame = CGRect(x: 0, y: 90, width: Constants.IOS_SCREEN_WIDTH, height: view.frame.height)
        self.addChild(childVC)
        view.addSubview(childVC.view)
        childVC.view.frame = frame
        childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childVC.didMove(toParent: self)
        childVC.view.isHidden = true
    }
    
    
    private func UpdateViews(VCToShow: UIViewController, VCToHide: UIViewController){
        VCToShow.view.isHidden = false
        VCToHide.view.isHidden = true
    }
    
    @objc func LoadChildVC(){
        if(segmentController.selectedSegmentIndex == 0){
            UpdateViews(VCToShow: myMovieCollectionVC, VCToHide:  myTvShowCollectionVC)
        }
        if(segmentController.selectedSegmentIndex == 1){
            UpdateViews(VCToShow: myTvShowCollectionVC, VCToHide:  myMovieCollectionVC)
        }
        
    }
    
        override func viewWillAppear(_ animated: Bool) {
           segmentController.isHidden = false
        }
        override func viewWillDisappear(_ animated: Bool) {
            segmentController.isHidden = true
        }
        

}
