# YemekSepetiClone-FooDelivery





<img src="https://user-images.githubusercontent.com/73407945/187550716-945280b5-0f3e-4cf2-90d7-cffa49308281.gif" width="200" height="400" /><img src="https://user-images.githubusercontent.com/73407945/187552446-bb6b0678-6938-4ccf-a87f-4ca9c1a55a29.png" width="200" height="400" /> <img src="https://user-images.githubusercontent.com/73407945/187550821-349bc406-7795-46bf-80ad-f3593e17900d.gif" width="200" height="400" /><img src="https://user-images.githubusercontent.com/73407945/187552475-3ae33c4d-9bc0-47ce-b145-a79bd9ec4351.png" width="200" height="400" /> <img src="https://user-images.githubusercontent.com/73407945/187550832-7c701cf2-1a2e-4f0d-a738-90d5b47f8aed.gif" width="200" height="400" />



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


