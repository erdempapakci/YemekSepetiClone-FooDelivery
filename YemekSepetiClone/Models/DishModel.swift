//
//  DishModel.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 21.08.2022.
//

import Foundation

struct Dish: Decodable {
    
    let id: String?
    let name: String?
    let description: String
    let image: String?
    let calories: Int?
    
    var formattedCalories: String {
        return "\(calories ?? 0) calories"
    }
}
