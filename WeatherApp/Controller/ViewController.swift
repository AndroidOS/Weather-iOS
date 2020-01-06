//
//  ViewController.swift
//  WeatherApp
//
//  Created by Manuel Carvalho on 31/12/19.
//  Copyright © 2019 Manuel Carvalho. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, WeatherManagerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var txtCity: UITextField!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var conditionsLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var weatherMgr = WeatherManager()
    let locationManager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        txtCity.delegate = self
        weatherMgr.delegate = self
        locationManager.requestLocation()
        //weatherMgr.fetchWeather(cityName: "Sydney")
        
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
                //self.tempLabel.text = "\(temp)"
                self.tempLabel.text = String(format: "%.1f", temp)
                print(temp)
            } else {
                self.tempLabel.text = "Not Available"
            }
            
            if let city = weatherData.name {
                //self.tempLabel.text = "\(temp)"
                self.txtCity.placeholder = city
            } else {
                self.txtCity.text = "Not Available"
            }
            
            
        }
        print(weatherData.name)
    }

    @IBAction func txt_city(_ sender: Any) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtCity.endEditing(true)
         if let city = txtCity.text {
             weatherMgr.fetchWeather(cityName: city)
         }
        txtCity.text = ""
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherMgr.fetchWeather(lattitude: lat, longitude: lon)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

