//
//  HomeViewModel.swift
//  Nooro Weather App
//
//  Created by William Jaros on 1/22/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var searchLocation: String = ""
    @Published var searchResultCityDetails: [CityDetailsDto] = []
    @Published var currentlySelectedCityDetails: CityDetailsDto?
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        DispatchQueue.main.async {
            Task {
                if let cityName = UserConfigs.getCurrentCity() {
                    self.currentlySelectedCityDetails = await self.apiService.getWeatherCurrentCity(cityName: cityName)
                }
            }
        }
    }
    
    //Function that gets all cities based on the search term and loads all the city details for each of them.
    //Could be more efficient on the backend side to make it so it only requires one backend call for search results and simple weather data.
    //The way it's set up requires an API call for the search, and an API call for each city that is returned in the search call.
    func getFilteredCities(searchTerm: String) {
        self.apiService.getFilteredCities(searchTerm: searchTerm) { [weak self] cities in
            print("Succeeded getting filtered cities.")
            DispatchQueue.main.async {
                guard let self = self else { return }
                Task {
                    do {
                        var allCityDetailsDto = [CityDetailsDto]()
                        try await withThrowingTaskGroup(of: CityDetailsDto?.self) { group in
                            for city in cities {
                                group.addTask {
                                    await self.apiService.getWeatherCurrentCity(cityName: city.name)
                                }
                            }
                            
                            for try await cities in group {
                                if let city = cities {
                                    allCityDetailsDto.append(city)
                                }
                            }
                        }
                        self.searchResultCityDetails = allCityDetailsDto
                        print("Succeeded getting all city details.")
                    } catch let error {
                        print("Succeeded getting filtered cities: \(error).")
                    }
                }
            }
        }
    }
}
