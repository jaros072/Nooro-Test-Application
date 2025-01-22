//
//  CityDetailsDto.swift
//  Nooro Weather App
//
//  Created by William Jaros on 1/21/25.
//

import Foundation

struct CityDetailsDto: Decodable, Identifiable {
    var id: String?
    var location: Location
    var current: CurrentCityDetails
    
    enum CodingKeys: CodingKey {
        case location
        case current
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.location = try container.decode(Location.self, forKey: .location)
        self.current = try container.decode(CurrentCityDetails.self, forKey: .current)
        self.id = "\(self.location.name)\(self.location.region)\(self.location.country)"
    }
}

struct Location: Decodable {
    var name: String
    var region: String
    var country: String
}

struct CurrentCityDetails: Decodable {
    var temp_f: Double
    var condition: Condition
    var humidity: Int
    var feelslike_f: Double
    var uv: Double
}

struct Condition: Decodable {
    var text: String
    var icon: String
}
