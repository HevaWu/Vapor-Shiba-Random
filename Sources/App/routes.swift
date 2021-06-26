import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }
    
    app.get("hello") { req -> String in
        return "Hello, world!!!"
    }
    
    app.get("index") { req in
        return req.view.render("index", ["title": "Hello Vapor!"])
    }
    
    app.get("welcome") { req in
        return req.view.render("welcome")
    }
    
    app.get("shibalist") { req -> EventLoopFuture<View>  in
        return req.client
            .get("http://shibe.online/api/shibes?count=100&urls=true&httpsUrls=true")
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
