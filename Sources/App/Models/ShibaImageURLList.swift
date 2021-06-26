//
//  ShibaImageURLList.swift
//  
//
//  Created by He Wu on 2021/06/20.
//

import Foundation

struct ShibaImageURLList: Codable {
    let list: [ShibaImageURL]
    
    static let empty = ShibaImageURLList(list: [])
}
