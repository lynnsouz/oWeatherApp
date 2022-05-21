//
//  ContentView.swift
//  Shared
//
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var forecastViewModel: ForecastViewModel
    
    init(forecastViewModel: ForecastViewModel = ForecastViewModel()) {
        self.forecastViewModel = forecastViewModel
    }
    
    var body: some View {
        ZStack {
            WeatherBackgroudView(isNight: forecastViewModel.response?.list.first?.sys.pod == "n")
            VStack{
                if forecastViewModel.isLoading {
                   LoadingView()
                } else if !forecastViewModel.errorMessage.isEmpty {
                    Text(forecastViewModel.errorMessage)
                        .foregroundColor(.white)
                        .bold()
                } else {
                    //ChangeCityButton()
                    CityTextView(cityName: forecastViewModel.response?.cityDescription)
                    if let response = forecastViewModel.response {
                        MainWeatherView(info: response)
                    }
                    
                    HStack (spacing: 25){
                        ForEach(forecastViewModel.response?.filteredList[1...4] ?? [], id: \.dt)
                        { day in
                            WeatherDayView(day: day)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
