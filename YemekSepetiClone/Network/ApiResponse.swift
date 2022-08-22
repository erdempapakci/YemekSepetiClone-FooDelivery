//
//  ApiResponse.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 22.08.2022.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    
    let status: Int
    let message: String?
    let data: T?
    let error: String?
    
}
