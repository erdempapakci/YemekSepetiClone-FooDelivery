# YemekSepetiClone-FooDelivery

 <img src="https://img.shields.io/badge/status-Active-green" height="20">.  <img src="https://img.shields.io/badge/language-Swift-yellow" height="20"> 


<img src="https://user-images.githubusercontent.com/73407945/186963408-7511aed8-5802-48e8-8817-165554ee109b.gif" width="300" height="600" /> <img src="https://user-images.githubusercontent.com/73407945/186964512-891c5fea-6ba3-4f12-aea9-4a79eaae92e4.gif" width="300" height="600" />
# Introduction

YemekSepetiClone-FooDelivery is a delivery app which is used location and user connected to Firebase. 

# Which Pods did I use ?

```javascript 
pod 'Kingfisher', '~> 7.0'
pod 'ProgressHUD'
pod 'Firebase/Analytics'
pod 'Firebase/Auth'
pod 'Firebase/Core'
pod 'Firebase/Firestore'
pod 'Firebase/Storage'
 ```

# Network

## Creating Request
```javascript 
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
 ```
 ## Handling Response

```javascript 
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
 ```
 # Card View

```javascript 
import Foundation
import UIKit

class CardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSet()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSet()
    }
    func initialSet() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        cornerRadius = 10
    }
}

 ```

<img src="https://user-images.githubusercontent.com/73407945/186971428-3aaebe4d-1a2d-4e44-817a-ff3ecd3dfc5e.png" width="200" height="400" />.         <img src="https://user-images.githubusercontent.com/73407945/186971470-839dd094-f419-45c4-88be-1b64b0f4c0e8.png" width="200" height="400" />.    <img src="https://user-images.githubusercontent.com/73407945/186971457-d1af0f1d-aa22-48e9-9f1b-73b403f9aed9.png" width="200" height="400" />

