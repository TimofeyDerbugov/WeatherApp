//
//  ViewController.swift
//  WeatherApp
//
//  Created by Apple on 10.05.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let tempLabel = UILabel()
    let iconWeather = UIImageView()
    let updateTapButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tempLabel.frame = CGRect(x: (view.frame.size.width / 2 - 100), y: 50, width: 200, height: 200)
        tempLabel.text = "--°"
        tempLabel.font = UIFont.systemFont(ofSize: 40)
        tempLabel.textColor = .red
        tempLabel.textAlignment = .center
        
        iconWeather.frame = CGRect(x: (view.frame.size.width / 2 - 100), y: (view.frame.size.height / 10 * 3), width: 200, height: 200)
        self.iconWeather.image = UIImage(named: "ghk")
        
        updateTapButton.frame = CGRect(x: (view.frame.width / 2 - 150), y: (view.frame.height / 10 * 7), width: 300, height: 50)
        updateTapButton.backgroundColor = .blue
        updateTapButton.setTitle("Update Obninsk Weather", for: .normal)
        updateTapButton.addTarget(self, action: #selector(UPDaTe), for: .touchUpInside)
        updateTapButton.layer.cornerRadius = 20
        
    
        view.addSubview(updateTapButton)
        view.addSubview(iconWeather)
        view.addSubview(tempLabel)
    }
    @objc func UPDaTe() {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=55.10&longitude=33.62&current_weather=true"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data, let weather = try? JSONDecoder().decode(WeatherData.self, from: data) {
                DispatchQueue.main.async {
                    self.tempLabel.text = "\(weather.currentWeather.temperature) °"
                }
            } else {
                print("Fail!")
            }
        }
        task.resume()
    }

}

