//
//  SearchShows.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 20/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit

class SearchShows : BaseControllerForGenreNSearch<TVShows>{
      var searchTextField : UISearchTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collection.dataSource = self
        self.collection.delegate = self
         self.view.addSubview(activityIndicator)
         activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  super.collectionView(collectionView, cellForItemAt: indexPath) as! CollectionViewCell
         let pPath = itemList[indexPath.row].poster_path
         let tittle = itemList[indexPath.row].name ?? ""
         Shared.LoadPosterImagesForCollectionCell(cell : cell, pPath: pPath, text :tittle, db:db)
        return cell
    }
    
    @objc func getSearchEditFIeldText(_ sender: UISearchTextField){
        guard   let text_To_search = searchTextField.text else {return}
        if(!text_To_search.isEmpty){
            self.itemList.removeAll()
            self.collection.reloadData()
            db.searchDataBase(pageNO: 1, route: Routes.SEARCH_SHOWS, query: text_To_search, completionHandler: { (shows: TVShowsResponse)  in
                
                for show in shows.results {
                    self.itemList.append(show)
                }
                self.activityIndicator.stopAnimating()
                self.collection.reloadData()
            })
            
        }else{
            print("is empty") // display alert dialog or someother kind of view to notify user not leave it blank
        }
        
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        LoadSegus(item: itemList[indexPath.row] )
    }
    
    func LoadSegus(item : TVShows){
        let detailVC = UIStoryboard(name: Constants.SHOW_DETAILS_STORYBOARD_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.SHOW_DETAILS_VIEW_CONTROLLER_IDENTIFIER) as! ItemDetailViewControllerForTable
        detailVC.item = item
        navigationController?.pushViewController(detailVC, animated: true)
    }

    //
    //    //header: HeaderForCollectionReusableView
        public func setUpSearchTextField() -> UISearchTextField{
                    print()
            let frame = Frames.SEARCHBAR_FRAME_CG_REACT
          let  searchTextField = CustomSearchBar(frame: frame)
            searchTextField.placeholder = "Search Tv Shows"
            searchTextField.backgroundColor = .white
            searchTextField.textColor = .black
            searchTextField.addTarget(self, action: #selector(getSearchEditFIeldText(_:)), for: .editingChanged);
            return searchTextField
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
        searchTextField  = setUpSearchTextField()
        navigationController?.navigationBar.addSubview(self.searchTextField)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
        self.searchTextField.removeFromSuperview()
    }
}
