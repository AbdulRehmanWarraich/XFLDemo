//
//  Teams.swift
//  XFLDemo
//
//  Created by AbdulRehman on 11/03/2021.
//

import ObjectMapper

struct Teams: Mappable {
    
    var teams: [Team] = []
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        teams   <- map["Teams"]
    }
}
