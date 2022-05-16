//
//  ContentView.swift
//  Shared
//
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var wheatherViewModel: WheatherViewModel
    @ObservedObject var forecastViewModel: ForecastViewModel
    
    init(wheatherViewModel: WheatherViewModel = WheatherViewModel(),
         forecastViewModel: ForecastViewModel = ForecastViewModel()) {
        self.wheatherViewModel = wheatherViewModel
        self.forecastViewModel = forecastViewModel
    }
    
    var body: some View {
        ZStack {
            BackgroudView()
            VStack{
                if wheatherViewModel.isLoading {
                    Spacer()
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .foregroundColor(.white)
                        .font(.system(size: 32, weight: .medium, design: .default))
                        .padding()
                    Spacer()
                } else if !wheatherViewModel.errorMessage.isEmpty {
                    Text(wheatherViewModel.errorMessage)
                        .foregroundColor(.white)
                        .bold()
                } else {
                    CityTextView(cityName: wheatherViewModel.response?.cityDescription)
                    if let response = forecastViewModel.response {
                        MainWeatherView(info: response)
                    }
                    
                    if forecastViewModel.isLoading {
                        ProgressView("Loading forecast...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .foregroundColor(.white)
                    } else if !forecastViewModel.errorMessage.isEmpty {
                        Text(forecastViewModel.errorMessage)
                            .foregroundColor(.white)
                            .bold()
                    } else {
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct BackgroudView: View {
    var isNight: Bool = false
    
    var body: some View {
        
        LinearGradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")], startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}


struct CityTextView: View{
    
    var cityName: String?
    
    var body: some View{
        Text(cityName ?? "")
            .foregroundColor(.white)
            .font(.system(size: 40, weight: .medium, design: .default))
            .padding()
    }
}

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
