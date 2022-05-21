//
//  ForecastViewModel.swift
//  OWeatherApp (iOS)
//
//

import Foundation

class ForecastViewModel: ObservableObject {
    private var coord: ForecastCoord
    
    @Published var response: ForecastResponse?
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = true
    
    init(coord: ForecastCoord = ForecastCoord(lat: -15.8372013, lon: -48.0258046)) {
        self.coord = coord
        fetchForecast()
    }
    
    func fetchForecast() {
        self.isLoading = true
        APIManager.shared.getForecastFor(lat: coord.lat, lon: coord.lon)
        { [weak self] forecast, error in
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
        print(response)
        DispatchQueue.main.async {
            self.response = response
            self.isLoading = false
        }
    }
}
