//
//  SearchShows.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 20/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class SearchMovies: SearchViewController<MoviesDetails> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collection.dataSource = self
        self.collection.delegate = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
        guard let url = URL(string: "\(Connection.IMAGE_URL_BASE_PATH)\(searchedItems[indexPath.row].poster_path ?? "")") else {
            return cell
        }
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
            db.searchDataBase(pageNO: 1, route: Routes.SEARCH_MOVIES, query: text_To_search, completionHandler: { (movies: MovieResponse)  in
                
                for movie in movies.results {
                    self.searchedItems.append(movie)
                }
                self.collection.reloadData()
            })
            
        }else{
            print("is empty")
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = ""
        searchTextField  = setUpSearchTextField()
        searchTextField.placeholder = "Search Movies"
        navigationController?.navigationBar.addSubview(self.searchTextField)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.topItem?.title = ""
        self.searchTextField.removeFromSuperview()
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        LoadSegus(item: searchedItems[indexPath.row] )
    }
    
    func LoadSegus(item : MoviesDetails){
        let detailVC = UIStoryboard(name: "moviesDiscription", bundle: nil).instantiateViewController(withIdentifier: "moviesDiscription") as! MoviesDetailsController
        detailVC.item = item
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

