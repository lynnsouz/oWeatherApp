//
//  APIManager.swift
//  OWeatherApp (iOS)
//
//

import Foundation

class APIManager {
    static let shared = APIManager()
    private let host: String = "https://api.openweathermap.org"
    private let forecastEndpoint: String = "/data/2.5/forecast?units=metric&appid=eda23fcc5bb7ce65e74d3cfaf6155cb8"
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}

typealias ForecastRequestHandler = (ForecastResponse?, Error?) -> Void

extension APIManager {
    func getForecastFor(lat: Double, lon: Double,
                        completion: @escaping ForecastRequestHandler) -> URLSessionDataTask {
        let url = URL(string: host+forecastEndpoint+"&lat=\(lat)&lon=\(lon)")!
        return session.codableTask(with: url) { data, _, error in
            completion(data,error)
        }
    }
}
