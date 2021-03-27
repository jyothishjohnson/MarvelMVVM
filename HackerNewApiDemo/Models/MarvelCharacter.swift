//
//  MarvelCharacter.swift
//  HackerNewApiDemo
//
//  Created by jyothish.johnson on 27/03/21.
//

import Foundation

struct MarvelCharacter: Decodable{
    let id : Int?
    let name : String?
    let thumbnail : MarvelCharacterImage?
}


