//
//  BaseVCForGenreItemList.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 4/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class BaseVCForGenreItemList<U: BaseCollectionCell<T>, T: Hashable>: BaseVCForSearch_Genre<U, T>{
    let nvigationLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Constants.IOS_SCREEN_WIDTH, height: 40))
    var genreId: Int!
    var genreCatgoryName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadConentWithGnreId(pageNo: curentPage, genreId: genreId)
        // Do any additional setup after loading the view.
    }
    func LoadConentWithGnreId(pageNo: Int, genreId: Int){
        if(T.self==MoviesDetails.self){
            self.db.loadContentWithGenreId(pageNO: pageNo, route: Routes.DISCOVER_MOVIES_BY_GENRE_ID, genreId: genreId, completionHandler: { (movies: MovieResponse )in
                self.itemList.append(contentsOf: movies.results.map({$0}) as! [T])
                self.totalPages = movies.total_pages
                //self.activityIndicator.stopAnimating()
                self.createSnapShot(from: self.itemList)
            })
        }else{
            self.db.loadContentWithGenreId(pageNO: pageNo, route: Routes.DISCOVER_SHOWS_BY_GENRE_ID, genreId: genreId, completionHandler: { (shows: TVShowsResponse )in
                self.itemList.append(contentsOf: shows.results.map({$0}) as! [T])
                self.totalPages = shows.total_pages
                // self.activityIndicator.stopAnimating()
                self.createSnapShot(from: self.itemList)
            })
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
                LoadConentWithGnreId(pageNo: curentPage, genreId: genreId)
            }
        }
    }
    
    func LoadSegus(item : T){
        if(T.self==MoviesDetails.self){
            let detailVC = UIStoryboard(name: Constants.MOVIE_DETAILS_STORYBOARD_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.MOVIE_DETAILS_STORYBOARD_IDENTIFIER) as! MoviesDetailsController
            detailVC.item = item as? MoviesDetails
            navigationController?.pushViewController(detailVC, animated: true)
        }else{
            let detailVC = UIStoryboard(name: Constants.SHOW_DETAILS_STORYBOARD_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.SHOW_DETAILS_VIEW_CONTROLLER_IDENTIFIER) as! ItemDetailViewControllerForTable
            detailVC.item = item as? TVShows
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
    
        guard let genreCatgoryName = genreCatgoryName else{
            nvigationLabel.text = ""
            return
        }
        nvigationLabel.text = genreCatgoryName
        nvigationLabel.textColor = .red
        nvigationLabel.textAlignment = .center
        self.navigationController?.navigationBar.addSubview(nvigationLabel)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
        nvigationLabel.removeFromSuperview()
        
    }
}

