//
//  ShibaListGetRequestContent.swift
//  
//
//  Created by He Wu on 2021/06/26.
//

import Foundation
import Vapor

struct ShibaListGetRequestContent: Content {
    let count: String
    let urls: Bool
    let httpsUrls: Bool
}
