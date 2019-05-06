//
//  SecondViewController.swift
//  MyWeather
//
//  Created by Patrick Bean on 5/3/19.
//  Copyright © 2019 TheDevBean. All rights reserved.
//

import UIKit

class HourlyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var hourlySummary: UITextView!
    @IBOutlet weak var tableView: UITableView!
    var hourlyWeatherData: [HourWeather]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hourlyWeatherData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tabBar = tabBarController as! WeatherTabBarController
        let hour = tabBar.weather?.hourly.data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HourCell") as! HourlyTableViewCell
        
        let date = Date(timeIntervalSince1970: hour!.time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        cell.hourLabel.text = "\(dateFormatter.string(from: date))"
        cell.tempratureLabel.text = "High: \(Int(round(hour?.temperature ?? 0)))°"
        cell.summaryLabel.text = hour?.summary
        cell.imageIcon.image = tabBar.weather?.getIconImage(for: hour?.icon ?? "default")
        
        return cell
    }
    
    
    @IBOutlet weak var dailySummary: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tabBar = tabBarController as! WeatherTabBarController
        hourlySummary.text = tabBar.weather?.hourly.summary
        hourlyWeatherData = tabBar.weather?.hourly.data
    }
    
}

