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
        
        
        let cityName = city.replacingOccurrences(of: " ", with: "+")
        let API_URL = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(APIKey.API_Key)"
        
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
    
    func fetchNextFiveWeatherForecast(city: String, completion: @escaping ([ForecastTemperature]) -> ()) {
        let cityName = city.replacingOccurrences(of: " ", with: "+")
        let API_URL = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(APIKey.API_Key)"
        
        var currentDayTemp = ForecastTemperature(weekDay: nil)
        var secondDayTemp = ForecastTemperature(weekDay: nil)
        var thirdDayTemp = ForecastTemperature(weekDay: nil)
        var fourthDayTemp = ForecastTemperature(weekDay: nil)
        var fifthDayTemp = ForecastTemperature(weekDay: nil)
        var sixthDayTemp = ForecastTemperature(weekDay: nil)
        
        guard let url = URL(string: API_URL) else {
            fatalError()
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                
                var forecastWeather = try JSONDecoder().decode(ForecastModel.self, from:data)
                
                var forecastmodelArray : [ForecastTemperature] = []
                var fetchedData : [WeatherInfo] = [] //Just for loop completion
                
                var currentDayForecast : [WeatherInfo] = []
                var secondDayForecast : [WeatherInfo] = []
                var thirddayDayForecast : [WeatherInfo] = []
                var fourthDayDayForecast : [WeatherInfo] = []
                var fifthDayForecast : [WeatherInfo] = []
                var sixthDayForecast : [WeatherInfo] = []
                
                var totalData = forecastWeather.list.count
                for day in 0...forecastWeather.list.count - 1 {
                    
                    //day name, weather icon, description, city
                    let listIndex = day
                    let mainTemp = forecastWeather.list[listIndex].main.temp
                    let descriptionTemp = forecastWeather.list[listIndex].weather[0].description
                    let icon = forecastWeather.list[listIndex].weather[0].icon
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.calendar = Calendar(identifier: .gregorian)
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let date = dateFormatter.date(from: forecastWeather.list[listIndex].dt_txt!)
                    let calendar = Calendar.current
                    let components = calendar.dateComponents([.weekday], from: date!)
                    let weekdaycomponent = components.weekday! - 1  //Just the integer value from 0 to 6
                    
                    let f = DateFormatter()
                    let weekday = f.weekdaySymbols[weekdaycomponent] // 0 Sunday 6 - Saturday //This is where we are getting the string val (Mon/Tue/Wed...)
                    
                    let currentDayComponent = calendar.dateComponents([.weekday], from: Date())
                    let currentWeekDay = currentDayComponent.weekday! - 1
                    let currentweekdaysymbol = f.weekdaySymbols[currentWeekDay]
                    
                    if weekdaycomponent == currentWeekDay - 1 {
                        totalData = totalData - 1
                    }
                    
                    if weekdaycomponent == currentWeekDay {
                        let info = WeatherInfo( temp: mainTemp, description: descriptionTemp, icon: icon)
                        currentDayForecast.append(info)
                        currentDayTemp = ForecastTemperature(weekDay: currentweekdaysymbol)
                        fetchedData.append(info)
                    } else if weekdaycomponent == currentWeekDay.incrementWeekDays(by:1) {
                        let info = WeatherInfo(temp: mainTemp, description: descriptionTemp, icon: icon)
                    }
                }
                
                
                
            } catch {
                print(error)
            }
            
        }.resume()
    }
    
}
