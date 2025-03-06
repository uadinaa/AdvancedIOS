//
//  Model.swift
//  MHAheroRandomizer
//
//  Created by Дина Абитова on 06.03.2025.
//
import Foundation


struct Hero: Codable {
    let id: Int
    let name: String
    let powerstats: PowerStats
    let appearance: Appearance
    let biography: Biography
    let work: Work
    let connections: Connections
    let images: Images
}

struct PowerStats: Codable {
    let intelligence, strength, speed, durability, power, combat: Int
}

struct Appearance: Codable {
    let gender: String
    let race: String?
    let height: [String]
    let weight: [String]
    let eyeColor: String
    let hairColor: String
}

struct Biography: Codable {
    let fullName, alterEgos, placeOfBirth, firstAppearance, publisher, alignment: String?
}

struct Work: Codable {
    let occupation, base: String?
}

struct Connections: Codable {
    let groupAffiliation, relatives: String?
}

struct Images: Codable {
    let lg: String  // Большая картинка героя
}

