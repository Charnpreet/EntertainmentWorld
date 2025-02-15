//
//  MoviesDetails.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 20/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//
import Foundation
import UIKit

class MoviesDetailsController : BaseControllerForItemDiscription<MoviesDetails>{
    var mvoieId: Movies?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BackGroundColor.getBackgrndClr()
        loadImage()
    }
    override  func loadImage(){
        titleTextLabel.text = Constants.EMPTY_TEXT
        titleTextLabel.textColor = BackGroundColor.textColor()
        guard let poster = item.poster_path else {
            self.titleTextLabel.text = item.title
            return
        }
        let urlString = "\(Connection.IMAGE_URL_BASE_PATH)\(poster)"
        guard let url = URL(string: urlString) else {
            self.titleTextLabel.text = item.title
            return
            
        }
        db.downloadImage(from: url, completionHandler: {(img) in
            self.backGroundImage.image = img
        })
        
    }
    
    override func loadVideo(){
        db.LoadVideo(route: Routes.VIDEO_ROUTE, content_Type: Routes.MOVIE_CONTENT_TYPE, content_ID:item.id,completionHandler:{
            (videos: VideoResponse) in
            self.videos = videos.results
            if(self.videos.count>0){
                self.bottomSheetVC.videoUrl = self.videos.map({return $0.key})
                self.bottomSheetVC.totalVideosLabel.text = "\(self.bottomSheetVC.videoUrl.count) videos"
                self.bottomSheetVC.table.reloadData()
                self.playButtonState()
            }
        })
    }
    override func AddLabelToNavigationBar() {
        super.AddLabelToNavigationBar()
        // firstLabel.text =  item.title
    }
    
    
    fileprivate func addView(){
        // 1- Init bottomSheetVC
        bottomSheetVC = BottomSheetViewController()
        guard let bottomSheetVC = bottomSheetVC else{return}
        bottomSheetVC.rating = item.vote_average
        guard let voteCount = item.vote_count else{return}
        bottomSheetVC.totalVotes = "\(voteCount) votes"
        
        
        // 2- Add bottomSheetVC as a child view
        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)
        
        // 3- Adjust bottomSheet frame and initial position.
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        
    }
    
    func addBottomSheetView() {
        addView()
    }
    
    override func CustomizingNavigationBar() {
        super.CustomizingNavigationBar()
        if(isItFavCollection()){
            navigationItem.rightBarButtonItem?.setBackgroundImage(favImageSelected, for: .normal, barMetrics: .default)
        }
        else{
            navigationItem.rightBarButtonItem?.setBackgroundImage(favImage, for: .normal, barMetrics: .default)
        }
    }
    
    
    func deleteMovie(item: Movies){
        guard let persistentManager = persistentManager else {return}
        persistentManager.deleteItem(item)
    }
    
    override func addTapped() {
        super.addTapped()
        if(!itemAlreadyThere()){
            navigationItem.rightBarButtonItem?.setBackgroundImage(favImageSelected, for: .normal, barMetrics: .default)
            favMovie = true
            addCollectionToDataBase()
            DisplayView(text: "Saved To Collection", clr: .systemGreen)
        }
        else{
            navigationItem.rightBarButtonItem?.setBackgroundImage(favImage, for: .normal, barMetrics: .default)
            favMovie = false
            guard let mvoieId = mvoieId else{return}
            deleteMovie(item: mvoieId)
            DisplayView(text: "Removed From Collection", clr: .systemRed)
        }
    }
    
    func addCollectionToDataBase(){
        guard let persistentManager = persistentManager else {return}
        let show = Movies(context: persistentManager.context)
        show.id = Int64(item.id)
        
        persistentManager.Save()
    }
    
    private func itemAlreadyThere()->Bool{
        guard let persistentManager = persistentManager else {return false}
        var fav = false
        let itemId =  persistentManager.Fetech(Movies.self)
        itemId.forEach({
            if($0.id ==  item.id){
                mvoieId = $0
                fav = true
            }
        })
        return fav
    }
    
    
    
    func isItFavCollection()->Bool{
        favMovie = itemAlreadyThere()
        return favMovie
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AddLabelToNavigationBar()
        addBottomSheetView()
        loadVideo()
    }
}




