import Fluent
import FluentSQLiteDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
  // uncomment to serve files from /Public folder
  app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

  // database init
  app.databases.use(.sqlite(.memory), as: .sqlite)
  
  // database migrations
  app.migrations.add(CreateGalaxy())
  app.migrations.add(CreateStar())
  
  // database wait for in-momory init
  try app.autoMigrate().wait()

  // register routes
  try routes(app)
}
