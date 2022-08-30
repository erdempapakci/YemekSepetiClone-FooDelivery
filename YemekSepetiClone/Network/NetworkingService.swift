//
//  NetworkingService.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 21.08.2022.
//

import Foundation
import UIKit

struct Networkservice {

    static let shared = Networkservice()
    
    private init() {}
  
    func fetchAllCategories(completion: @escaping(Result<AllDishes, Error>) -> Void) {
        request(route: .fetchAllCategories, method: .get, completion: completion)
    }
    
    func fetchOrders(completion: @escaping(Result<[Order], Error>) -> Void) {
        
        request(route: .fetchOrders, method: .get, completion: completion)
        
    }
    
    func fetchCategoryDishes(categoryId: String, completion: @escaping(Result<[Dish], Error>) -> Void) {
        
        request(route: .fetchCategoryDishes(categoryId), method: .get, completion: completion)
        
    }
    
    func placeOrder(dishId: String, name: String, email: String, completion: @escaping(Result<Order, Error>) -> Void) {
        let parameters = [
            "name" : name,
            "email" : email
        
        ]
        request(route: .placeOrder(dishId), method: .post, parameters: parameters, completion: completion)
       
    }
  
    func request<T: Decodable>(route: Route,
                    method: Method,
                    parameters: [String : Any]? = nil,
                    completion: @escaping(Result<T, Error>) -> Void) {
        
        guard let request = createRequest(route: route, method: method, parameters: parameters) else {
            completion(.failure(AppError.unknownError))
            return}
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, Error>?
            if let data = data {
                result = .success(data)
                let responseString = String(data: data, encoding: .utf8) ?? "String is error in data "
                print("\(responseString)")
            } else if let error = error {
                result = .failure(error)
                print("error is : \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                self.handleResponse(result: result, completion: completion)
            }
        }.resume()
    }
    
    func handleResponse<T: Decodable>(result: Result<Data, Error>?,
                                      completion: (Result<T, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            
            return
        }
        switch result {
            
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(ApiResponse<T>.self, from: data) else {
                completion(.failure(AppError.ErrorDecoding))
                return
            }
            if let error = response.error {
                completion(.failure(AppError.serverError(error)))
                
            }
            if let decodeData = response.data {
                completion(.success(decodeData))
            }else {
                completion(.failure(AppError.ErrorDecoding))
            }
        case .failure(let error):
            completion(.failure(error))
        }
        
    }
    
    func createRequest(route: Route,
                       method: Method,
                       parameters: [String: Any]? = nil) -> URLRequest? {
        
        let urlString = Route.baseUrl + route.description
        guard let url = urlString.asUrl else { return nil}
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod =  method.rawValue
        
        if let parameterS = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = parameterS.map { URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlComponent?.url
                
            case .post:
                let bodyData = try? JSONSerialization.data(withJSONObject: parameterS, options: [])
                urlRequest.httpBody = bodyData
            case .delete:
                let bodyData = try? JSONSerialization.data(withJSONObject: parameterS, options: [])
                urlRequest.httpBody = bodyData
            case .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: parameterS, options: [])
                urlRequest.httpBody = bodyData
                
            }
        }
        return urlRequest
    }
    
}
