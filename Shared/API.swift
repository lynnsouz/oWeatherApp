//
//  API.swift
//  OWeatherApp (iOS)
//
//

import Foundation

typealias ForecastRequestHandler = (ForecastResponse?, URLResponse?, Error?) -> Void

extension URLSession {
    
    func forecastResponseTask(with url: URL,
                              completionHandler: @escaping ForecastRequestHandler) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
    
}
