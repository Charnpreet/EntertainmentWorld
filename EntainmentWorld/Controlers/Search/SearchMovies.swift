//
//  SearchShows.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 20/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class SearchMovies: BaseControllerForGenreNSearch<MoviesDetails> {
    var searchTextField : UISearchTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collection.dataSource = self
        self.collection.delegate = self
        self.view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
    }
    
    
    //
    //    //header: HeaderForCollectionReusableView
    public func setUpSearchTextField() -> UISearchTextField{
        print()
        let frame = Frames.SEARCHBAR_FRAME_CG_REACT
        let  searchTextField = CustomSearchBar(frame: frame)
        searchTextField.backgroundColor = .white
        searchTextField.placeholder = "Search Movies"
        searchTextField.textColor = .black
        searchTextField.addTarget(self, action: #selector(getSearchEditFIeldText(_:)), for: .editingChanged);
        return searchTextField
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  super.collectionView(collectionView, cellForItemAt: indexPath) as! CollectionViewCell
         let pPath = itemList[indexPath.row].poster_path
         let tittle = itemList[indexPath.row].title ?? ""
         Shared.LoadPosterImagesForCollectionCell(cell : cell, pPath: pPath, text :tittle, db:db)
        return cell
    }
    
    @objc func getSearchEditFIeldText(_ sender: UISearchTextField){
        guard   let text_To_search = searchTextField.text else {return}
        if(!text_To_search.isEmpty){
            self.itemList.removeAll()
            self.collection.reloadData()
            db.searchDataBase(pageNO: 1, route: Routes.SEARCH_MOVIES, query: text_To_search, completionHandler: { (movies: MovieResponse)  in
                
                for movie in movies.results {
                    self.itemList.append(movie)
                }
                self.activityIndicator.stopAnimating()
                self.collection.reloadData()
            })
            
        }else{
            print("is empty") // this should presneted to user// either by alert dialog or some other kind of view
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
        navigationController?.navigationBar.isHidden = false
        searchTextField  = setUpSearchTextField()
        navigationController?.navigationBar.addSubview(self.searchTextField)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
        self.searchTextField.removeFromSuperview()
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        LoadSegus(item: itemList[indexPath.row] )
    }
    
    func LoadSegus(item : MoviesDetails){
        let detailVC = UIStoryboard(name: Constants.MOVIE_DETAILS_STORYBOARD_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.MOVIE_DETAILS_STORYBOARD_IDENTIFIER) as! MoviesDetailsController
        detailVC.item = item
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

