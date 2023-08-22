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
        let imageView = UIImageView(image: UIImage(systemName: "cloud.fill")?.withTintColor(UIColor().hexStringToUIColor(hex: "F3FFAB"), renderingMode: .alwaysOriginal))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Afternoon"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Afternoon-1")?.withConfiguration(UIImage.SymbolConfiguration(scale: .large)) // Загружаем общее изображение по умолчанию
        
        if traitCollection.userInterfaceStyle == .dark { // Проверяем текущую тему
            imageView.image = UIImage(named: "Night")?.withConfiguration(UIImage.SymbolConfiguration(scale: .large)) // Загружаем темное изображение, если темная тема
        }
        return imageView
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 70, weight: .black)
        label.tintColor = UIColor().hexStringToUIColor(hex: "F3FFAB")
        label.text = "23"
        return label
    }()
    
    private lazy var degreeLabel: UILabel = {
        let label = UILabel()
        label.text = "°C"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 70)
        label.tintColor = UIColor().hexStringToUIColor(hex: "F3FFAB")
        return label
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.text = "Feels like"
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.tintColor = UIColor().hexStringToUIColor(hex: "F3FFAB")
        return label
    }()
    
    private lazy var feelsLikeTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.tintColor = UIColor().hexStringToUIColor(hex: "F3FFAB")
        label.text = "21"
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
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass.circle.fill")?.withTintColor(UIColor.systemBlue, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self,
                               action: #selector(searchCityName),
                               for: .touchUpInside)
        return button
    }()
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Tashkent".uppercased()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .medium)
        return label
    }()
    
    private var action: () -> ()
    init(action: @escaping () -> ()) {
        self.action = action
        super.init(frame: .zero)
        
        addSubviews()
        configureConstraints()
        frame = self.frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(temp: String, feelsLikeTemp: String, cityName: String, image: UIImage){
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
