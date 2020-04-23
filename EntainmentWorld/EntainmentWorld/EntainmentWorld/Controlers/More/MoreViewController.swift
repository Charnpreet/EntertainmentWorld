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
    var collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.table.rowHeight = Constants.IOS_SCREEN_HEIGHT/15
        // Do any additional setup after loading the view.
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: "hello")
        self.table.dataSource = self
        self.table.delegate = self
    }
}

extension MoreViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section==0){
            return "Search"
        }
        return "Discover"
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section==0){
            LoadSearchView(rowNo: indexPath.row)
        }
        if(indexPath.section==1){
            LoadBrowsByGenreView(rowNo: indexPath.row)
        }
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hello")!
        cell.accessoryType = .disclosureIndicator
        if(indexPath.section==0){
            if(indexPath.row==0){
                cell.textLabel?.text = "Search Movie"
            }
            if(indexPath.row==1){
                cell.textLabel?.text = "Search Tv Shows"
            }
        }
        if(indexPath.section==1){
            if(indexPath.row==0){
                cell.textLabel?.text = "Browse Movies By Genre"
            }
            if(indexPath.row==1){
                cell.textLabel?.text = "Browse TV Shows By Genre"
            }
        }
        
        
        return cell
    }
    
    private  func LoadSearchView(rowNo: Int){
        let searchVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "Search")
        let searchShowsVC = UIStoryboard(name: "SearchShows", bundle: nil).instantiateViewController(withIdentifier: "SearchShows")
        if(rowNo==0){
            navigationController?.pushViewController(searchVC, animated: true)
        }
        else{
            
            navigationController?.pushViewController(searchShowsVC, animated: true)
        }
    }
    
    private func LoadBrowsByGenreView(rowNo: Int){
        let discoverVC = UIStoryboard(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: "Discover")
        let tvShowGenreVC = UIStoryboard(name: "ShowsGenre", bundle: nil).instantiateViewController(withIdentifier: "ShowsGenre")
        if(rowNo==0){
            navigationController?.pushViewController(discoverVC, animated: true)
        }
        if(rowNo==1){
            navigationController?.pushViewController(tvShowGenreVC, animated: true)
        }
            
       
    }
}

