//
//  TableContraints.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 14/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import  UIKit
class TableConstraints
{
    static func addConstraintsToTable(view: UIView, table : CustomTable){
        let  safeArea = view.layoutMarginsGuide
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
