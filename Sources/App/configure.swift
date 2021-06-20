import Leaf
import LeafKit
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // serve files from /Public folder
     app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.views.use(.leaf)

    // register routes
    try routes(app)
}
