//
//  CreateStar.swift
//  
//
//  Created by Labinot Sadiki on 11.04.20.
//

import Fluent

struct CreateStar: Migration {
  // Prepares the database for storing Star models.
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema("stars")
      .id()
      .field("name", .string)
      .field("galaxy_id", .uuid, .references("galaxies", "id"))
      .create()
  }
  
  // Optionally reverts the changes made in the prepare method.
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("stars").delete()
  }
}
