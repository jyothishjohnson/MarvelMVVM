//
//  NewsListViewModel.swift
//  HackerNewApiDemo
//
//  Created by jyothish.johnson on 27/03/21.
//

import Foundation

final class MCharacterListViewModel {
    
    static let base = "https://gateway.marvel.com/"
    static let ts = "1616790639"
    static let apikey = "e5485027d898a87c3809c77a12e0591e"
    static let hash = "8a90000c7eb3c0030bf9aedcaa36445f"
    
    static let characters = "/v1/public/characters"
//    https://gateway.marvel.com/v1/public/characters?ts=1616790639&apikey=e5485027d898a87c3809c77a12e0591e&hash=8a90000c7eb3c0030bf9aedcaa36445f
    
    
    static func loadNewsList(offset : Int = 0, completion : @escaping ([MarvelCharacter]) -> ()){
        NetworkManager.shared.makeRequest(createAPIEndpoint(to: characters, offset: offset)) {
            (res : Result<MarvelResponse,NetworkManagerError>) in
            switch res {
            
            case .success(let response):
                completion(response.data?.results ?? [])
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    fileprivate static func createAPIEndpoint(to hit : String, offset : Int) -> URLRequest{
        var url = URL(string: MCharacterListViewModel.base)
        url?.appendPathComponent(hit)
        var components = URLComponents(url: url!, resolvingAgainstBaseURL: false)
        components!.queryItems = [
            URLQueryItem(name: "ts", value: MCharacterListViewModel.ts),
            URLQueryItem(name: "apikey", value: MCharacterListViewModel.apikey),
            URLQueryItem(name: "hash", value: MCharacterListViewModel.hash),
            URLQueryItem(name: "offset", value: "\(offset)")]
        var urlRequest = URLRequest(url: components!.url!)
        urlRequest.httpMethod = NetworkMethods.GET.rawValue
        return urlRequest
    }

}
