//
//  WheatherViewModel.swift
//  OWeatherApp (iOS)
//
//

import Foundation

class WheatherViewModel: ObservableObject {
    private let url: URL = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=-15.8372013&lon=-48.0258046&units=metric&appid=eda23fcc5bb7ce65e74d3cfaf6155cb8")!
    
    
    @Published var response: WeatherResponse?
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = true
    
    init() {
        fetchWeather()
    }
    
    func fetchWeather() {
        self.isLoading = true
        URLSession.shared.weatherResponseTask(with: url)
        { [weak self] weather, response, error in
            guard let self = self else { return }
            if let error = error {
                self.updateErrorMessage(error.localizedDescription)
                return
            }
            
            guard let weather = weather else {
                self.updateErrorMessage("No data.")
                return
            }
            
            self.updateWeather(weather)
        }
        .resume()
    }
    
    private func updateErrorMessage(_ message: String) {
        DispatchQueue.main.async {
            self.errorMessage = message
            self.isLoading = false
        }
    }
    
    private func updateWeather(_ weather: WeatherResponse) {
        DispatchQueue.main.async {
            self.response = weather
            self.isLoading = false
        }
    }
}
