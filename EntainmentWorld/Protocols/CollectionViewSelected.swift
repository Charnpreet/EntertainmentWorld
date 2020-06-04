//
//  CollectionViewSelected.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 4/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation

protocol CollectionViewSelected {
    associatedtype T
    func collectionViewSelected(item : T)
}
protocol Segus {
    associatedtype T
    func LoadSegus(item : T)
}
