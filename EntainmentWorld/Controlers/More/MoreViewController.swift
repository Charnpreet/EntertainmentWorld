//
//  MoreViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 20/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class MoreViewController: BaseViewController {
    let db = DBConnection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BackGroundColor.getBackgrndClr()  //.black
        self.table.rowHeight = Constants.IOS_SCREEN_HEIGHT/12
        // Do any additional setup after loading the view.
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER)
        self.table.dataSource = self
        self.table.delegate = self
        self.table.rowHeight = 100
        
    }
}

extension MoreViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onRowItemClick(for: indexPath.row)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER)!
        let cellBckgrdView = UIView()
        cellBckgrdView.backgroundColor = .clear
        cell.selectedBackgroundView = cellBckgrdView    // on click while hide custom color
        cell.accessoryType = .disclosureIndicator
        if(indexPath.row==0){
            cell.textLabel?.text = "Search Movie"
        }
        if(indexPath.row==1){
            cell.textLabel?.text = "Search Tv Shows"
        }
        if(indexPath.row==2){
            cell.textLabel?.text = "Browse Movies By Genre"
        }
        if(indexPath.row==3){
            cell.textLabel?.text = "Browse TV Shows By Genre"
        }
        
        return cell
    }
    private func onRowItemClick(for row: Int){
        let searchVC = UIStoryboard(name: Constants.SEARCHMOVIES_STORYBOARD_IDENTIFERS, bundle: nil).instantiateViewController(withIdentifier: Constants.SEARCHMOVIES_STORYBOARD_IDENTIFERS)
        let searchShowsVC = UIStoryboard(name: Constants.SEARCH_SHOWS_STORYBOARD_IDENTIFER, bundle: nil).instantiateViewController(withIdentifier: Constants.SEARCH_SHOWS_STORYBOARD_IDENTIFER)
        let discoverVC = UIStoryboard(name: Constants.DICCOVER_STORYBOARD_IDENTIFER, bundle: nil).instantiateViewController(withIdentifier: Constants.DICCOVER_STORYBOARD_IDENTIFER)
        let tvShowGenreVC = UIStoryboard(name:Constants.TV_SHOWS_GENRE_STORYBOARD_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.TV_SHOWS_GENRE_STORYBOARD_IDENTIFIER)
        
        if(row==0){
            navigationController?.pushViewController(searchVC, animated: true)
        }
        if(row==1){
            navigationController?.pushViewController(searchShowsVC, animated: true)
        }
        
        if(row==2){
            navigationController?.pushViewController(discoverVC, animated: true)
        }
        if(row==3){
            navigationController?.pushViewController(tvShowGenreVC, animated: true)
        }
        
    }
}

