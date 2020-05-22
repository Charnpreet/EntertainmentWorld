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
       // self.table.sectionHeaderHeight = 70
      //  self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = BackGroundColor.getBackgrndClr()  //.black
        self.table.rowHeight = Constants.IOS_SCREEN_HEIGHT/12
        // Do any additional setup after loading the view.
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER)
        self.table.dataSource = self
        self.table.delegate = self
        self.table.rowHeight = 50
        self.table.isScrollEnabled = false
    }
    
    func setUpHeader(view: UIView){
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: Constants.IOS_SCREEN_WIDTH, height:  30))
        label.text = "...MORE"
        label.font = label.font.withSize(20)
        label.textColor = .white
        label.textAlignment = .center
        label.center = view.center
        view.addSubview(label)
    }
    
}

extension MoreViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Constants.IOS_SCREEN_WIDTH, height: Constants.IOS_SCREEN_HEIGHT/4))
        setUpHeader(view: view)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.IOS_SCREEN_HEIGHT/4
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
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 1
        if(indexPath.row==0){
            cell.textLabel?.text = "Search Movie"
        }
        if(indexPath.row==1){
            cell.textLabel?.text = "Search Tv Shows"
        }
        if(indexPath.row==2){
            cell.textLabel?.text = "Movies By Genre"
        }
        if(indexPath.row==3){
            cell.textLabel?.text = "TV Shows By Genre"
        }
        if(indexPath.row==4){
            cell.textLabel?.text = "My Collection"
        }
        
        return cell
    }
    private func onRowItemClick(for row: Int){
        let searchVC = UIStoryboard(name: Constants.SEARCHMOVIES_STORYBOARD_IDENTIFERS, bundle: nil).instantiateViewController(withIdentifier: Constants.SEARCHMOVIES_STORYBOARD_IDENTIFERS)
        let searchShowsVC = UIStoryboard(name: Constants.SEARCH_SHOWS_STORYBOARD_IDENTIFER, bundle: nil).instantiateViewController(withIdentifier: Constants.SEARCH_SHOWS_STORYBOARD_IDENTIFER)
        let discoverVC = UIStoryboard(name: Constants.DICCOVER_STORYBOARD_IDENTIFER, bundle: nil).instantiateViewController(withIdentifier: Constants.DICCOVER_STORYBOARD_IDENTIFER)
        let tvShowGenreVC = UIStoryboard(name:Constants.TV_SHOWS_GENRE_STORYBOARD_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.TV_SHOWS_GENRE_STORYBOARD_IDENTIFIER)
        let mycollectionVC = UIStoryboard(name:"Mycollection", bundle: nil).instantiateViewController(withIdentifier: "Mycollection")
        
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
        if(row==4){
           navigationController?.pushViewController(mycollectionVC, animated: true)
       }
    }
}

