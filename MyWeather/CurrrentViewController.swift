//
//  FirstViewController.swift
//  MyWeather
//
//  Created by Patrick Bean on 5/3/19.
//  Copyright © 2019 TheDevBean. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CurrrentViewController: UIViewController {
    
    let client = DarkSkyAPIClient()
    @IBOutlet weak var warningBox: UIView!
    @IBOutlet weak var warningImage: UIImageView!
    @IBOutlet weak var warningText: UIButton!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var currentIconImage: UIImageView!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var precipProb: UILabel!
    @IBOutlet weak var cloudCover: UILabel!
    @IBOutlet weak var dewPoint: UILabel!
    @IBOutlet weak var windDirection: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var uvIndex: UILabel!
    @IBOutlet weak var visibility: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var gust: UILabel!
    @IBOutlet weak var ozone: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getWeather()
    }

    override func viewDidAppear(_ animated: Bool) {
        refreshWeatherView()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabBar = tabBarController as! WeatherTabBarController
        let receiver = segue.destination as! AlertViewController
        guard let alert = tabBar.weather?.alerts?[0]  else {
            return
        }
        receiver.titleText = alert.title
        receiver.iconImage = tabBar.weather?.getIconImage(for: alert.severity)
        receiver.descriptionText = alert.description
        receiver.startTime = Date(timeIntervalSince1970: alert.time)
        receiver.endTime = Date(timeIntervalSince1970: alert.expires)
        receiver.url = alert.uri
    }

    func refreshWeatherView() {
        
        let tabBar = tabBarController as! WeatherTabBarController
        let windDirectionValue = ""
        
        summary.text = tabBar.weather?.currently.summary
        currentTemp.text = "\(Int(round(tabBar.weather?.currently.temperature ?? 0)))°"
        feelsLike.text = "\(Int(round(tabBar.weather?.currently.apparentTemperature ?? 0)))°"
        lowTemp.text = "\(Int(round(tabBar.weather?.daily.data[0].temperatureLow ?? 0)))°"
        highTemp.text = "\(Int(round(tabBar.weather?.daily.data[0].temperatureHigh ?? 0)))°"
        precipProb.text = "\(Int(round(tabBar.weather?.currently.precipProbability ?? 0)*100))%"
        cloudCover.text = "\(Int(round(tabBar.weather?.currently.cloudCover ?? 0)*100))%"
        dewPoint.text = "\(Int(round(tabBar.weather?.currently.dewPoint ?? 0)))°"
        windSpeed.text = "\(Int(round(tabBar.weather?.currently.windSpeed ?? 0))) mph"
        uvIndex.text = "\(tabBar.weather?.currently.uvIndex ?? 0)"
        visibility.text = "\(tabBar.weather?.currently.visibility ?? 0) mi."
        pressure.text = "\(Int(round(tabBar.weather?.currently.pressure ?? 0))) MB"
        gust.text = "\(Int(round(tabBar.weather?.currently.windGust ?? 0))) mph"
        ozone.text = "\(Int(round(tabBar.weather?.currently.ozone ?? 0))) DU"
        windDirection.text = "\(windDirectionValue)"
        currentIconImage.image = tabBar.weather?.getIconImage(for: tabBar.weather?.currently.icon ?? "default")
        updateLocationLabel()
        
        if let alert = tabBar.weather?.alerts?[0] {
            warningBox.isHidden = false
            warningImage.image = tabBar.weather?.getIconImage(for: alert.severity)
            warningText.setTitle(alert.title, for: .normal)
        } else {
            warningBox.isHidden = true
        }
    }
    
    func getWeather() {
        let tabBar = tabBarController as! WeatherTabBarController
        guard let coordinate = tabBar.locationManager.location?.coordinate else {
            //TODO: Add Error Handeling
            return
        }
        client.getCurrentWeather(at: coordinate) { [unowned self] weather, error in
            if let weather = weather {
                tabBar.weather = weather
                self.refreshWeatherView()
            }
        }
    }
    
    func updateLocationLabel() {
        let tabBar = tabBarController as! WeatherTabBarController
        if let tabbarLocationLabel = tabBar.locationLabel {
            self.navigationItem.title = tabBar.locationLabel
        } else {
            let geoCoder = CLGeocoder()
            guard let location = tabBar.locationManager.location  else {
            //TODO: NIL Case
                return
            }
            geoCoder.reverseGeocodeLocation(location) { [weak self] (placemark, error) in
                guard let self = self else { return }
            
                if let _ = error {
                    //TODO: error
                    return
                }
            
                guard let placemark = placemark?.first else {
                    //TODO: error
                    return
                }
            
                let city = placemark.locality ?? ""
                let state = placemark.administrativeArea ?? ""
                tabBar.locationLabel =  "\(city), \(state)"
            
                DispatchQueue.main.async {
                    self.navigationItem.title = tabBar.locationLabel
                }
            
            }
        }
    }
}

