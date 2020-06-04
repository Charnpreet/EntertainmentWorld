//
//  TVShowsGenreDiscover.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 21/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//
import Foundation
import UIKit
class TVShowsListByGenre : RootControllerWithUICollectionView<TVShows>{
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
        LoadConentWithGnreId(PageNO: curentPage, genreId: genreId)
    }

    override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
           nvigationLabel.text = "TV Shows"
           nvigationLabel.textColor = .red
           nvigationLabel.textAlignment = .center
           self.navigationController?.navigationBar.addSubview(nvigationLabel)
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           self.navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
           nvigationLabel.removeFromSuperview()
       
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
    
    func LoadConentWithGnreId(PageNO: Int, genreId: Int){
        self.db.loadContentWithGenreId(pageNO: PageNO, route: Routes.DISCOVER_SHOWS_BY_GENRE_ID, genreId: genreId, completionHandler: { (shows: TVShowsResponse )in
            self.itemList.append(contentsOf: shows.results.map({$0}))
            self.totalPages = shows.total_pages
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
                LoadConentWithGnreId(PageNO: curentPage, genreId: genreId)
            }
        }
    }
}
extension TVShowsListByGenre  : DoSegus {
    func LoadSegus(item : TVShows) {
        let detailVC = UIStoryboard(name: Constants.SHOW_DETAILS_STORYBOARD_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.SHOW_DETAILS_VIEW_CONTROLLER_IDENTIFIER) as! ItemDetailViewControllerForTable
        detailVC.item = item
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
