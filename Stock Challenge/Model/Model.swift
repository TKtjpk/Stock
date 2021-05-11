//
//  Model.swift
//  Stock Challenge
//
//  Created by MacBook Pro (Tomasz) on 11/05/2021.
//

import Foundation

struct Lookup: Decodable {
    
    var count: Int?
    var result: [Companies]?
}

struct Companies: Decodable {
    
    var description: String?
    var displaySymbol: String?
    var symbol: String?
    var type: String?
}
