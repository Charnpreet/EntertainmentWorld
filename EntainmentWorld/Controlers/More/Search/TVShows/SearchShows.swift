//
//  SearchShows.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 20/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit

class SearchShows :  SearchRootController<TVShows>{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collection.dataSource = self
        self.collection.delegate = self
         configureDataSource()
    }

     func configureDataSource() {
         
         dataSource = UICollectionViewDiffableDataSource<Section, TVShows>(collectionView: collection, cellProvider: {collection, indexPath, itemList in
             let cell = collection.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
             cell.cellImage.image = UIImage() // this is done to make sure we gets blank view beofore updates new image
             cell.titleTextLabel.text = Constants.EMPTY_TEXT
             let pPath = itemList.poster_path
             let tittle = itemList.name ?? ""
             Shared.LoadPosterImagesForCollectionCell(cell : cell, pPath: pPath, text :tittle, db:self.db)
             return cell
         })
     }
     //
       //
    public override func setUpSearchTextField() -> UISearchTextField{
        let  searchTextField = super.setUpSearchTextField()
           searchTextField.addTarget(self, action: #selector(getSearchEditFIeldText(_:)), for: .editingChanged);
           return searchTextField
       }
    
    
    
    func loadData(text_To_search: String, PageNo: Int){
        db.searchDataBase(pageNO: PageNo, route: Routes.SEARCH_SHOWS, query: text_To_search, completionHandler: { (shows: TVShowsResponse)  in
            self.itemList.append(contentsOf: shows.results.map({$0}))
            self.totalPages = shows.total_pages
            self.createSnapShot(from: self.itemList)
        })
    }
    
    
    func LoadSegus(item : TVShows){
        let detailVC = UIStoryboard(name: Constants.SHOW_DETAILS_STORYBOARD_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.SHOW_DETAILS_VIEW_CONTROLLER_IDENTIFIER) as! ItemDetailViewControllerForTable
        detailVC.item = item
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    @objc func getSearchEditFIeldText(_ sender: UISearchTextField){
        text_To_search = searchTextField.text
        guard let   text_To_search  =   text_To_search  else {return}
        if(!text_To_search.isEmpty){
            self.itemList.removeAll()
            loadData(text_To_search:text_To_search, PageNo: curentPage)
            
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         guard let item = dataSource.itemIdentifier(for: indexPath) else {return}
            LoadSegus(item: item)
    }
  
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
        if indexPath.row == itemList.count - 1 {
            curentPage += 1
            if(curentPage <= totalPages){
                loadData(text_To_search: text_To_search ?? "", PageNo: curentPage)
            }
        }
    }
}
