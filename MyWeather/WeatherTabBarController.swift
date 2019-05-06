//
//  TabBarControllerViewController.swift
//  MyWeather
//
//  Created by Patrick Bean on 5/3/19.
//  Copyright © 2019 TheDevBean. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class WeatherTabBarController: UITabBarController {

    let client = DarkSkyAPIClient()
    var locationManager = CLLocationManager()
    var weather: Weather?
    var locationLabel: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            guard let location = locationManager.location?.coordinate else {
                //add error handeling
                return
            }
            
        } else {
            // show something that location is not enabled
        }
    }

}
