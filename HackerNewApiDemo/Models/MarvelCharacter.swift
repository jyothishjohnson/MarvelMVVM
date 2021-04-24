//
//  MarvelCharacter.swift
//  HackerNewApiDemo
//
//  Created by jyothish.johnson on 27/03/21.
//

import Foundation

struct MarvelCharacter: Decodable, Hashable{
    let id : Int?
    let name : String?
    let thumbnail : MarvelCharacterImage?
    
    var imageURL :  String {
        return "\(thumbnail?.path ?? "").\(thumbnail?.extension ?? "")"
    }
    
    static func characterMapper(characters: [MCharacter]) -> [Self]{
        
        let mapped: [Self] = characters.map { (character) -> MarvelCharacter in
            let mappedPath = mapImagePath(from: character.imageURL ?? "")
            let marvelCharacter = MarvelCharacter(id: Int(character.id), name: character.name, thumbnail: MarvelCharacterImage(path: mappedPath.path, extension: mappedPath.extension))
            
            return marvelCharacter
        }
        
        return mapped
    }
    
    private static func mapImagePath(from urlString : String) -> (path:String?, extension: String?){
        
        if let range = urlString.range(of: ".", options: .backwards){
            let pathSubstring = urlString[urlString.startIndex..<urlString.index(before: range.upperBound)]
            let startIndexForExtension = urlString.index(after: range.lowerBound)
            return (String(pathSubstring),String(urlString[startIndexForExtension...]))
        }

        return (nil,nil)
    }
}


