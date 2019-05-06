//
//  Weather.swift
//  MyWeather
//
//  Created by Patrick Bean on 5/3/19.
//  Copyright © 2019 TheDevBean. All rights reserved.
//

import Foundation
import UIKit

struct Weather: Codable {
    let currently: CurrentWeather
    let hourly: HourlyWeather
    let daily: DailyWeather
    let alerts: [alert]?
    
}

extension Weather {
    func getIconImage(for icon: String) -> UIImage {
        switch icon {
        case "clear-day": return #imageLiteral(resourceName: "clear-day")
        case "clear-night": return #imageLiteral(resourceName: "cler-night")
        case "rain": return #imageLiteral(resourceName: "rain")
        case "snow": return #imageLiteral(resourceName: "snow")
        case "sleet": return #imageLiteral(resourceName: "sleet")
        case "wind": return #imageLiteral(resourceName: "wind")
        case "fog": return #imageLiteral(resourceName: "fog")
        case "cloudy": return #imageLiteral(resourceName: "cloudy")
        case "partly-cloudy-day": return #imageLiteral(resourceName: "default")
        case "partly-cloudy-night": return #imageLiteral(resourceName: "partly-cloudy-night")
        case "advisory": return #imageLiteral(resourceName: "alert")
        case "watch": return #imageLiteral(resourceName: "watch")
        case "warning": return #imageLiteral(resourceName: "warning")
        default: return #imageLiteral(resourceName: "default")
        }
    }
}

struct CurrentWeather: Codable {
    let time: Double
    let summary: String
    let icon: String
    let precipProbability: Double
    let temperature: Double
    let apparentTemperature: Double
    let dewPoint: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let windGust: Double
    let windBearing: Double
    let cloudCover: Double
    let uvIndex: Int
    let visibility: Double
    let ozone: Double
    
    enum CodingKeys: String, CodingKey {
        case time
        case summary
        case icon
        case precipProbability
        case temperature
        case apparentTemperature
        case dewPoint
        case humidity
        case pressure
        case windSpeed
        case windGust
        case windBearing
        case cloudCover
        case uvIndex
        case visibility
        case ozone
    }
}

struct HourlyWeather: Codable {
    let summary: String
    let icon: String
    let data: [HourWeather]
}

struct HourWeather: Codable {
    let time: Double
    let summary: String
    let icon: String
    let precipProbability: Double
    let temperature: Double
    let apparentTemperature: Double
    let dewPoint: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let windGust: Double
    let windBearing: Double
    let cloudCover: Double
    let uvIndex: Int
    let visibility: Double
    let ozone: Double
}

struct DailyWeather: Codable {
    let summary: String
    let icon: String
    let data: [DayWeather]
}

struct DayWeather: Codable {
    let time: Double
    let summary: String
    let icon: String
    let sunriseTime: Double
    let sunsetTime: Double
    let moonPhase: Double
    let precipProbability: Double
    let precipType: String
    let temperatureHigh: Double
    let temperatureHighTime: Double
    let temperatureLow: Double
    let temperatureLowTime: Double
    let apparentTemperatureHigh: Double
    let apparentTemperatureHighTime: Double
    let apparentTemperatureLow: Double
    let apparentTemperatureLowTime: Double
    let dewPoint: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let windGust: Double
    let windGustTime: Double
    let windBearing: Double
    let cloudCover: Double
    let uvIndex: Int
    let uvIndexTime: Double
    let visibility: Double
    let ozone: Double
    let temperatureMin: Double
    let temperatureMinTime: Double
    let temperatureMax: Double
    let temperatureMaxTime: Double
    let apparentTemperatureMin: Double
    let apparentTemperatureMinTime: Double
    let apparentTemperatureMax: Double
    let apparentTemperatureMaxTime: Double
}

struct alert: Codable {
    let title: String
    let severity: String
    let time: Double
    let expires: Double
    let description: String
    let uri: URL
}
