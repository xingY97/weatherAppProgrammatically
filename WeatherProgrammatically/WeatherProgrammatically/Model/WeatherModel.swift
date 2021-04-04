//
//  WeatherModel.swift
//  WeatherProgrammatically
//
//  Created by X Y on 4/3/21.
//

import Foundation
import UIKit

//day name, weather icon, description, city
struct Weather: Codable {
    
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Float
}
struct WeatherModel: Codable {
    let weather: [Weather]
    let main: Main
    let name: String?
    let dt: Int
    let dt_txt: String?
}

struct ForecastModel: Codable {
    var list: [WeatherModel]
    let city: City
}

struct City: Codable {
    let name: String?
}

