//
//  MovieViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 7/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
class MovieViewController: UIViewController {
    var table : UITableView!
    var safeArea: UILayoutGuide!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        // Do any additional setup after loading the view.
        intialSetup()
        
    }
    // adding constraints to table
    func addConstraintsToTable(){
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    //setup table view
    func setUptable(){
    safeArea = view.layoutMarginsGuide
    table = UITable.getUITable() as UITableView
    table.backgroundColor = .white
    table.rowHeight = CGFloat(Constants.HEIGHT_OF_TABLE_ROWS)
    table.register(TableViewCellController.self, forCellReuseIdentifier: Constants.TABLE_VIEW_CELL_IDENTIFIER)
    table.dataSource = self
    view.addSubview(table)
    addConstraintsToTable()
    }
    // inital setup for Movies controller
   func intialSetup(){
        setUptable()
    }

}
extension MovieViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.NO_OF_ROWS_IN_EACH_TABLE_SECTION
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tablecell = tableView.dequeueReusableCell(withIdentifier: Constants.TABLE_VIEW_CELL_IDENTIFIER)!
        return tablecell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return Constants.MOVIE_CATEGORIES[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.NO_OF_SECTIONS_IN_TABLE_HEADER
    }

}


