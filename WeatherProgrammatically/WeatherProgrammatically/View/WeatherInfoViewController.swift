//
//  ViewController.swift
//  WeatherProgrammatically
//
//  Created by X Y on 4/3/21.
//

import UIKit

class WeatherInfoViewController: UIViewController {
    
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
    
    let currentTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "3 April 2021"
        label.textAlignment = .left
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 10, weight: .heavy)
        return label
    }()
    
    let currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "°C"
        label.textColor = .label
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    
    let tempDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "..."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    let tempSymbol: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "cloud.fill")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = .gray
        return img
    }()
    
    let searchField: UITextField = {
        let searchField = UITextField()
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.placeholder = "Enter a city name"
        searchField.textAlignment = .right
        return searchField
    }()
    
    
    var stackView : UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .done, target: self, action: #selector(handleAddPlaceButton)), UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(handleRefresh))]
        
        setupViews()
        layoutViews()
    }
    
    func loadData(city: String) {
        networkManager.fetchCurrentWeather(city: city) { (weather) in
            print("Current Temperature", weather.main.temp.kelvinToCelciusConverter())
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy" //yyyy
            let stringDate = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.dt)))
            
            DispatchQueue.main.async {
                self.currentTemperatureLabel.text = (String(weather.main.temp.kelvinToCelciusConverter()) + "°C")
                self.currentLocation.text = "\(weather.name ?? "")"
                self.tempDescription.text = weather.weather[0].description
                self.currentTime.text = stringDate

                UserDefaults.standard.set("\(weather.name ?? "")", forKey: "SelectedCity")
            }
        }
    }
    
    func setupViews() {
        view.addSubview(currentLocation)
        view.addSubview(currentTemperatureLabel)
        view.addSubview(tempSymbol)
        view.addSubview(tempDescription)
        view.addSubview(currentTime)
    }
    
    func layoutViews() {
        
        currentLocation.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        currentLocation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18).isActive = true
        currentLocation.heightAnchor.constraint(equalToConstant: 30).isActive = true
        currentLocation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        currentTime.topAnchor.constraint(equalTo: currentLocation.bottomAnchor, constant: 10).isActive = true
        currentTime.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18).isActive = true
        currentTime.heightAnchor.constraint(equalToConstant: 10).isActive = true
        currentTime.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        currentTemperatureLabel.topAnchor.constraint(equalTo: currentTime.bottomAnchor, constant: 10).isActive = true
        currentTemperatureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18).isActive = true
        currentTemperatureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        tempSymbol.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor).isActive = true
        tempSymbol.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18).isActive = true
        tempSymbol.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tempSymbol.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        //        searchField.topAnchor.constraint(equalTo: currentLocation.bottomAnchor, constant: 50).isActive = true
        //        searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1).isActive = true
        //        searchField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        //        searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18).isActive = true
        
        tempDescription.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 12.5).isActive = true
        tempDescription.leadingAnchor.constraint(equalTo: tempSymbol.trailingAnchor, constant: 8).isActive = true
        tempDescription.heightAnchor.constraint(equalToConstant: 20).isActive = true
        tempDescription.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
    }
    
    //MARK: - Handlers
    @objc func handleAddPlaceButton() {
        let alertController = UIAlertController(title: "Add City", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "City Name"
        }
        let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            print("City Name: \(firstTextField.text)")
            guard let cityname = firstTextField.text else { return }
            self.loadData(city: cityname)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action : UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //    @objc func handleShowForecast() {
    //        self.navigationController?.pushViewController(WeatherInfoViewController(), animated: true)
    //    }
    
    @objc func handleRefresh() {
        let city = UserDefaults.standard.string(forKey: "SelectedCity") ?? ""
        loadData(city: city)
    }
    
    
}

