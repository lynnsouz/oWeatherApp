//
//  BackgroudView.swift
//  OWeatherApp
//
//

import SwiftUI

struct WeatherBackgroudView: View {
    var isNight: Bool = false
    
    var body: some View {
        LinearGradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")], startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}


struct WeatherBackgroudView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherBackgroudView(isNight: false)
        WeatherBackgroudView(isNight: true)
    }
}

