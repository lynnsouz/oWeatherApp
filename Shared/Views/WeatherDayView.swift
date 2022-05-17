//
//  WeatherDayView.swift
//  OWeatherApp
//
//

import SwiftUI

struct WeatherDayView: View {
    
    var day: ForecastList
    
    @ObservedObject private var imageLoader: WeatherImageViewModel = WeatherImageViewModel()
    
    var body: some View {
        VStack{
            Text(day.date.getHumanReadableDayString())
                .foregroundColor(.white)
            ZStack {
                if imageLoader.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }
                Image(uiImage: imageLoader.image)
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .onAppear {
                        imageLoader.loadWeatherImage(for: day.weather.first?.icon ?? "")
                    }
            }
            Text(day.main.temperature)
                .foregroundColor(.white)
        }
    }
}

struct WeatherDayView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            WeatherBackgroudView(isNight: false)
            WeatherDayView(day: ForecastList(dt: 0003030, main: ForecastMain(temp: 20, feelsLike: 20, tempMin: 30, tempMax: 30, pressure: 30, seaLevel: 30, grndLevel: 30, humidity: 30, tempKf: 30), weather: [ForecastWeather(id: 02, main: "MAIN", weatherDescription: "description", icon: "02d")], clouds: ForecastClouds(all: 3), wind: ForecastWind(speed: 20, deg: 29, gust: 29), visibility: 3, pop: 39, rain: Rain(the3H: 399), sys: ForecastSys(pod: "pod"), dtTxt: "text"))
        }
    }
}
