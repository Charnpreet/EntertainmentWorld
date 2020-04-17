//
//  DiscoverViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 17/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    let db = DBConnection()
    var collection: UICollectionView!
    var movieGenre: [Genre] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        self.collection.dataSource = self
        self.collection.delegate = self
        // Do any additional setup after loading the view.
        db.LoadGenre(route: Routes.MOVIE_GENRE, completionHandler: {(movieGenre : GenreCollection) in
            self.movieGenre.removeAll()
            self.movieGenre = movieGenre.genres
            self.collection.reloadData()
        })
    }
    
    func setupCollectionView(){
        let frame = CGRect(x:0 , y:1 , width: Constants.IOS_SCREEN_WIDTH , height: Constants.IOS_SCREEN_HEIGHT)
        collection =  UICollection.getUICollections(HScrolling: false, frame: frame, layout: UICollectionViewFlowLayout())
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER)
        collection.register(HeaderForCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.COLLECTION_VIEW_HEADER_IDENTIFIER)
        view.addSubview(collection)
    }
    
    
}


extension DiscoverViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  movieGenre.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3.2, height: collectionView.frame.width/2.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
//        let url = URL(string: "\(Connection.IMAGE_URL_BASE_PATH)\(searchedMovies[indexPath.row].poster_path)")!
//        db.downloadImage(from: url, completionHandler: {(img) in
//            cell.cellImage.image = img
       // })
        cell.titleTextLabel.text = movieGenre[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.COLLECTION_VIEW_HEADER_IDENTIFIER, for: indexPath)
        let textlabel = UILabel(frame: CGRect(x: 0, y: 0, width: header.frame.width-10, height: header.frame.height/2))
        textlabel.text = "Browse  By Genre"
        textlabel.textAlignment = .center
        textlabel.textColor = .white
        textlabel.center = header.center
        header.addSubview(textlabel)
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: Constants.IOS_SCREEN_WIDTH, height: 60)
    }
    
}
