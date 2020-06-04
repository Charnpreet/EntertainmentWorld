//
//  MoviesListByGenreID.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 21/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
class MoviesListByGenreID : RootControllerWithUICollectionView<MoviesDetails>{
    let nvigationLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Constants.IOS_SCREEN_WIDTH, height: 40))
    var genreId: Int!
    var curentPage: Int = 1
    var totalPages: Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BackGroundColor.getBackgrndClr() 
        
        self.view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        self.collection.dataSource = self
        self.collection.delegate = self
        guard let genreId = genreId else{return}
        configureDataSource()
        LoadConentWithGnreId(pageNo: curentPage, genreId: genreId)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
           nvigationLabel.text = "Movies"
           nvigationLabel.textColor = .red
           nvigationLabel.textAlignment = .center
           self.navigationController?.navigationBar.addSubview(nvigationLabel)
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           self.navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
           nvigationLabel.removeFromSuperview()
       
       }
    
    func configureDataSource() {
          
          dataSource = UICollectionViewDiffableDataSource<Section, MoviesDetails>(collectionView: collection, cellProvider: {collection, indexPath, itemList in
              let cell = collection.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
              cell.cellImage.image = UIImage() // this is done to make sure we gets blank view beofore updates new image
              cell.titleTextLabel.text = Constants.EMPTY_TEXT
              let pPath = itemList.poster_path
              let tittle = itemList.title ?? ""
              Shared.LoadPosterImagesForCollectionCell(cell : cell, pPath: pPath, text :tittle, db:self.db)
              return cell
          })
      }
    
    
    func LoadConentWithGnreId(pageNo: Int, genreId: Int){
        self.db.loadContentWithGenreId(pageNO: pageNo, route: Routes.DISCOVER_MOVIES_BY_GENRE_ID, genreId: genreId, completionHandler: { (movies: MovieResponse )in
            self.itemList.append(contentsOf: movies.results.map({$0}))
            self.totalPages = movies.total_pages
            self.activityIndicator.stopAnimating()
            self.createSnapShot(from: self.itemList)
        })
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
}

extension MoviesListByGenreID : DoSegusForMovies {
    func LoadSegus(item : MoviesDetails){
        let detailVC = UIStoryboard(name: Constants.MOVIE_DETAILS_STORYBOARD_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.MOVIE_DETAILS_STORYBOARD_IDENTIFIER) as! MoviesDetailsController
        detailVC.item = item
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
