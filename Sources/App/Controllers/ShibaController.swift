//
//  ShibaController.swift
//  
//
//  Created by He Wu on 2021/06/22.
//

import Foundation
import Vapor

final class ShibaController {
    static let baseURLString = "http://shibe.online/api/shibes"
    
    func index(req: Request) -> EventLoopFuture<View> {
        return req.view.render("shibalistGetParam")
    }
    
    func getList(req: Request, uri: URI) -> EventLoopFuture<View> {
//        let uri = URI(string: "http://shibe.online/api/shibes?count=100&urls=true&httpsUrls=true")
        return req.client
            .get(uri)
            .flatMapThrowing { res -> ShibaImageURLList in
                guard let body = res.body else {
                    return ShibaImageURLList.empty
                }
                let data = Data(body.readableBytesView)
                guard let jsonAsArr = try JSONSerialization.jsonObject(with: data, options: []) as? [Any] else {
                    return ShibaImageURLList.empty
                }
                
                let list = jsonAsArr
                    .compactMap { object -> ShibaImageURL? in
                        if let str = object as? String {
                            return ShibaImageURL(urlString: str)
                        } else {
                            return nil
                        }
                    }
                return ShibaImageURLList(list: list)
            }
            .flatMap { list in
                req.view.render("shibalist", list)
            }
    }
    
    func postParams(req: Request) throws -> EventLoopFuture<View> {
        let content = try req.content.decode(ShibaListGetRequestContent.self)
        if var components = URLComponents(string: Self.baseURLString) {
            components.queryItems = [
                URLQueryItem(name: "count", value: content.count),
                URLQueryItem(name: "urls", value: content.urls.description),
                URLQueryItem(name: "httpUrls", value: content.httpsUrls.description),
            ]
            if let uriStr = components.string {
                let uri = URI(string: uriStr)
                return getList(req: req, uri: uri)
            }
        }

        // parse URI failed, back to welcome page
        return req.view.render("welcome")
    }
}
