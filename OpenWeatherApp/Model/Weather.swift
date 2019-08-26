//
//  Weather.swift
//  OpenWeatherApp
//
//  Created by Anton Kuznetsov on 8/24/19.
//  Copyright © 2019 AntonKuznetsov. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    let name: String?
    let main: Main?
    let sys: Sys?
    let weather: [CurrentWeather]?
}

struct Main: Decodable {
    let humidity: Int?
    let pressure: Int?
    let temp: Double?
}

struct Sys: Decodable {
    let sunrise: UInt64?
    let sunset: UInt64?
}

struct CurrentWeather: Decodable {
    let description: String?
    let icon: String?
}
