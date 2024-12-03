import Vapor
import Fluent
import FluentSQLiteDriver

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    // configure databases
    // Get the absolute path for db.sqlite
    let databasePath = "/Users/fauziabd/Documents/Software Development/backend/vapor/public_transport/db.sqlite"
    app.databases.use(.sqlite(.file(databasePath)), as: .sqlite)
    
    // register migration
    app.migrations.add(CreateStation())
    
    // auto migrate
    try await app.autoMigrate()
    
    // register routes
    try routes(app)
}
