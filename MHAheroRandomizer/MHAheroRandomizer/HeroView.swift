//
//  HeroView.swift
//  MHAheroRandomizer
//
//  Created by Дина Абитова on 06.03.2025.
//

import SwiftUI

struct HeroView: View {
    let hero: Hero

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                // Изображение героя
                AsyncImage(url: URL(string: hero.images.lg)) { image in
                    image
                        .resizable()
                        .frame(width: 300, height: 300)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .clipShape(Circle())
                                                          
                } placeholder: {
                    ProgressView()
                }

                // Имя героя
                Text(hero.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 5)

                // Биография
                VStack(alignment: .leading, spacing: 5) {
                    Text("Full Name: \(hero.biography.fullName ?? "Unknown")")
                        .font(.headline)

                    Text("First Appearance: \(hero.biography.firstAppearance ?? "Unknown")")
                        .font(.headline)
                    
                    Text("Alter Egos: \(hero.biography.alterEgos ?? "Unknown")")
                        .font(.headline)
                    
                    Text("Place of Birth: \(hero.biography.placeOfBirth ?? "Unknown")")
                        .font(.headline)

                    Text("Publisher: \(hero.biography.publisher ?? "Unknown")")
                        .font(.headline)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
                
                HStack {
                    // Силовые характеристики
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Powerstats:")
                            .font(.headline)

                        Text("💪 Strength: \(hero.powerstats.strength)")
                        Text("⚡ Speed: \(hero.powerstats.speed)")
                        Text("🧠 Intelligence: \(hero.powerstats.intelligence)")
                        Text("🔋 Durability: \(hero.powerstats.durability)")
                        Text("🔥 Power: \(hero.powerstats.power)")
                        Text("🥊 Combat: \(hero.powerstats.combat)")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.purple.opacity(0.1))
                    .cornerRadius(10)

                    // Внешность
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Appearance:")
                            .font(.headline)

                        Text("👤 Gender: \(hero.appearance.gender)")
                        Text("🧬 Race: \(hero.appearance.race ?? "Unknown")")
                        Text("📏 Height: \(hero.appearance.height[1])") // 203 cm
                        Text("⚖️ Weight: \(hero.appearance.weight[1])") // 441 kg
                        Text("👁 Eye Color: \(hero.appearance.eyeColor)")
                        Text("💇 Hair Color: \(hero.appearance.hairColor)")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                
                // Работа
                VStack(alignment: .leading, spacing: 5) {
                    Text("Work:")
                        .font(.headline)

                    Text("💼 Occupation: \(hero.work.occupation ?? "Unknown")")
                    Text("📍 Base: \(hero.work.base ?? "Unknown")")
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.pink.opacity(0.1))
                .cornerRadius(10)
                
                //Семья
                VStack(alignment: .leading, spacing: 5) {
                    Text("Connections:")
                        .font(.headline)

                    Text("👥 Group Affiliation: \(hero.connections.groupAffiliation ?? "None")")
                    Text("👨‍👩‍👧‍👦 Relatives: \(hero.connections.relatives ?? "Unknown")")
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.orange .opacity(0.1))
                .cornerRadius(10)
                
                
            }
            .padding()
        }
    }
}



