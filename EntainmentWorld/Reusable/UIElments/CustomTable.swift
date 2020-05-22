//
//  CustomTable.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 14/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class CustomTable: UITableView {
var safeArea: UILayoutGuide!
    var view = UIView()
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
         setUptable()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
         setUptable()
    }
  
    //setup table view
     func setUptable(){
        backgroundColor = BackGroundColor.getBackgrndClr()             //.black
            rowHeight = CGFloat(Constants.HEIGHT_OF_TABLE_ROWS)
            tableHeaderView?.backgroundColor = .red
     }
     

}
