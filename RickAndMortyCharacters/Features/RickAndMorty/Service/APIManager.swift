//
//  APIManager.swift
//  RickAndMortyCharacters
//
//  Created by İbrahim Bayram on 6.03.2023.
//

import Foundation

//Request URL 
enum RickAndMortyServiceEndPoint : String {
    
    case BASE_URL = "https://rickandmortyapi.com/api"
    case PATH = "/character"
    
    static func characterPath() -> String {
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}

//Fetch Daha soyutlaması
protocol ServiceProtocol {
    func fetchAllData(completion : @escaping(Result<PostModel, Error>)->Void)
}

struct APIManager : ServiceProtocol {
    func fetchAllData(completion : @escaping(Result<PostModel, Error>)->Void) {
        URLSession.shared.dataTask(with: URL(string: RickAndMortyServiceEndPoint.characterPath())!) { (data, _, error) in
            guard let data = data else {return}
            do {
                DispatchQueue.main.async {
                    let jsonData = try? JSONDecoder().decode(PostModel.self, from: data)
                    guard let jsonData = jsonData else {return}
                    completion(.success(jsonData))
                    
                }
            }catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
