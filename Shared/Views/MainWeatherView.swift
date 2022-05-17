//
//  MainWeatherView.swift
//  OWeatherApp
//
//

import SwiftUI

struct MainWeatherView : View{
    
    var info: ForecastResponse
    @ObservedObject private var imageLoader: WeatherImageViewModel = WeatherImageViewModel()
    
    var body: some View{
        VStack(spacing: 8){
            Text("Today")
                .foregroundColor(.white)
                .font(.system(size: 24))
            ZStack{
                if imageLoader.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }
                Image(uiImage: imageLoader.image)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 88, height: 88)
                    .onAppear {
                        imageLoader.loadWeatherImage(for: info.list.first?.weather.first?.icon ?? "")
                    }
            }
            Text(info.list.first?.main.temperature ?? "")
                .foregroundColor(.white)
                .font(.system(size: 40, weight: .medium))
        }.padding(.bottom,48)
    }
}

struct MainWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            WeatherBackgroudView(isNight: true)
            MainWeatherView(info: ForecastResponse(cod: "01", message: 1, cnt: 2, list: [ForecastList(dt: 000200, main: ForecastMain(temp: 20, feelsLike: 20, tempMin: 20, tempMax: 20, pressure: 20, seaLevel: 1, grndLevel: 2, humidity: 50, tempKf: 30), weather: [ForecastWeather(id: 01, main: "main", weatherDescription: "Clouds", icon: "02d")], clouds: ForecastClouds(all: 1), wind: ForecastWind(speed: 20, deg: 2, gust: 20), visibility: 1, pop: 20, rain: Rain(the3H: 30), sys: ForecastSys(pod: "d"), dtTxt: "date")], city: City(id: 1, name: "Brasilia", coord: ForecastCoord(lat: 1000, lon: 1000), country: "BR", population: 2000, timezone: 200, sunrise: 20, sunset: 200)))
        }
        
    }
}
