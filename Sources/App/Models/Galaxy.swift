//
//  Galaxy.swift
//  
//
//  Created by Labinot Sadiki on 11.04.20.
//

import Foundation
import Vapor
import Fluent

final class Galaxy: Model, Content {
  // Name of the table or collection.
  static let schema = "galaxies"
  
  // Unique identifier for this Galaxy.
  @ID(key: .id)
  var id: UUID?
  
  // The Galaxy's name.
  @Field(key: "name")
  var name: String
  
  // All the Stars in this Galaxy.
  @Children(for: \.$galaxy)
  var stars: [Star]
  
  // Creates a new, empty Galaxy.
  init() { }
  
  // Creates a new Galaxy with all properties set.
  init(id: UUID? = nil, name: String) {
    self.id = id
    self.name = name
  }
}
