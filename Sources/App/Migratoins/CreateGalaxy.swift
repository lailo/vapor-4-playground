//
//  CreateGalaxy.swift
//  
//
//  Created by Labinot Sadiki on 11.04.20.
//

import Fluent

struct CreateGalaxy: Migration {
  // Prepares the database for storing Galaxy models.
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema("galaxies")
      .id()
      .field("name", .string)
      .create()
  }
  
  // Optionally reverts the changes made in the prepare method.
  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("galaxies").delete()
  }
}
