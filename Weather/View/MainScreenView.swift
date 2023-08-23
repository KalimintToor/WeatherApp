//
//  MainScreenView.swift
//  Weaher
//
//  Created by Александр on 7/20/23.
//

import UIKit

class MainScreenView: UIView {
    
    //MARK: - ЕЛЕМЕНТЫ ТАБЛА ПОГОДЫ
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "cloud.fill")?.withTintColor(UIColor().hexStringToUIColor(hex: infoColor), renderingMode: .alwaysOriginal))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Afternoon"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Afternoon-1")?.withConfiguration(UIImage.SymbolConfiguration(scale: .large))
        
        if traitCollection.userInterfaceStyle == .dark {
            imageView.image = UIImage(named: "Night")?.withConfiguration(UIImage.SymbolConfiguration(scale: .large))
        }
        return imageView
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 70, weight: .black)
        label.textColor = UIColor().hexStringToUIColor(hex: infoColor)
        label.text = "0"
        return label
    }()
    
    private lazy var degreeLabel: UILabel = {
        let label = UILabel()
        label.text = "°C"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 70)
        label.textColor = UIColor().hexStringToUIColor(hex: infoColor)
        return label
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.text = "Feels like"
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor().hexStringToUIColor(hex: infoColor)
        return label
    }()
    
    private lazy var feelsLikeTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor().hexStringToUIColor(hex: infoColor)
        label.text = "0"
        return label
    }()
    
    private lazy var weatherStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    
    private lazy var horizontalStackView2: UIStackView = {
        let view = UIStackView()
        view.spacing = 10
        view.axis = .horizontal
        return view
    }()
    
    //MARK: - КНОПКА ПОИСКА ГОРОДА
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass.circle.fill")?.withTintColor(UIColor().hexStringToUIColor(hex: infoColor), renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self,
                               action: #selector(searchCityName),
                               for: .touchUpInside)
        return button
    }()
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        let userDefaults = UserDefaults.standard
        
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.textColor = UIColor().hexStringToUIColor(hex: infoColor)
        return label
    }()
    
    
    
    private var action: () -> ()
    init(action: @escaping () -> ()) {
        self.action = action
        super.init(frame: .zero)
        
        noSignal()
        addSubviews()
        configureConstraints()
        frame = self.frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //ПРИ ОТСУТСВИИ ИНТЕРНЕТА БУДУТ ПЕРЕДАВАТЬСЯ ДАННЫЕ ИЗ USERDEFAULTS
    
    func noSignal() {
        let userDefaults = UserDefaults.standard
        
        if let weatherData = userDefaults.dictionary(forKey: "currentWeatherData") {
            cityNameLabel.text = (weatherData["cityName"] as? String)?.uppercased()
            
            if let conditionCode = weatherData["conditionCode"] as? Int,
               let cityName = weatherData["cityName"] as? String,
               let temperature = weatherData["temperature"] as? Double,
               let feelsLikeTemperature = weatherData["feelsLikeTemperature"] as? Double{
                let currentWeather = CurrentWeather(cityName: cityName, conditionCode: conditionCode, temperature: temperature, feelsLikeTemperature: feelsLikeTemperature)
                let iconName = currentWeather.systemIconNameString
                imageView.image = UIImage(systemName: iconName)?.withTintColor(UIColor().hexStringToUIColor(hex: infoColor), renderingMode: .alwaysOriginal)
                feelsLikeTempLabel.text = currentWeather.feelsLikeTemperatureString
                tempLabel.text = currentWeather.temperatureString
                cityNameLabel.text = cityName
            }
        }
    }
    
    func set(temp: String, feelsLikeTemp: String, cityName: String?, image: UIImage?){
        tempLabel.text = temp
        feelsLikeTempLabel.text = feelsLikeTemp
        cityNameLabel.text = cityName
        imageView.image = image
    }
}

private extension MainScreenView {
    func addSubviews(){
        self.addSubview(backgroundImageView)
        self.addSubview(weatherStackView)
        self.addSubview(searchButton)
        self.addSubview(cityNameLabel)
        
        weatherStackView.addArrangedSubview(imageView)
        weatherStackView.addArrangedSubview(horizontalStackView)
        weatherStackView.addArrangedSubview(horizontalStackView2)
        
        horizontalStackView.addArrangedSubview(tempLabel)
        horizontalStackView.addArrangedSubview(degreeLabel)
        
        horizontalStackView2.addArrangedSubview(feelsLikeLabel)
        horizontalStackView2.addArrangedSubview(feelsLikeTempLabel)
        
    }
    
    func configureConstraints(){
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        degreeLabel.translatesAutoresizingMaskIntoConstraints = false
        feelsLikeLabel.translatesAutoresizingMaskIntoConstraints = false
        feelsLikeTempLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView2.translatesAutoresizingMaskIntoConstraints = false
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            searchButton.widthAnchor.constraint(equalToConstant: 50),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            searchButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            
            cityNameLabel.widthAnchor.constraint(equalToConstant: 220),
            cityNameLabel.heightAnchor.constraint(equalToConstant: 50),
            cityNameLabel.topAnchor.constraint(equalTo: searchButton.topAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 170),
            imageView.heightAnchor.constraint(equalToConstant: 170),
            
            weatherStackView.topAnchor.constraint(equalTo: cityNameLabel.topAnchor, constant: 70),
            weatherStackView.leadingAnchor.constraint(equalTo: cityNameLabel.leadingAnchor)
        ])
    }
    
    @objc func searchCityName(){
        action()
    }
}
