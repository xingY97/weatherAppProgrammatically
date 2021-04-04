//
//  NetworkingManager.swift
//  WeatherProgrammatically
//
//  Created by X Y on 4/3/21.
//

import Foundation
import UIKit

class NetworkingManager: NetworkingProtocol {
    
    
    let baseUrl = "https://api.openweathermap.org/data/2.5/forecast?"

    
    func fetchCurrentWeather(city: String, completion: @escaping(WeatherModel) -> ()) {
    
//        let cityName = city.replacingOccurrences(of: " ", with: "+")
//        let API_URL = "\(baseUrl)&q=\(cityName)&appid=9658f91424a20230f084ae61132c2327"
//        //Create a URL
//
//        //let API_URL = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appied=\(API_Key)"
//        guard let url = URL(string: API_URL) else {
//            fatalError()
//        }
//        //Check for errors
//        let urlRequest = URLRequest(url: url)
//        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            guard let data = data else { return }
//            do {
//                let currentWeather = try JSONDecoder().decode(WeatherModel.self, from: data)
//                completion(currentWeather)
//                print(completion)
//            } catch {
//                print("Couldn't Fetch data")
//
//            }
//        }.resume()
        
        let formattedCity = city.replacingOccurrences(of: " ", with: "+")
        let API_URL = "http://api.openweathermap.org/data/2.5/weather?q=\(formattedCity)&appid=\(APIKey.API_Key)"
        
        guard let url = URL(string: API_URL) else {
                 fatalError()
             }
             let urlRequest = URLRequest(url: url)
             URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                 guard let data = data else { return }
                 do {
                     let currentWeather = try JSONDecoder().decode(WeatherModel.self, from: data)
                    completion(currentWeather)
                 } catch {
                     print(error)
                 }
                     
        }.resume()
        
        
    }
    
//    func fetchNextFiveWeatherForecast(city: String, completion: @escaping ([ForecastTemperature]) -> ()) {
//        let city
//    }
}
