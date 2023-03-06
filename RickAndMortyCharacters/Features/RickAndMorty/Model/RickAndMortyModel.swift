//
//  RickAndMortyModel.swift
//  RickAndMortyCharacters
//
//  Created by İbrahim Bayram on 6.03.2023.
//

import Foundation

struct PostModel : Codable {
    let info : Info
    let results : [Results]
}

struct Info : Codable {
    let count : Int
    let pages : Int
    let next : String
}

struct Results : Codable {
    let id : Int
    let name : String
    let status : String
    let species : String
    let type : String
    let gender : String
    let origin : Location
    let location : Location
    let image : String
    let episode : [String]
    let url : String
    let created : String
}

struct Location : Codable {
    let name : String
    let url  : String
}
