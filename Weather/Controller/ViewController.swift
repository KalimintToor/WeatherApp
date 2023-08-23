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
            self?.networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: city ))
            })
        }
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        elementsMainScreenView.frame = Constants.screenRect
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else {return}
            self.updateInterfaceWith(weather: currentWeather)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(elementsMainScreenView)

        let userDefaults = UserDefaults.standard
        if let cityName = userDefaults.string(forKey: "lastSelectedCity") {
            networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: cityName))
        }
    }

    
    func saveCurrentWeatherToUserDefaults(weather: CurrentWeather) {
        let userDefaults = UserDefaults.standard
    
        let dataToSave: [String: Any] = [
            "cityName": weather.cityName,
            "temperature": weather.temperature ?? 0.0,
            "feelsLikeTemperature": weather.feelsLikeTemperature ?? 0.0,
            "conditionCode": weather.conditionCode,
            "systemIconNameString": weather.systemIconNameString
        ]
        userDefaults.set(dataToSave, forKey: "currentWeatherData")
        userDefaults.synchronize()
    }
    
    func updateInterfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.saveCurrentWeatherToUserDefaults(weather: weather)
            
            self.elementsMainScreenView.set(temp: weather.temperatureString,
                                            feelsLikeTemp: weather.feelsLikeTemperatureString,
                                            cityName: weather.cityName,
                                            image: (UIImage(systemName: weather.systemIconNameString)!.withTintColor(UIColor().hexStringToUIColor(hex: infoColor),renderingMode: .alwaysOriginal)))
        }
    }
}
