//
//  Meals.swift
//  Recieps
//
//  Created by Rodrigo Vart on 10/07/22.
//

import Foundation

public struct MealsResult: Decodable {
    var meals: [Meals]
}

public struct Meals: Decodable {
    var idMeal: String
    var strMeal: String
    var strCategory: String
    var strInstructions: String
    var strMealThumb: String
    var strTags: String?
    var strYoutube: String
}
