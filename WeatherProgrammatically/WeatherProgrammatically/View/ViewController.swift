//
//  ViewController.swift
//  WeatherProgrammatically
//
//  Created by X Y on 4/3/21.
//

import UIKit

class ViewController: UIViewController {
    
    let networkManager = NetworkingManager()
    
    let currentLocation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Current Location"
        label.textAlignment = .left
        label.textColor = .label
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        return label
    
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
    }


}

