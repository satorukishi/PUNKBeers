//
//  Beer.swift
//  RM43057
//
//  Created by Satoru Kishi on 09/07/2018.
//  Copyright © 2018 Satoru Kishi. All rights reserved.
//

import Foundation

class Beer: Codable {
    var id: Int?
    var name: String = ""
    var tagline: String = ""
    var first_brewed: String = ""
    var description: String = ""
    var image_url: String = ""
    var abv: Float = 0.0
    var ibu: Float = 0.0
    var target_fg: Float = 0
    var target_og: Float = 0
    var ebc: Float? = 0
    var srm: Float? = 0
    var ph: Float = 0.0
    var attenuation_level: Float = 0
    var volume: Volume
    var boil_volume: Volume
    var method: Method
    var ingredients: Ingredients
    var food_pairing: [String]
    var brewers_tips: String
    var contributed_by: String
}

struct Volume: Codable {
    var value: Int
    var unit: String
}

struct Method: Codable {
    var mash_temp: [MashTemp]
    var fermentation: Fermentation
    var twist: String?
}

struct MashTemp: Codable {
    var temp: Volume
    var duration: Float?
}

struct Fermentation: Codable {
    var temp: Volume
}

struct Ingredients: Codable {
    var malt: [Malt]
    var hops: [Hops]
    var yeast: String
}

struct Malt: Codable {
    var name: String
    var amount: Volume
}

struct Hops: Codable {
    var name: String
    var amount: Volume
    var add: String
    var attribute: String
}
