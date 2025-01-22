//
//  SelectedCityDetailView.swift
//  Nooro Weather App
//
//  Created by William Jaros on 1/22/25.
//

import Foundation

import SwiftUI

struct SelectedCityDetailView: View {
    @State var cityDetails: CityDetailsDto
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https:\(cityDetails.current.condition.icon)"))
                .frame(width: 123, height: 123)
            HStack {
                Text(cityDetails.location.name)
                    .font(.system(size: 30, weight: .bold))
                Image("Vector")
                    .frame(width: 21, height: 21)
            }
            Text("\(Int(cityDetails.current.temp_f))°")
                .font(.system(size: 70, weight: .bold))
            ZStack {
                Color(red: 242/255, green: 242/255, blue: 242/255)
                HStack {
                    VStack {
                        Text("Humidity")
                            .foregroundColor(Color(red: 196/255, green: 196/255, blue: 196/255))
                        Text("\(cityDetails.current.humidity)%")
                            .foregroundColor(Color(red: 154/255, green: 154/255, blue: 154/255))
                    }
                    Spacer()
                    VStack {
                        Text("UV")
                            .foregroundColor(Color(red: 196/255, green: 196/255, blue: 196/255))
                        Text("\(Int(cityDetails.current.uv))")
                            .foregroundColor(Color(red: 154/255, green: 154/255, blue: 154/255))
                    }
                    Spacer()
                    VStack {
                        Text("Feels Like")
                            .foregroundColor(Color(red: 196/255, green: 196/255, blue: 196/255))
                        Text("\(Int(cityDetails.current.feelslike_f))°")
                            .foregroundColor(Color(red: 154/255, green: 154/255, blue: 154/255))
                    }
                }
                .padding(.horizontal)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal, 40)
            .frame(height: 80)
        }
        .padding()
        Spacer()
    }
}
