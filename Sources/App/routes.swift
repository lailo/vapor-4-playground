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

  print(app.routes.all)
}
