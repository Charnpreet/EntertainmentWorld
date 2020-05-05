//
//  BottamSheetExtension.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 1/5/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
extension BottomSheetViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoUrl.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TABLE_VIEW_CELL_IDENTIFIER)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as UITableViewCell
        let cellBckgrdView = UIView()
        cellBckgrdView.backgroundColor = BackGroundColor.getBackgrndClr()
        cell.selectedBackgroundView = cellBckgrdView    // on click while hide custom color
        cell.accessoryType = .disclosureIndicator
        let player = setUpVieoForYouTubePlayer(width: cell.frame.width, height: cell.frame.height)
        cell.addSubview(player)
        if(self.videoUrl.count>0){
            player.loadVideoID(videoUrl[indexPath.row])
        }
    }
}
