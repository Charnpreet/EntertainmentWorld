//
//  BaseVCForAll.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 5/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class BaseVCForAll: UIViewController {
    var safeArea: UILayoutGuide!
    var netWork : NetworkConnectivity!
    var noNetworkView: UIView!
    var alertView : UIView?
    var alertLabel: UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BackGroundColor.getBackgrndClr()
        setupAlertView()

        // Do any additional setup after loading the view.
    }
    func NoNetWorkStartMonitoring(){
          netWork = NetworkConnectivity.shared
         noNetworkViewSetup()
         netWork.startMonitoring(completionHandler: {(netWorkAviailbe: Bool) in
             if(!netWorkAviailbe){
                 self.LoadNoNetworkView(UiView: self.noNetworkView)
             }else{
                self.noNetworkView.isHidden = true
            }
         })
     }
    func displayAlert(textToDisplay: String){
        guard let alertView = alertView else {return}
        alertView.isHidden = false
        self.view.bringSubviewToFront(alertView)
        guard let alertLabel = alertLabel else{return}
        alertLabel.text = textToDisplay
    }
    func setupAlertView(){
        alertView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.IOS_SCREEN_WIDTH, height: Constants.IOS_SCREEN_HEIGHT))
        guard let alertView = alertView else {return}
        alertView.backgroundColor = BackGroundColor.getBackgrndClr()
        alertLabel = UILabel()
        guard let alertLabel = alertLabel else {return}
        alertLabel.frame.size = alertView.frame.size
        alertView.addSubview(alertLabel)
        alertLabel.textColor = BackGroundColor.textColor()
        alertLabel.textAlignment = .center
        alertView.isHidden = true
        self.view.addSubview(alertView)
    }
     
     func LoadNoNetworkView(UiView: UIView){
        UiView.isHidden = false
        NoNetworkViews.AnimateNoNetworkViews(viewNeedtedToBeAnimated: UiView, parentView: self.view, position: 0.0)
        }
     
     public func noNetworkViewSetup(){
         safeArea = view.layoutMarginsGuide
         noNetworkView   = NoNetworkViews.getNoNetworkViews()
         self.view.addSubview(noNetworkView)
        guard let safeArea = safeArea  else{return}
        noNetworkView.translatesAutoresizingMaskIntoConstraints = false
        noNetworkView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        noNetworkView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        noNetworkView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        noNetworkView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NoNetWorkStartMonitoring()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        noNetworkView.removeFromSuperview()
    }
}
