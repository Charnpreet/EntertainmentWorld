//
//  Constants.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 7/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
class Constants{
    static  let MOVIE_CATEGORIES = ["Popular", "Now Playing", "Up Coming", "Top Rated"]
    static let NO_OF_ROWS_IN_EACH_TABLE_SECTION = 1
    static let HEIGHT_OF_TABLE_ROWS = 220.00 // has to be float
    static let COLLECTION_VIEW_CELL_IDENTIFIER = "collectionCell"
    static let COLLECTION_VIEW_HEADER_IDENTIFIER = "header"
    static let TABLE_VIEW_CELL_IDENTIFIER = "tableCell"
    static let PROFILE_IMAGE_FRAME = CGRect(x:  100 , y: 150 , width: 200 , height: 200)
    static let IOS_SCREEN_WIDTH = UIScreen.main.bounds.width
    static let IOS_SCREEN_HEIGHT = UIScreen.main.bounds.height
    static let DARK_MODE_UI_LABEL_FRAME = CGRect(x: 10, y: IOS_SCREEN_HEIGHT/2, width: Constants.IOS_SCREEN_WIDTH-20, height: 50)
    static let DARK_MODE_SWITCH_FRAME = CGRect(x: IOS_SCREEN_WIDTH-70, y: IOS_SCREEN_HEIGHT/1.95, width: 100, height: 30)
    static let DARK_MODE_UI_LABEL_TEXT = " Dark Mode"
    static let USER_NAME_UI_LABEL_FRAME = CGRect(x: 10, y: Constants.IOS_SCREEN_HEIGHT/2, width: Constants.IOS_SCREEN_WIDTH-20, height: 50)
    static let USER_EMAIL_UI_LABEL_FRAME = CGRect(x: 10, y: Constants.IOS_SCREEN_HEIGHT/2, width: Constants.IOS_SCREEN_WIDTH-20, height: 50)
    static let WEBVIEW_LOGINSCREEN_URL = "https://www.themoviedb.org/login"
    static let WEBVIEW_KEYPATH = "estimatedProgress"
    static let TV_SHOW_CATEGORIES = ["Popular","Top Rated","On Air", "On Air Today"]
}
