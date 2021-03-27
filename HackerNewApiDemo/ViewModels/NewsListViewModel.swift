//
//  NewsListViewModel.swift
//  HackerNewApiDemo
//
//  Created by jyothish.johnson on 27/03/21.
//

import Foundation

class NewsListViewModel {
    
    let base = "https://gateway.marvel.com/"
    let ts = "1616790639"
    let apikey = "e5485027d898a87c3809c77a12e0591e"
    let hash = "8a90000c7eb3c0030bf9aedcaa36445f"
    
    let characters = "/v1/public/characters"
//    https://gateway.marvel.com/v1/public/characters?ts=1616790639&apikey=e5485027d898a87c3809c77a12e0591e&hash=8a90000c7eb3c0030bf9aedcaa36445f
    
    
    func loadNewsList(completion : @escaping ([MarvelCharacter]) -> ()){
        NetworkManager.shared.makeRequest(createAPIEndpoint(to: characters)) { (res : Result<MarvelResponse,NetworkManagerError>) in
            switch res {
            
            case .success(let response):
                completion(response.data?.results ?? [])
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    fileprivate func createAPIEndpoint(to hit : String) -> URLRequest{
        var url = URL(string: base)
        url?.appendPathComponent(hit)
        var components = URLComponents(url: url!, resolvingAgainstBaseURL: false)
        components!.queryItems = [
            URLQueryItem(name: "ts", value: ts),
            URLQueryItem(name: "apikey", value: apikey),
            URLQueryItem(name: "hash", value: hash)]
     
        var urlRequest = URLRequest(url: components!.url!)
        urlRequest.httpMethod = NetworkMethods.GET.rawValue
        return urlRequest
    }

}
