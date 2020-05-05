//
//  TvShows+CoreDataProperties.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 5/5/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//
//

import Foundation
import CoreData


extension TvShows {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TvShows> {
        return NSFetchRequest<TvShows>(entityName: "TvShows")
    }

    @NSManaged public var id: Int64

}
