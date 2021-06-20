import Leaf
import LeafKit
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    // enable Leaf cache
//    if !app.environment.isRelease {
//        LeafRenderer.Option.caching = .bypass
//    }

    app.views.use(.leaf)

    // register routes
    try routes(app)
}
