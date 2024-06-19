//
//  APIManager.swift
//  MVVMExample
//
//  Created by WhyQ on 21/03/24.
//

import UIKit

enum DataError:Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(_ error:Error?)
}

typealias handler = (Result<[Product], DataError>) -> Void
//Singleton Design pattern
final class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func fetchProduct(completion: @escaping handler) {
        guard let url = URL(string: Constant.API.productURL) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                return
            }
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            //JSONDecoder() data ko model me decode karta hai 
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            }catch {
                completion(.failure(.network(error)))
            }
        }.resume()
    }
}

//singleton - outside object create kar sakte hai
//SingleTon - outside object create nahi hoga
