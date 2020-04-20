//
//  SearchShows.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 20/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit

class SearchShows : SearchViewController<TVShows> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collection.dataSource = self
        self.collection.delegate = self
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
        let urlString = "\(Connection.IMAGE_URL_BASE_PATH)\(searchedItems[indexPath.row].poster_path ?? "")"
        
        guard let url = URL(string: urlString ) else { return cell }
        db.downloadImage(from: url, completionHandler: {(img) in
            cell.cellImage.image = img
        })
        return cell
    }
    override func getSearchEditFIeldText(_ sender: UISearchTextField){
        guard   let text_To_search = searchTextField.text else {return}
        if(!text_To_search.isEmpty){
            self.searchedItems.removeAll()
            self.collection.reloadData()
            db.searchDataBase(pageNO: 1, route: Routes.SEARCH_SHOWS, query: text_To_search, completionHandler: { (shows: TVShowsResponse)  in
                
                for show in shows.results {
                    self.searchedItems.append(show)
                }
                self.collection.reloadData()
            })
            
        }else{
            print("is empty")
        }
        
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        LoadSegus(item: searchedItems[indexPath.row] )
    }
    
    func LoadSegus(item : TVShows){
        let detailVC = UIStoryboard(name: "TVShowsDetails", bundle: nil).instantiateViewController(withIdentifier: "ItemDetails") as! ItemDetailViewControllerForTable
        detailVC.item = item
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
