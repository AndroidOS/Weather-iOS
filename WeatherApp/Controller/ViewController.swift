//
//  ViewController.swift
//  WeatherApp
//
//  Created by Manuel Carvalho on 31/12/19.
//  Copyright © 2019 Manuel Carvalho. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var weatherMgr = WeatherManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherMgr.fetchWeather(cityName: "Sydney")
        
    }


}

