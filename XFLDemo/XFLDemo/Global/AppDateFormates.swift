//
//  DateFormates.swift
//  XFLDemo
//
//  Created by AbdulRehman on 06/03/2021.
//

class DateFormates {
    class var apiStandard: String {
        return "yyyy-MM-dd'T'HH:mm:ssZ"
    }
    
    class var dateStandard: String {
        return "yyyy-MM-dd"
    }
    
    class var kDateTime: String {
        return "EEEE, MMM dd"
    }
    
    class var kDate: String {
        return "E, d MMM yyyy"
    }
    
    class var kDateAndTime: String {
        return "E, d MMM yyyy h:mm a"
    }
    
    class var kTime: String {
        return "h:mm a"
    }
}
