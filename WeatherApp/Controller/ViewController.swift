//
//  ViewController.swift
//  WeatherApp
//
//  Created by Manuel Carvalho on 31/12/19.
//  Copyright © 2019 Manuel Carvalho. All rights reserved.
//

import UIKit


class ViewController: UIViewController, WeatherManagerDelegate {
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var conditionsLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var weatherMgr = WeatherManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherMgr.delegate = self
        weatherMgr.fetchWeather(cityName: "Sydney")
        
    }
    
    func didUpdateWeather(weatherData: WeatherData) {
        
        DispatchQueue.main.async {
            if let conditions = weatherData.weather[0].description{
                self.conditionsLabel.text = conditions
                print(conditions)
            } else {
                self.conditionsLabel.text = "Not Available"
            }
            
            if let temp = weatherData.main?.temp_max {
                self.tempLabel.text = "\(temp)"
                print(temp)
            } else {
                self.tempLabel.text = "Not Available"
            }
            
            
            
        }
        print(weatherData.name)
    }


}

