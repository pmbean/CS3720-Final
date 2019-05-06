//
//  DailyViewController.swift
//  MyWeather
//
//  Created by Patrick Bean on 5/3/19.
//  Copyright © 2019 TheDevBean. All rights reserved.
//

import Foundation
import UIKit

class DailyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var dailyWeatherData: [DayWeather]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyWeatherData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tabBar = tabBarController as! WeatherTabBarController
        let day = tabBar.weather?.daily.data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell") as! DailyTableViewCell
        
        let date = Date(timeIntervalSince1970: day!.time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        cell.dayLabel.text = "\(dateFormatter.string(from: date))"
        cell.highTempLabel.text = "High: \(Int(round(day?.temperatureHigh ?? 0)))°"
        cell.lowTempLabel.text = "Low: \(Int(round(day?.temperatureLow ?? 0)))°"
        cell.summaryLabel.text = day?.summary
        cell.imageIcon.image = tabBar.weather?.getIconImage(for: day?.icon ?? "default")
        
        return cell
    }
    
    
    @IBOutlet weak var dailySummary: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tabBar = tabBarController as! WeatherTabBarController
        dailySummary.text = tabBar.weather?.daily.summary
        dailyWeatherData = tabBar.weather?.daily.data
    }
    
    
}

