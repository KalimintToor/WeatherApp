//
//  WeatherView.swift
//  Weaher
//
//  Created by Александр on 7/22/23.
//

import UIKit

class WeatherView: UIView {
    
    private lazy var weatherImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "nosign"))
        image.frame = CGRect(x: 0, y: 0, width: 170, height: 170)
        return image
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "John Doe"
        label.font = .systemFont(ofSize: 70, weight: .black)
        return label
    }()
    private lazy var degreeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "°C"
        label.font = .systemFont(ofSize: 70)
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 8
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension WeatherView {
    func setup(){
        self.backgroundColor = .systemBlue
        self.addSubview(mainStackView)
        mainStackView.addArrangedSubview(weatherImage)
        mainStackView.addArrangedSubview(tempLabel)
    }
    
    func constraints(){
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
