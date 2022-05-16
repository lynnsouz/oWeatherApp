//
//  ForecastViewModel.swift
//  OWeatherApp (iOS)
//
//

import Foundation

class ForecastViewModel: ObservableObject {
    private let url: URL = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=-15.8372013&lon=-48.0258046&units=metric&appid=eda23fcc5bb7ce65e74d3cfaf6155cb8")!
    
    
    @Published var response: ForecastResponse?
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = true
    
    init() {
        fetchForecast()
    }
    
    func fetchForecast() {
        self.isLoading = true
        URLSession.shared.forecastResponseTask(with: url)
        { [weak self] forecast, _, error in
            guard let self = self else { return }
            if let error = error {
                self.updateErrorMessage(error.localizedDescription)
                return
            }
            
            guard let forecast = forecast else {
                self.updateErrorMessage("No forecast data.")
                return
            }
            
            self.updateForecast(forecast)
        }
        .resume()
    }
    
    private func updateErrorMessage(_ message: String) {
        DispatchQueue.main.async {
            self.errorMessage = message
            self.isLoading = false
        }
    }
    
    private func updateForecast(_ response: ForecastResponse) {
        DispatchQueue.main.async {
            self.response = response
            self.isLoading = false
        }
    }
}
