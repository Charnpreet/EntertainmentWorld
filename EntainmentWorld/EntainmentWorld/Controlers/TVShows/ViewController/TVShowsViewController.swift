//
//  TVShowsViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 14/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class TVShowsViewController: UIViewController{
     var dataprovider: DataSourceProviderForTable!
    var table : CustomTable!
    var safeArea: UILayoutGuide!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    // MARK:- inital setup for view controller
    func  initialSetup(){
        setupTable()
        dataprovider = DataSourceProviderForTable()
        table.dataSource = dataprovider
        table.delegate = dataprovider
        navigationBarSetUp()
    }
     // MARK:- INITILIZING TABLE
    func setupTable(){
        let frame = CGRect(x: 0, y: 0, width: Constants.IOS_SCREEN_WIDTH, height: Constants.IOS_SCREEN_HEIGHT)
        table = CustomTable(frame: frame, style: .plain)
        table.register(TVTableViewCell.self, forCellReuseIdentifier: Constants.TABLE_VIEW_CELL_IDENTIFIER)
        view.addSubview(table)
        TableConstraints.addConstraintsToTable(view: view, table : table)
        self.table.rowHeight = Constants.IOS_SCREEN_HEIGHT/5
    }
    
       // MARK:- set up for navigation bar controller
    func navigationBarSetUp(){
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.topItem?.title = "TV Shows"
    }
}

