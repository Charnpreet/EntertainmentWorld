//
//  ItemDetailViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 13/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class ItemDetailViewControllerForTable: BaseControllerForItemDiscription<TVShows>{
    var tvShowId: TvShows?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BackGroundColor.getBackgrndClr()
        loadImage()
        // Do any additional setup after loading the view.
    }
    
    override func loadImage(){
        titleTextLabel.textColor = BackGroundColor.textColor()
        titleTextLabel.text = Constants.EMPTY_TEXT
        guard let poster = item.poster_path else {
            self.titleTextLabel.text = item.name
            return
        }
        let urlString = "\(Connection.IMAGE_URL_BASE_PATH)\(poster)"
        guard let url = URL(string: urlString) else {
            self.titleTextLabel.text = item.name
            return
            
        }
        db.downloadImage(from: url, completionHandler: {(img) in
            self.backGroundImage.image = img
        })
        
    }
    
    override  func loadVideo(){
        db.LoadVideo(route: Routes.VIDEO_ROUTE, content_Type: Routes.TV_SHOWS_CONTENT_TYPE, content_ID:item.id,completionHandler:{
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
        //  self.firstLabel.text = item.name
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
    
    
      func deleteMovie(item: TvShows){
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
            guard let tvShowId = tvShowId else{return}
            deleteMovie(item: tvShowId)
            DisplayView(text: "Removed From Collection", clr: .systemRed)
            }
    }
    
    func addCollectionToDataBase(){
        guard let persistentManager = persistentManager else {return}
        let show = TvShows(context: persistentManager.context)
        show.id = Int64(item.id)
        
        persistentManager.Save()
    }
    
    private func itemAlreadyThere()->Bool{
    guard let persistentManager = persistentManager else {return false}
        var fav = false
        let itemId =  persistentManager.Fetech(TvShows.self)
        itemId.forEach({
            if($0.id ==  item.id){
                tvShowId = $0
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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.navigationController?.navigationBar.topItem?.title = "Shows"
    }
}

