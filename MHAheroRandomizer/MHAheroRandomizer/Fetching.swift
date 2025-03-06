//
//  Fetching.swift
//  MHAheroRandomizer
//
//  Created by Дина Абитова on 06.03.2025.
//

import Foundation
// Функция загрузки данных из API и передаем массив героев в SwiftUI

struct Fetching{
    static func fetchHeroes(completion: @escaping ([Hero]?) -> Void) {
        let urlString = "https://akabab.github.io/superhero-api/api/all.json"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        //Запрашиваем данные с URLSession
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }

            do {
                let heroes = try JSONDecoder().decode([Hero].self, from: data) //Распаковываем JSON через JSONDecoder
                DispatchQueue.main.async {
                    completion(heroes)
                }
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
