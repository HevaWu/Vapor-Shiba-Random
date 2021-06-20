//
//  ShibaImageURLList.swift
//  
//
//  Created by He Wu on 2021/06/20.
//

import Foundation

struct ShibaImageURLList: Codable {
    var shibaLists: [ShibaImageURL] = [
        ShibaImageURL(urlString: "https://shibe.online/"),
        ShibaImageURL(urlString: "https://shibe.online/"),
        ShibaImageURL(urlString: "https://shibe.online/")
    ]
}
