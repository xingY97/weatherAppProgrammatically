//
//  IncrementExtension.swift
//  WeatherProgrammatically
//
//  Created by X Y on 4/4/21.
//

import Foundation
import UIKit

extension Int {
    func incrementWeekDays(by num : Int) -> Int {
        
        let incrementedVal = self + num
        let mod = incrementedVal & 7
        
        return mod
    }
}
