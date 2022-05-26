//
//  Pokedex.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct Pokemon: Codable {
  struct Species: Codable {
    let name: String
  }
  
  struct Sprites: Codable {
    let backDefault: URL?
    let backShiny: URL?
    let frontDefault: URL?
    let frontShiny: URL?
    
    enum CodingKeys: String, CodingKey {
      case backDefault = "back_default"
      case backShiny = "back_shiny"
      case frontDefault = "front_default"
      case frontShiny = "front_shiny"
    }
  }
  
  let species: Species
  let sprites: Sprites
}

class PokeManager {
  static let urlSession = URLSession(configuration: .default)
  
  static func pokemon(id: Int,
                      completionHandler: @escaping (_ pokemon: Pokemon) -> Void) {
    let pokeUrl = buildPokemonURL(id: id)
    let task = urlSession.dataTask(with: pokeUrl) { (data, _, _) in
      let pokemon = try! JSONDecoder().decode(Pokemon.self, from: data!)
      DispatchQueue.main.async {
        completionHandler(pokemon)
      }
    }
    
    task.resume()
    
  }
  
  private static func buildPokemonURL(id: Int) -> URL {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "pokeapi.co"
    urlComponents.path = "/api/v2/pokemon/\(id)"
    return urlComponents.url!
  }
}

struct Pokedex: ParsableCommand {
  
  static let configuration = CommandConfiguration(
    commandName: "pokedex",
    abstract: "Allows you to fetch info from a Pokémon with its Pokédex number.",
    discussion: "")
  
  @Argument(help: "number") var number: Int
  
  func run() throws {
    PokeManager.pokemon(id: number) { (pokemon) in
      self.printInfo(for: pokemon)
    }
  }
  
  func printInfo(for pokemon: Pokemon) {
    print("----------------------------------------------------------\n")
    print("INFO FOR POKÉMON: \(number)\n")
    print("ESPECIES: \(pokemon.species.name)\n")
    print("----------------------------------------------------------\n")
  }
}
