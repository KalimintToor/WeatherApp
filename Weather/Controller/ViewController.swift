//
//  ViewController.swift
//  Weaher
//
//  Created by Александр on 7/20/23.
//

import UIKit

class ViewController: UIViewController {
    
    var networkWeatherManager = NetworkCurrentWeatherManager()

    private lazy var elementsMainScreenView: MainScreenView = {
        let view = MainScreenView  { [weak self] in
            self?.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert, completionHandler: { [unowned self] city in
                self?.networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: city)) 
            })
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(elementsMainScreenView)
        
        elementsMainScreenView.frame = Constants.screenRect
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else {return}
            self.updateInterfaceWith(weather: currentWeather)
        }
    }
    
    func updateInterfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.elementsMainScreenView.set(temp: weather.temperatureString, feelsLikeTemp: weather.feelsLikeTemperatureString, cityName: weather.cityName, image: (UIImage(systemName: weather.systemIconNameString)!.withTintColor(UIColor.systemBlue,renderingMode: .alwaysOriginal)))
        }
    }
}


