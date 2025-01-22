//
//  CitySearchResultView.swift
//  Nooro Weather App
//
//  Created by William Jaros on 1/21/25.
//

import Foundation
import SwiftUI

struct CitySearchResultView: View {
    @State var city: String
    @State var temperature: String
    @State var iconURL: String
    
    var body: some View {
        ZStack {
            Color(red: 242/255, green: 242/255, blue: 242/255)
            HStack {
                VStack {
                    Text(city)
                        .font(.system(size: 20, weight: .bold))
                    Text("\(temperature)°")
                        .font(.system(size: 60, weight: .bold))
                }
                Spacer()
                AsyncImage(url: URL(string: "https:\(iconURL)"))
                    .frame(width: 123, height: 123)
            }
            .padding(.horizontal, 32)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
        .frame(height: 117)
    }
}

#Preview {
    CitySearchResultView(city: "London", temperature: "33", iconURL: "//cdn.weatherapi.com/weather/64x64/day/116.png")
}
