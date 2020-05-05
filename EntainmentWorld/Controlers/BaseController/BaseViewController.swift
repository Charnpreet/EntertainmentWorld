//
//  BaseViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 20/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
//
// base controller for Tv and Movie Shows
// both will inhrit common properties from it
class BaseViewController: UIViewController {
    var table : CustomTable!
    var safeArea: UILayoutGuide!
    var noNetworkView: UIView!
    var nBarHeight: CGFloat?
    var tBarHeight: CGFloat?
    override func viewDidLoad() {
        super.viewDidLoad()
        intialSetup()
    }
    // inital setup for Movies controller
    func intialSetup(){
        setUptable()
        navigationBarSetUp()
       noNetworkViewSetup()
    }
    
    public func noNetworkViewSetup(){
        noNetworkView   = NoNetworkViews.getNoNetworkViews()
        self.view.addSubview(noNetworkView)
    }
    //setup table view
    func setUptable(){
        let frame = Frames.BASE_VC_TABLE_FRAME_CG_REACT 
        table = CustomTable(frame: frame, style: .plain)
        guard let table = table else{return}
        view.addSubview(table)
        addConstraintsToTable(view: view, table : table)
        self.table.rowHeight = Constants.IOS_SCREEN_HEIGHT/5
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarSetUp()
        navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.tintColor = UIColor.red
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    func navigationBarSetUp(){
        navigationController?.navigationBar.barTintColor = BackGroundColor.getBackgrndClr()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :BackGroundColor.textColor()]
    }
    func addConstraintsToTable(view: UIView, table : CustomTable){
        safeArea = view.layoutMarginsGuide
        guard let safeArea = safeArea  else{return}
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}


