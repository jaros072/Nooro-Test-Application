//
//  ContentView.swift
//  Nooro Weather App
//
//  Created by William Jaros on 1/20/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    
    var body: some View {
        ZStack{
            Color(red: 242/255, green: 242/255, blue: 242/255)
            HStack {
                TextField("Search Location", text: $vm.searchLocation)
                    .foregroundColor(Color(red: 44/255, green: 44/255, blue: 44/255))
                    .font(.system(size: 15, weight: .regular))
                    .onReceive(
                        vm.$searchLocation
                            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
                    ) {
                        guard !$0.isEmpty else { return }
                        self.vm.getFilteredCities(searchTerm: $0)
                    }
                Spacer()
                Image("search_24px")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
            }
            .padding(.horizontal)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .frame(height: 40)
        .padding()
        


        if vm.searchLocation.isEmpty {
            if let cityDetails = self.vm.currentlySelectedCityDetails {
                SelectedCityDetailView(cityDetails: cityDetails)
            } else {
                VStack(spacing: 16) {
                    Spacer()
                    Text("No City Selected")
                        .font(.system(size: 30, weight: .bold))
                    Text("Please Search For A City")
                        .font(.system(size: 15, weight: .bold))
                    Spacer()
                }
            }
        } else {
            VStack {
                ForEach(vm.searchResultCityDetails) { city in
                    CitySearchResultView(city: city.location.name, temperature: "\(Int(city.current.temp_f))", iconURL: city.current.condition.icon)
                        .padding(.vertical, 8)
                        .onTapGesture {
                            self.vm.searchLocation = ""
                            self.vm.currentlySelectedCityDetails = city
                            UserConfigs.storeCurrentCity(cityName: city.location.name)
                        }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
