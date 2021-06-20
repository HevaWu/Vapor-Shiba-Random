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
}
