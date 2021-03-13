//
//  Player.swift
//  XFLDemo
//
//  Created by AbdulRehman on 11/03/2021.
//

import ObjectMapper

struct Player: Mappable {
    
    var name = ""
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        name    <- map["name"]
    }
}
