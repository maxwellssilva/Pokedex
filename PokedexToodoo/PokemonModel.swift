//
//  PokemonModel.swift
//  PokedexToodoo
//
//  Created by user209844 on 13/01/22.
//
import Foundation
import UIKit

//Conversor de JSON para Swift: Decodable/Codable

struct Pokemon: Codable {
    let id: Int
    let nome: String
    let tipo: [Tipo]
    let peso, altura: Int
    let habilidades: [String]
    let estatisticas: [Estatistica]
    let linkImg: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case nome = "Nome"
        case tipo = "Tipo"
        case peso = "Peso"
        case altura = "Altura"
        case habilidades = "Habilidades"
        case estatisticas = "Estatisticas"
        case linkImg = "Link_img"
    }
}

//Estatistica
struct Estatistica: Codable {
    let hp, attack, defense, specialAttack: Int?
    let specialDefense, speed: Int?

    enum CodingKeys: String, CodingKey {
        case hp, attack, defense
        case specialAttack = "special-attack"
        case specialDefense = "special-defense"
        case speed
    }
}

struct Tipo: Codable {
    var nome: String
    var cor: String
    
}
