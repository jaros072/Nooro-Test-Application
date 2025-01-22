//
//  APIService.swift
//  Nooro Weather App
//
//  Created by William Jaros on 1/20/25.
//

import Foundation

protocol APIServiceProtocol {
    func getFilteredCities(searchTerm: String, completion: @escaping ([CityDto]) -> Void)
    func getWeatherCurrentCity(cityName: String) async -> CityDetailsDto?
}

final class APIService: APIServiceProtocol {
    internal let baseURL = "https://api.weatherapi.com/v1/"
    
    //Function to call an API to get all cities based on a search term.
    func getFilteredCities(searchTerm: String, completion: @escaping ([CityDto]) -> Void) {
        let urlString = "\(baseURL)search.json?key=\(Constants.weatherAPIKey)&q=\(searchTerm)"
        let url = URL(string: urlString, encodingInvalidCharacters: true)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _data = data else {
                completion([])
                return
            }
            
            do {
                let result = try JSONDecoder().decode([CityDto].self, from: _data)
                completion(result)
                print("Succeeding calling search endpoint - \(result.count)")
            } catch let error {
                print("Error calling API - \(error)")
                completion([])
            }
        }.resume()
    }
    
    //Function to call an API to get current weather for a specific city.
    func getWeatherCurrentCity(cityName: String) async -> CityDetailsDto? {
        let urlString = "\(baseURL)current.json?key=\(Constants.weatherAPIKey)&q=\(cityName)"
        let url = URL(string: urlString, encodingInvalidCharacters: true)
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url!)
            let result = try JSONDecoder().decode(CityDetailsDto.self, from: data)
            print("Succeeding calling weather endpoint - \(result.location.name)")
            return result
        } catch let error {
            print("Error calling API - \(error)")
            return nil
        }
    }
}
