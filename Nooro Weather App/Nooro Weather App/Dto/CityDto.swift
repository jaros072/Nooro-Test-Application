//
//  CityDto.swift
//  Nooro Weather App
//
//  Created by William Jaros on 1/20/25.
//

import Foundation

struct CityDto: Decodable, Identifiable {
    var id: Int
    var name: String
    var country: String
}
