//
//  ShibaController.swift
//  
//
//  Created by He Wu on 2021/06/22.
//

import Foundation
import Vapor

final class ShibaController {
    func index(req: Request) -> EventLoopFuture<View> {
        let uri = URI(string: "http://shibe.online/api/shibes?count=100&urls=true&httpsUrls=true")
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
}
