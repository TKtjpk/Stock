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

struct Data: Decodable {
    
    var c: Double?
    var h: Double?
    var l: Double?
    var o: Double?
    var pc: Double?
    var t: Int?
}
