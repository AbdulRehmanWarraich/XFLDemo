//
//  Matchs.swift
//  XFLDemo
//
//  Created by AbdulRehman on 11/03/2021.
//

import ObjectMapper

struct Matches: Mappable {
    
    var matches: [Match] = []
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        matches       <- map["Matches"]
    }
}
