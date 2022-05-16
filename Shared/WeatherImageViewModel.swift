//
//  WeatherImageViewModel.swift
//  OWeatherApp (iOS)
//
//

import Foundation
import SwiftUI

class WeatherImageViewModel: ObservableObject {
    @Published var image: UIImage = UIImage()
    @Published var isLoading: Bool = true
    
    func loadWeatherImage(for id: String) {
        guard let url = getUrl(for: id) else { self.setErrorImage(); return }
        self.setLoading(true)
        URLSession.shared.dataTask(with: url)
        { [weak self] data, response, error in
            guard let self = self else { return }
            if let _ = error {
                self.loadWeatherImage(for: id)
                return
            }
            guard let data = data else { return }
            self.updateImage(data)
        }.resume()
    }
    
    private func updateImage(_ data: Data) {
        DispatchQueue.main.async {
            self.setLoading(false)
            if let image = UIImage(data: data) {
                self.image = image
            } else {
                self.setErrorImage()
            }
        }
    }
    
    private func setErrorImage() {
        DispatchQueue.main.async {
            self.setLoading(false)
            self.image = UIImage(systemName: "xmark.seal.fill")!
        }
    }
    
    private func setLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            self.isLoading = isLoading
        }
    }
    
    func getUrl(for id: String) -> URL? {
        URL(string: "https://openweathermap.org/img/wn/\(id)@2x.png")
    }
    
}
