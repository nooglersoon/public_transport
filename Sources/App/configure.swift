import Vapor
import Fluent
import FluentSQLiteDriver

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    // register routes
    
    // configure databases
    // Get the absolute path for db.sqlite
    let databasePath = "/Users/fauziabd/Documents/Software Development/backend/vapor/public_transport/db.sqlite"
    app.databases.use(.sqlite(.file(databasePath)), as: .sqlite)
    
    print("Using database at path: \(databasePath)")
    
    // register migration
    app.migrations.add(CreateStation())
    
    // auto migrate
    try await app.autoMigrate()
//
//    Task {
//        do {
//            let db = app.db
//            let count = try await Station.query(on: db).count()
//            print("Number of stations in the database: \(count)")
//        } catch {
//            print("Failed to connect to the database: \(error)")
//        }
//    }
    
    try routes(app)
}
