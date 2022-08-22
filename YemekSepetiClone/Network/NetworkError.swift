//
//  NetworkError.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 22.08.2022.
//

import Foundation



enum AppError: LocalizedError {
    
    case ErrorDecoding
    case unknownError
    case invalidUrl
    case serverError(String)

    
    var errorDescription: String? {

        switch self {
            
        case .ErrorDecoding:
            return "Response could not decoded"
        case .unknownError:
            return "Error "
        case .invalidUrl:
            return "Url is wrong"
        case .serverError(let error):
            return error
        }
    }
    
}
