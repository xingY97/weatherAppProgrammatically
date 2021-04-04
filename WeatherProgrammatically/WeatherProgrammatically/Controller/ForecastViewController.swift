//
//  ForecastViewController.swift
//  WeatherProgrammatically
//
//  Created by X Y on 4/4/21.
//

import Foundation
import UIKit

class ForecastViewController : UIViewController {
    
    let networkManager = NetworkingManager()
    var collectionView : UICollectionView!
    var forecastData: [ForecastTemperature] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.title = "Weather for next five days"
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.register(ForecastCell.self, forCellWithReuseIdentifier: ForecastCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground

        view.addSubview(collectionView)
        setupViews()
        let city = UserDefaults.standard.string(forKey: "SelectedCity") ?? ""
        print("City Forecast:", city)
        networkManager.fetchNextFiveWeatherForecast(city: city) { (forecast) in
            self.forecastData = forecast
            print("Total Count:", forecast.count)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        forecastData = []
    }
    func setupViews(){
        
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            self.createFeaturedSection()
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        layout.configuration = config
        return layout
    }
    
    func createFeaturedSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))

       let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
       layoutItem.contentInsets = NSDirectionalEdgeInsets(top:5, leading: 5, bottom: 0, trailing: 5)

       let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(110))
       let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])

       let layoutSection = NSCollectionLayoutSection(group: layoutGroup)

       return layoutSection
}

}


