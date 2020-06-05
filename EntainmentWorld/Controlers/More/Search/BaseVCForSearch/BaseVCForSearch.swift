//
//  BaseVCForSearch.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 4/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
class BaseVCForSearch<U: BaseCollectionCell<T>, T: Hashable>: BaseVCForSearch_Genre<U, T> {
    var searchTextField : UISearchTextField!
    var text_To_search : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BackGroundColor.getBackgrndClr()
        searchTextField  = setUpSearchTextField()
        navigationController?.navigationBar.addSubview(self.searchTextField)
        self.collection.keyboardDismissMode = .onDrag
        guard let activityIndicator = activityIndicator else{return}
        activityIndicator.startAnimating()
    }
    func loadData(text_To_search: String, PageNo: Int){
        if(T.self == MoviesDetails.self){
            db.searchDataBase(pageNO: PageNo, route: Routes.SEARCH_MOVIES, query: text_To_search, completionHandler: { (movies: MovieResponse)  in
                self.itemList.append(contentsOf: movies.results.map({$0}) as! [T])
                print("force downcast noted inside BaseVCForSearch")
                 self.totalPages = movies.total_pages
                self.createSnapShot(from: self.itemList)
            })
        }else{
            db.searchDataBase(pageNO: PageNo, route: Routes.SEARCH_SHOWS, query: text_To_search, completionHandler: { (shows: TVShowsResponse)  in
                self.itemList.append(contentsOf: shows.results.map({$0}) as! [T])
                    self.totalPages = shows.total_pages
                    self.createSnapShot(from: self.itemList)
                })
        }
        
    }
       
       @objc func getSearchEditFIeldText(_ sender: UISearchTextField){
            guard let activityIndicator = activityIndicator else{return}
                   activityIndicator.startAnimating()
              text_To_search = searchTextField.text
              guard let   text_To_search  =   text_To_search  else {return}
              if(!text_To_search.isEmpty){
                  self.itemList.removeAll()
                  loadData(text_To_search:text_To_search, PageNo: curentPage)
              
              }
          }
    
    //
    //
    public func setUpSearchTextField() -> UISearchTextField{
        let  searchTextField = Shared.setUpSearchTextField(text: "")
        searchTextField.addTarget(self, action: #selector(getSearchEditFIeldText(_:)), for: .editingChanged);
        return searchTextField
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
        guard let searchTextField = searchTextField else {return}
        searchTextField.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
        guard let searchTextField = searchTextField else {return}
        searchTextField.isHidden = true
    }
    func LoadSegus(item : T){
        if(T.self == MoviesDetails.self){
            let detailVC = UIStoryboard(name: Constants.MOVIE_DETAILS_STORYBOARD_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.MOVIE_DETAILS_STORYBOARD_IDENTIFIER) as! MoviesDetailsController
            detailVC.item = item as? MoviesDetails
            navigationController?.pushViewController(detailVC, animated: true)
        }
        else{
            let detailVC = UIStoryboard(name: Constants.SHOW_DETAILS_STORYBOARD_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.SHOW_DETAILS_VIEW_CONTROLLER_IDENTIFIER) as! ItemDetailViewControllerForTable
            detailVC.item = item as? TVShows
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           guard let item = dataSource.itemIdentifier(for: indexPath) else {return}
          LoadSegus(item: item)
      }
      
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell =  super.collectionView(collectionView, cellForItemAt: indexPath) as! CollectionViewCell
          return cell
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
