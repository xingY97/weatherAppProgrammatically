//
//  KelvinToCelciusConverter.swift
//  WeatherProgrammatically
//
//  Created by X Y on 4/4/21.
//

import Foundation
import UIKit

extension Float {
    func formula(places : Int)-> Float{
        return Float(floor(pow(10.0, Float(places)) * self)/pow(10.0, Float(places)))
        
    }
    
    func kelvinToCelciusConverter() -> Float {
        let constantVal : Float = 273.15
        let kelValue = self
        let celValue = kelValue - constantVal
        return celValue.formula(places: 1)
    }
}
