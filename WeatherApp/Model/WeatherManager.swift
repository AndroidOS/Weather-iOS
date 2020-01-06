//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Manuel Carvalho on 31/12/19.
//  Copyright © 2019 Manuel Carvalho. All rights reserved.
//

import Foundation
import CoreLocation

protocol  WeatherManagerDelegate {
    func didUpdateWeather(weatherData: WeatherData)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(ApiKey.key)&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(lattitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(lattitude)&lon=\(longitude)"
              
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        //print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    //let dataString = String(data: safeData, encoding: .utf8)
                    if let weatherData =  self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(weatherData: weatherData)
                    }
                }
            }
            
            
            task.resume()
        }
        
    }
    
    func parseJSON(weatherData: Data) -> WeatherData? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from:weatherData)
                return decodedData
            
        } catch {
            print(error)
            return nil
        }
    }
    
    func getConditionName(weatherId: Int) -> String {
        
        return ""
    }
}
