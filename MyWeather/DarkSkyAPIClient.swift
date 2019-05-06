//
//  DarkSkyAPIClient.swift
//  MyWeather
//
//  Created by Patrick Bean on 5/3/19.
//  Copyright © 2019 TheDevBean. All rights reserved.
//

import Foundation
import CoreLocation

class DarkSkyAPIClient {
    fileprivate let darkSkyApiKey = "cdf6c8823e4b0b03dbc1ef6f9850d7bf"
    
    lazy var baseURL: URL = {
        return URL(string: "https://api.darksky.net/forecast/\(self.darkSkyApiKey)/")!
    }()
    
    let decoder = JSONDecoder()
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    typealias WeatherCompletionHandler = (Weather?, Error?) -> Void
    typealias CurrentWeatherCompletionHandler =  (CurrentWeather?, Error?) -> Void
    
    func getWeather(at coordinate: CLLocationCoordinate2D, completionHandler completion: @escaping WeatherCompletionHandler) {
        let coordinateString = "\(coordinate.latitude),\(coordinate.longitude)"
        guard let url = URL(string: coordinateString, relativeTo: baseURL) else {
            completion(nil, DarkSkyError.invalidURL)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) {data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, DarkSkyError.requestFailed)
                        return
                    }
                    if httpResponse.statusCode == 200 {
                        do {
                            let weather = try self.decoder.decode(Weather.self, from: data)
                            completion(weather, nil)
                        } catch {
                            completion(nil, error)
                        }
                        
                    } else {
                        completion(nil, DarkSkyError.invalidData)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }
    
    
    func getCurrentWeather(at coordinate: CLLocationCoordinate2D, completionHandler completion: @escaping WeatherCompletionHandler) {
        getWeather(at: coordinate) { weather, error in
            completion(weather, error)
        }
    }
}
