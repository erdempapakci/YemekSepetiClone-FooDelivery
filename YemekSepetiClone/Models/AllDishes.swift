//
//  AllDishes.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 22.08.2022.
//

import Foundation


struct AllDishes: Decodable {
    
    let categories: [DishCategory]?
    let populars: [Dish]?
    let specials: [Dish]?
    
    
    
}
