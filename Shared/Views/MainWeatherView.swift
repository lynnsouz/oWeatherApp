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
                VStack {
                    Image(uiImage: imageLoader.image)
                        .frame(width: 88, height: 88)
                        .onAppear {
                            imageLoader.loadWeatherImage(for: info.list.first?.weather.first?.icon ?? "")
                        }
                    Text(info.list.first?.weather.first?.main ?? "")
                        .foregroundColor(.white)
                        .font(.headline)
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
            
            MainWeatherView(info: ForecastResponse(cod: "200",
                                                   message: 0,
                                                   cnt: 40,
                                                   list: [ForecastList(dt: 1652907600.0,
                                                                       main: ForecastMain(temp: 14.25,
                                                                                          feelsLike: 12.54,
                                                                                          tempMin: 14.25,
                                                                                          tempMax: 14.25,
                                                                                          pressure: 1016,
                                                                                          seaLevel: 1016,
                                                                                          grndLevel: 889,
                                                                                          humidity: 31,
                                                                                          tempKf: 0.0),
                                                                       weather: [ForecastWeather(id: 803,
                                                                                                 main: "Clouds",
                                                                                                 weatherDescription: "broken clouds",
                                                                                                 icon: "04n")],
                                                                       clouds: ForecastClouds(all: 75),
                                                                       wind: ForecastWind(speed: 3.81, deg: 207, gust: 7.82),
                                                                       visibility: 10000,
                                                                       pop: 0.0,
                                                                       rain: nil,
                                                                       sys: ForecastSys(pod: "n"),
                                                                       dtTxt: "2022-05-18 21:00:00")],
                                                   city: City(id: 3469058,
                                                              name: "Brasília",
                                                              coord: ForecastCoord(lat: -15.8372, lon: -48.0258),
                                                              country: "BR",
                                                              population: 1000000,
                                                              timezone: -10800,
                                                              sunrise: 1652866087,
                                                              sunset: 1652906951)))
        }
    }
}
