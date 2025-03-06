//
//  HeroRandomizer.swift
//  MHAheroRandomizer
//
//  Created by Дина Абитова on 06.03.2025.
//

import SwiftUI

struct HeroRandomizer: View {
    @State private var heroes: [Hero] = []
    @State private var selectedHero: Hero?

    var body: some View {
        VStack {
            if let hero = selectedHero {
                HeroView(hero: hero)
            } else {
                Text("Hellooo, press the button to generate your random hero")
                    .padding()
                    .multilineTextAlignment(TextAlignment.center)
                    .font(.headline)
            }

            Button("push for random hero") {
                if let randomHero = heroes.randomElement() {
                    selectedHero = randomHero
                }
            }
            .padding()
            .background(Color.mint.opacity(0.6))
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .onAppear { // запускает логику API шкии
            Fetching.fetchHeroes { fetchedHeroes in //import fetchHeroes from Fetching
                if let fetchedHeroes = fetchedHeroes {
                    heroes = fetchedHeroes
                }
            }
        }
    }
}
