//
//  Shared.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 30/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
class Shared {
    
    static func LoadPosterImagesForCollectionCell(cell : CollectionViewCell, pPath: String?, text : String, db: DBConnection){
        guard let posterPath = pPath else {
            cell.titleTextLabel.text = text
            return

        }
        let urlString = "\(Connection.IMAGE_URL_BASE_PATH)\(posterPath)"

        guard let url = URL(string: urlString ) else {
            cell.titleTextLabel.text = text
            return

        }
        db.downloadImage(from: url, completionHandler: {(img) in
            cell.cellImage.image = img
        })

    }
}
