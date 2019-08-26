//
//  NetworkManager.swift
//  OpenWeatherApp
//
//  Created by Anton Kuznetsov on 8/24/19.
//  Copyright © 2019 AntonKuznetsov. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    static func fetchWeatherForLocation(_ location: Location, completion: @escaping (Weather) -> (Void)) {
        
        let urlString = "api.openweathermap.org/data/2.5/weather?lat=\(location.latitude)&lon=\(location.longitude)&APPID=32ef9ca445e5ec4f81a93660ee90ac8a"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let json = try JSONDecoder().decode(Weather.self, from: data)
                completion(json)
            } catch DecodingError.dataCorrupted(let context) {
                print(context)
            } catch DecodingError.keyNotFound(let key, let context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.valueNotFound(let value, let context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.typeMismatch(let type, let context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }.resume()
    }
    
}
