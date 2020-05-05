//
//  Mycollection.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 4/5/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
//
class Mycollection:   UIViewController{
    var db = DBConnection()
    var navBarImg: UIImage!
    var segmentController : UISegmentedControl!
    var uiCollection: UICollectionView!
    var moviesList :[MoviesDetails] = []
    var tvShowsList :[TVShows] = []
   // let c = UIView()
    var movieIds :[Int] = []
    var tvShowsIds :[Int] = []
    
    var persistentManager: PersistentDataManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        UISegmentSetup()
        ClearNavigationBar()
        self.view.backgroundColor = .black
        setUpCollectionView()
        guard let uiCollection = uiCollection else{return}
        uiCollection.dataSource = self
        uiCollection.delegate = self
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    func loadFavMovieCollectionFromDB(){
        
        for id in movieIds {
            self.moviesList.removeAll()
            db.loadItembyId(route: Routes.SEARCH_MOVIE_BY_ID, movieId: id, completionHandler: { (movie: MoviesDetails?, err)  in
                
                guard let movie = movie else {return}
                self.moviesList.append(movie)
            })
        }
        
    }
    
    func loadFavTvShowseCollectionFromDB(){
        
        for id in tvShowsIds {
            self.tvShowsList.removeAll()
            db.loadItembyId(route: Routes.SEARCH_TV_SHOWS_BY_ID, movieId: id, completionHandler: { (shows: TVShows?, err)  in
                guard let shows = shows else {return}
                self.tvShowsList.append(shows)
            })
        }
    }
    
    func getMovieId(){
        guard let persistentManager = persistentManager else {return}
        let movies = persistentManager.Fetech(Movies.self)
        movieIds.removeAll()
        for movie in movies{
            movieIds.append(Int(movie.id))
            
            
            
        }
       
    }
//    func deleteMovie(item: Movies){
//      guard let persistentManager = persistentManager else {return}
//      persistentManager.deleteItem(item)
//    }
    
    
    func getTvShowIds(){
        guard let persistentManager = persistentManager else {return}
        let tvShows = persistentManager.Fetech(TvShows.self)
        tvShowsIds.removeAll()
        for tvShow in tvShows{
            tvShowsIds.append(Int(tvShow.id))
        }
    }
    
    
    func UISegmentSetup() {
        //  let y = self.navigationController?.navigationBar.frame.height ?? 90
        let frame = CGRect(x: Constants.IOS_SCREEN_WIDTH/4, y: 0, width: Constants.IOS_SCREEN_WIDTH/2, height: Constants.IOS_SCREEN_HEIGHT/20)
        let segmentItems = ["Movies", "TV Shows"]
        segmentController = UISegement.getSegmentedControll(frame: frame, items: segmentItems, bgColr: .black, sitemTintClr: .white)
        segmentController.addTarget(self, action: #selector(Loaddata), for: .valueChanged)
        self.navigationController?.navigationBar.addSubview(segmentController)
    }
    
    @objc func Loaddata(){
        self.uiCollection.reloadData()
    }
    
    func setUpCollectionView(){
        let vWidth = Constants.IOS_SCREEN_WIDTH
        let vHeight = Constants.IOS_SCREEN_HEIGHT-(self.tabBarController?.tabBar.frame.height ?? 80)
        let yPosition = self.navigationController?.navigationBar.frame.height ?? 50
        let frame  = CGRect(x: 0, y: yPosition, width: vWidth, height: vHeight)
        let collectionViewHolder = UIView(frame: frame)
        let cViewFrame = CGRect(x: collectionViewHolder.frame.minX, y: collectionViewHolder.frame.minY, width: collectionViewHolder.frame.width, height: collectionViewHolder.frame.height)
        uiCollection = UICollection.getUICollections(HScrolling: false, frame: cViewFrame, layout: UICollectionViewFlowLayout())
        guard let uiCollection = uiCollection  else {return}
        uiCollection.register(CollectionViewCell.self, forCellWithReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER)
        collectionViewHolder.addSubview(uiCollection)
        self.view.addSubview(collectionViewHolder)
    }
    
    
    fileprivate func ClearNavigationBar(){
        navBarImg = UIImage()
        guard let navBarImg = navBarImg else {return}
        // self.navigationController?.navigationBar.layer.shadowOpacity = 0.95
        self.navigationController?.navigationBar.setBackgroundImage(navBarImg, for: .default)
        self.navigationController?.navigationBar.shadowImage = navBarImg
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
    }
    
    override func viewWillAppear(_ animated: Bool) {
       persistentManager = PersistentDataManager.shared
        segmentController.isHidden = false
        getMovieId()
        getTvShowIds()
        loadFavMovieCollectionFromDB()
        loadFavTvShowseCollectionFromDB()
    }
    override func viewWillDisappear(_ animated: Bool) {
        segmentController.isHidden = true
    }
    
    
    
    func LoadSegus(item : TVShows){
         let detailVC = UIStoryboard(name: Constants.SHOW_DETAILS_STORYBOARD_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.SHOW_DETAILS_VIEW_CONTROLLER_IDENTIFIER) as! ItemDetailViewControllerForTable
         detailVC.item = item
         navigationController?.pushViewController(detailVC, animated: true)
     }
    func LoadMovieSegus(item : MoviesDetails){
          let detailVC = UIStoryboard(name: Constants.MOVIE_DETAILS_STORYBOARD_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.MOVIE_DETAILS_STORYBOARD_IDENTIFIER) as! MoviesDetailsController
          detailVC.item = item
          navigationController?.pushViewController(detailVC, animated: true)
      }

}

extension Mycollection : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(segmentController.selectedSegmentIndex == 0 ){
            return moviesList.count
        }
        else{
            return tvShowsList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
        cell.cellImage.image = UIImage() // this is done to make sure we gets blank view beofore updates new image
        cell.titleTextLabel.text = Constants.EMPTY_TEXT
        if(segmentController.selectedSegmentIndex==0){
            let pPath = moviesList[indexPath.row].poster_path
            let tittle = moviesList[indexPath.row].title ?? ""
            Shared.LoadPosterImagesForCollectionCell(cell : cell, pPath: pPath, text :tittle, db:db)
        }else{
            let pPath = tvShowsList[indexPath.row].poster_path
            let tittle = tvShowsList[indexPath.row].name ?? ""
            Shared.LoadPosterImagesForCollectionCell(cell : cell, pPath: pPath, text :tittle, db:db)
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(segmentController.selectedSegmentIndex==0){
            LoadMovieSegus(item : moviesList[indexPath.row])
        }else{
            LoadSegus(item: tvShowsList[indexPath.row])
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3.2, height: collectionView.frame.width/2.3)
    }
    
}
