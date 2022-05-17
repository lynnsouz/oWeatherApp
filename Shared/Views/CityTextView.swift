//
//  CityTextView.swift
//  OWeatherApp
//
//

import SwiftUI

struct CityTextView: View{
    
    var cityName: String?
    
    var body: some View {
        Text(cityName ?? "")
            .foregroundColor(.white)
            .font(.system(size: 40, weight: .medium, design: .default))
            .padding()
    }
}

struct CityTextView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            WeatherBackgroudView(isNight: false)
            CityTextView(cityName: "City (Contry)")
        }
    }
}
