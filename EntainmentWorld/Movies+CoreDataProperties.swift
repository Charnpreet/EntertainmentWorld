//
//  Movies+CoreDataProperties.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 5/5/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//
//

import Foundation
import CoreData


extension Movies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movies> {
        return NSFetchRequest<Movies>(entityName: "Movies")
    }

    @NSManaged public var id: Int64

}
