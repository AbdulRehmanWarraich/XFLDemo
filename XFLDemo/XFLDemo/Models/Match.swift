//
//  Match.swift
//  XFLDemo
//
//  Created by AbdulRehman on 11/03/2021.
//

import ObjectMapper

struct Match: Mappable {
    var key = ""
    var aTeamKey: String = ""
    var aTeam: Team?
    var bTeamKey: String = ""
    var bTeam: Team?
    var datestamp: Date?
    var isPlayed: Bool = false
    var aTeamGoal: Int = 0
    var bTeamGoal: Int = 0
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        aTeamKey        <- map["aTeamKey"]
        aTeam           <- map["aTeam"]
        bTeamKey        <- map["bTeamKey"]
        bTeam           <- map["bTeam"]
        datestamp       <- (map["datestamp"], transform)
        isPlayed        <- map["isPlayed"]
        aTeamGoal       <- map["aTeamGoal"]
        bTeamGoal       <- map["bTeamGoal"]
    }
    
    // MARK: Transforms
    let transform = TransformOf<Date, String>(fromJSON: { (value: String?) -> Date? in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormates.apiStandard
        return dateFormatter.date(from: value ?? "")
        
    }, toJSON: { (value: Date?) -> String? in
        let dateFormatter = DateFormatter()
        if let date = value {
            dateFormatter.dateFormat = DateFormates.apiStandard
            return dateFormatter.string(from: date)
        }
        return nil
    })
}
