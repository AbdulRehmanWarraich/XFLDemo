//
//  Team.swift
//  XFLDemo
//
//  Created by AbdulRehman on 11/03/2021.
//

import ObjectMapper

struct Team: Mappable {
    
    var key = ""
    var id = ""
    var name = ""
    var fullName = ""
    var logoImage = ""
    var brandColor = ""
    var players: [Player] = []
    var won: Int = 0
    var loss: Int = 0
    var draw: Int = 0
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id                  <- map["id"]
        name                <- map["name"]
        fullName            <- map["fullName"]
        logoImage           <- map["logoImage"]
        brandColor          <- map["brandColor"]
        players             <- map["players"]
        won                 <- map["won"]
        loss                <- map["loss"]
        draw                <- map["draw"]
    }
}
