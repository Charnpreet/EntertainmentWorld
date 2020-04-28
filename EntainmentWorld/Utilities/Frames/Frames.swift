//
//  Frames.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 28/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class Frames {
    
    static let tableFrame = CGRect(x: 0, y: 0, width: Constants.IOS_SCREEN_WIDTH, height: Constants.IOS_SCREEN_HEIGHT)
    
    static let SEARCHBAR_FRAME_CG_REACT = CGRect(x: Constants.IOS_SCREEN_WIDTH/8, y: 0, width: (Constants.IOS_SCREEN_WIDTH - Constants.IOS_SCREEN_WIDTH/5), height: 40)
    
    static let SEARCH_VC_COLLECTION_VIEW_FRAME_CG_REACT = CGRect(x:  0 , y: 0 , width: Constants.IOS_SCREEN_WIDTH-1 , height: Constants.IOS_SCREEN_HEIGHT-40)
    
    
    static let TITLE_TEXT_LABEL_FRAME_CG_REACT_FOR_ITEM_DISC_VC = CGRect(x: 0, y: 0, width: Constants.IOS_SCREEN_WIDTH, height: 40)
    
    static let PLAY_VIDEO_BUTTON_FRAME_CG_REACT = CGRect(x: Constants.IOS_SCREEN_WIDTH-60, y: 13, width: 40, height: 40)
    
    static let TOTAL_VIDEOS_LABEL_FRAME_CG_REACT = CGRect(x: Constants.IOS_SCREEN_WIDTH-60, y: 60, width: 100, height: 30)
    static let TOTAL_VOTES_LABEL_FRAME_CG_REACT = CGRect(x: 0, y: 60, width: 100, height: 30)
    static let RATING_LABEL_FRAME_CG_REACT = CGRect(x: 15, y: 20, width: 40, height: 30)
    static let CIRCULAR_ANIMATION_VIEW_FRAME_CG_REACT = CGRect(x: 10, y: 20, width: 50, height: 30)
    
    static let BASE_VC_TABLE_FRAME_CG_REACT = CGRect(x: 0, y: 0, width: Constants.IOS_SCREEN_WIDTH, height: Constants.IOS_SCREEN_HEIGHT)
    
    static let GENRE_BASE_CONTROLLER_FRAME_CG_REACT = CGRect(x:0 , y:1 , width: Constants.IOS_SCREEN_WIDTH , height: Constants.IOS_SCREEN_HEIGHT)
}
