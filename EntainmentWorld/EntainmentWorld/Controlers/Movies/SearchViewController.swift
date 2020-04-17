//
//  SearchViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 7/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    var searchTextField : UISearchTextField!
    let db = DBConnection()
    var searchedMovies :[MoviesDetails] = []
    var collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setUp()
        self.collection.dataSource = self
        self.collection.delegate = self
        // Do any additional setup after loading the view.
    }
    //header: HeaderForCollectionReusableView
    private func setUp(){
        let frame = CGRect(x: 1, y: 40, width: Constants.IOS_SCREEN_WIDTH-10, height: 40)
        searchTextField = CustomSearchBar(frame: frame)
        searchTextField.placeholder = "Search Here"
        searchTextField.backgroundColor = .white
        searchTextField.addTarget(self, action: #selector(getSearchEditFIeldText(_:)), for: .editingDidEndOnExit);
        //  searchTextField.addTarget(self, action: #selector(updateList(_:)), for: .editingChanged)
        view.addSubview(searchTextField)
    }
    @objc func updateList(_ sender: UISearchTextField){
        self.searchedMovies.removeAll()
        self.collection.reloadData()
    }
    
    func setupCollectionView(){
        let frame = CGRect(x:  1 , y: 80 , width: Constants.IOS_SCREEN_WIDTH-25 , height: Constants.IOS_SCREEN_HEIGHT)
        collection =  UICollection.getUICollections(HScrolling: false, frame: frame, layout: UICollectionViewFlowLayout())
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER)
        collection.register(HeaderForCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.COLLECTION_VIEW_HEADER_IDENTIFIER)
        view.addSubview(collection)
    }
    
    // method associated With UISeatchTextField
    //
    @objc func getSearchEditFIeldText(_ sender: UISearchTextField){
        
        guard   let text_To_search = searchTextField.text else {return}
        if(!text_To_search.isEmpty){
            self.searchedMovies.removeAll()
            self.collection.reloadData()
            db.searchDataBase(pageNO: 1, route: Routes.SEARCH_MOVIES, query: text_To_search, completionHandler: { (movies: MovieResponse)  in
                
                for movie in movies.results {
                    self.searchedMovies.append(movie)
                }
                // self.previousSearch = text_To_search
                self.collection.reloadData()
            })
            
        }else{
            print("is empty")
        }
        
    }
    
    
}

extension SearchViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedMovies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3.5, height: collectionView.frame.width/2.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
        let url = URL(string: "\(Connection.IMAGE_URL_BASE_PATH)\(searchedMovies[indexPath.row].poster_path)")!
        db.downloadImage(from: url, completionHandler: {(img) in
            cell.cellImage.image = img
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.COLLECTION_VIEW_HEADER_IDENTIFIER, for: indexPath)
        // setUp(header: header as! HeaderForCollectionReusableView)
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: Constants.IOS_SCREEN_WIDTH, height: 60)
    }
    
}
