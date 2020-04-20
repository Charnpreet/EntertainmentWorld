//
//  MoviesDetails.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 20/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit

class MoviesDetailsController : UIViewController{
    var item: MoviesDetails!
    let db =  DBConnection()
    @IBOutlet var backGroundImage: UIImageView! = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
          loadImage()
        // Do any additional setup after loading the view.
    }
    
    func loadImage(){
        let urlString = "\(Connection.IMAGE_URL_BASE_PATH)\(item.poster_path)"
        
        guard let url = URL(string: urlString) else {
            self.backGroundImage.image = UIImage(named: "img1")
            return
            
        }
        db.downloadImage(from: url, completionHandler: {(img) in
            self.backGroundImage.image = img
        })
        
    }
    func addBottomSheetView() {
           // 1- Init bottomSheetVC
           let bottomSheetVC = BottomSheetViewController()
           
           // 2- Add bottomSheetVC as a child view
           self.addChild(bottomSheetVC)
           self.view.addSubview(bottomSheetVC.view)
           bottomSheetVC.didMove(toParent: self)
           
           // 3- Adjust bottomSheet frame and initial position.
           let height = view.frame.height
           let width  = view.frame.width
           bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
       }
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           addBottomSheetView()
           self.tabBarController?.tabBar.isHidden = true
       }
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
            self.tabBarController?.tabBar.isHidden = false
       }
}
