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
    

    static func LoadPosterImages(textLabel: UILabel, cellImage : UIImageView, pPath: String?, text : String, db: DBConnection){
          guard let posterPath = pPath else {
              textLabel.text = text
              return

          }
          let urlString = "\(Connection.IMAGE_URL_BASE_PATH)\(posterPath)"

          guard let url = URL(string: urlString ) else {
             textLabel.text = text
              return

          }
          db.downloadImage(from: url, completionHandler: {(img) in
             cellImage.image = img
          })

      }
    
    static func setUpSearchTextField(text: String) -> UISearchTextField{
         let frame = Frames.SEARCHBAR_FRAME_CG_REACT
         let  searchTextField = CustomSearchBar(frame: frame)
         searchTextField.backgroundColor = .white
         searchTextField.placeholder = text
         searchTextField.textColor = .black
        //searchTextField.addTarget(self, action: #selector(getSearchEditFIeldText(_:)), for: .editingChanged);
         return searchTextField
     }
}
