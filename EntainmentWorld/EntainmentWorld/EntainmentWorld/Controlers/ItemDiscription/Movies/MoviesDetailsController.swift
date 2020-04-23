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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        loadImage()
        // Do any additional setup after loading the view.
    }
    
    override  func loadImage(){
        let urlString = "\(Connection.IMAGE_URL_BASE_PATH)\(item.poster_path ?? "")"
        
        guard let url = URL(string: urlString) else {
            self.backGroundImage.image = UIImage(named: "img1")
            return
            
        }
        db.downloadImage(from: url, completionHandler: {(img) in
            self.backGroundImage.image = img
        })
        
    }
    
    override    func loadVideo(){
        db.LoadVideo(route: Routes.VIDEO_ROUTE, content_Type: Routes.MOVIE_CONTENT_TYPE, content_ID:item.id,completionHandler:{
            (videos: VideoResponse) in
            self.videos = videos.results
            if(self.videos.count>0){
                self.bottomSheetVC.videoUrl = self.videos[0].key
            }
             self.bottomSheetVC.playButton.isHidden = false
        })
    }
    override func AddLabelToNavigationBar() {
        super.AddLabelToNavigationBar()
        firstLabel.text =  item.title
    }
    func addBottomSheetView() {
        // 1- Init bottomSheetVC
        bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.rating = item.vote_average
        
        // 2- Add bottomSheetVC as a child view
        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)
        
        // 3- Adjust bottomSheet frame and initial position.
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
         self.bottomSheetVC.playButton.isHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AddLabelToNavigationBar()
        addBottomSheetView()
        loadVideo()
    }
}




