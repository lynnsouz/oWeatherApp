//
//  APIManager.swift
//  OWeatherApp (iOS)
//
//

import Foundation

class APIManager {
    static let shared = APIManager()
    private let host: String = "https://api.openweathermap.org"
    private let forecastEndpoint: String = "/data/2.5/forecast?units=metric"
    private let session: URLSession
    private var APIKey: String {
        (Bundle.main.infoDictionary?["WeatherAPIKey"] as? String) ?? ""
    }
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}

typealias ForecastRequestHandler = (ForecastResponse?, Error?) -> Void

extension APIManager {
    func getForecastFor(lat: Double, lon: Double,
                        completion: @escaping ForecastRequestHandler) -> URLSessionDataTask {
        let url = URL(string: host+forecastEndpoint+"&lat=\(lat)&lon=\(lon)&appid=\(APIKey)")!
        return session.codableTask(with: url) { data, _, error in
            completion(data,error)
        }
    }
}
