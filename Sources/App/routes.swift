import Vapor

func routes(_ app: Application) throws {
  app.get { _ in
    "It works!"
  }.description("says it works")

  app.group("hello") { hello in
    hello.get { _ -> String in
      "Hello, world!"
    }.description("says hello world")

    hello.get("vapor") { _ in
      "Hello, vapor!"
    }.description("says hello vapor")

    hello.get(":name") { req -> String in
      let name = req.parameters.get("name")!
      return "Hello, \(name)!!"
    }.description("says hello to a given name")
  }

  app.get("say", ":greeting", "to", ":name") { req -> String in
    let greeting = req.parameters.get("greeting")!
    let name = req.parameters.get("name")!
    return "\(greeting), \(name)!"
  }.description("says a custom greeting to a given name")

  app.get("double", ":number") { req -> String in
    guard let number = req.parameters.get("number", as: Int.self) else {
      throw Abort(.badRequest)
    }
    return "double of \(number) is \(2 * number)"
  }.description("doubles a number or trhows error if there is no number")

  app.group("api") { api in

    api.post("greeting") { req -> String in
      let greeting = try req.content.decode(Greeting.self)
      return greeting.hello
    }

    api.get("hello") { req -> String in
      let hello = try req.query.decode(Hello.self)
      return "Hello, \(hello.name ?? "Anonymous")"
    }

    api.get("hola") { req -> String in
      guard let name: String = req.query["name"] else {
        throw Abort(.badRequest)
      }
      return "Hola, \(name)"
    }
  }

  app.post("users") { req -> CreateUser in
    try CreateUser.validate(req)
    let user = try req.content.decode(CreateUser.self)
    return user
  }

  app.group("galaxies") { galaxies in
    galaxies.get { req in
      Galaxy.query(on: req.db).with(\.$stars).all()
    }

    galaxies.post { req -> EventLoopFuture<Galaxy> in
      let galaxy = try req.content.decode(Galaxy.self)
      return galaxy.create(on: req.db).map { galaxy }
    }
  }

  app.group("stars") { stars in
    stars.get { req in
      Star.query(on: req.db).all()
    }

    stars.post { req -> EventLoopFuture<Star> in
      let star = try req.content.decode(Star.self)
      return star.create(on: req.db).map { star }
    }
  }

  print(app.routes.all)
}
