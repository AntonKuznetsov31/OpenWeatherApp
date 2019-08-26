//
//  MainViewController.swift
//  OpenWeatherApp
//
//  Created by Anton Kuznetsov on 8/24/19.
//  Copyright © 2019 AntonKuznetsov. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: - IBOutlets

    @IBOutlet var city: UILabel!
    @IBOutlet var temperature: UILabel!
    @IBOutlet var icon: UIImageView!
    @IBOutlet var weatherDescription: UILabel!
    @IBOutlet var pressure: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var sunrise: UILabel!
    @IBOutlet var sunset: UILabel!
    
    // MARK: - Private Properties
    
    private let locationManager = CLLocationManager()
    private var currentLocation = Location(longitude: 0, latitude: 0)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        updateUIWithWeatherForCity(location: currentLocation)
    }
    
    // MARK: - Private Methods
    
    private func updateUIWithWeatherForCity(location: Location) {
        NetworkManager.fetchWeatherForLocation(currentLocation, completion: { (weather) in
            
            guard let main = weather.main,
                let sys = weather.sys,
                let currentWeather = weather.weather else { return }
            
            guard let city = weather.name,
                let temperature = main.temp,
                let iconVal = currentWeather[0].icon,
                let description = currentWeather[0].description,
                let pressure = main.pressure,
                let humidity = main.humidity,
                let sunRise = sys.sunrise,
                let sunSet = sys.sunset else {return}

            DispatchQueue.main.async {
                self.icon.image = WeatherIcon(rawValue: iconVal).image
                self.temperature.text = String(temperature)
                self.weatherDescription.text = description
                self.humidity.text = String(humidity)
                self.pressure.text = String(pressure)
                self.sunrise.text = String(sunRise)
                self.sunset.text = String(sunSet)
                self.city.text = "\(city)"
            }
        })
    }

    // MARK: - Location manager delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        currentLocation.latitude = locValue.latitude
        currentLocation.longitude = locValue.longitude
    }
}
