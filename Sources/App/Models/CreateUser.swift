//
//  CreateUser.swift
//  
//
//  Created by Labinot Sadiki on 11.04.20.
//

import Vapor

enum Color: String, Codable {
  case red, blue, green
}

struct CreateUser: Content {
  var name: String
  var username: String
  var age: Int
  var email: String
  var favoriteColor: Color?
}


extension CreateUser: Validatable {
  static func validations(_ validations: inout Validations) {
    validations.add("email", as: String.self, is: .email)
    validations.add("age", as: Int.self, is: .range(18...))
    validations.add("name", as: String.self, is: !.empty)
    validations.add("username", as: String.self, is: .count(3...) && .alphanumeric)
    validations.add(
      "favoriteColor", as: String?.self,
      is: .nil || .in("red", "blue", "green"),
      required: false
    )
  }
}
