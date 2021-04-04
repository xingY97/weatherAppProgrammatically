//
//  NetworkingProtocol.swift
//  WeatherProgrammatically
//
//  Created by X Y on 4/3/21.
//

import Foundation
import UIKit

protocol NetworkingProtocol {
    func fetchCurrentWeather(city: String, completion: @escaping (WeatherModel) -> ())
    
    func fetchNextFiveWeatherForecast(city: String, completion: @escaping ([ForecastTemperature]) -> ())
}
