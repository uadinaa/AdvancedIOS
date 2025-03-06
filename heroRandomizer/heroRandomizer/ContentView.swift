//
//  ContentView.swift
//  heroRandomizer
//
//  Created by Дина Абитова on 06.03.2025.
//

import SwiftUI

struct ContentView: View {
    let heroName = ["Aizawa Shōta", "Asui Tsuyu", "Bakugō Katsuki", "Kaminari Denki", "Kayama Nemuri", "Kirishima Eijirō", "Keigo Takami (Wing Hero Hawks)", "Midoriya Izuku", "Mina Ashido", "Shouto Todoroki", ]
    let heroPhoto: [String:String] = [
        "Aizawa Shōta": "https://fanfics.me/images/fandoms_heroes/876-1512804669.jpg",
        "Asui Tsuyu": "https://fanfics.me/images/fandoms_heroes/876-1512804667.jpg",
        "Bakugō Katsuki": "https://fanfics.me/images/fandoms_heroes/876-1512804647.jpg",
        "Kaminari Denki": "https://fanfics.me/images/fandoms_heroes/876-1512804650.jpg",
        "Kayama Nemuri": "https://fanfics.me/images/fandoms_heroes/876-1512849984.jpg",
        "Kirishima Eijirō": "https://fanfics.me/images/fandoms_heroes/876-1512804648.jpg",
        "Keigo Takami (Wing Hero Hawks)": "https://fanfics.me/images/fandoms_heroes/876-1665550649.jpg",
        "Midoriya Izuku": "https://fanfics.me/images/fandoms_heroes/876-1512804646.jpg",
        "Mina Ashido": "https://fanfics.me/images/fandoms_heroes/876-1600608244.jpg",
        "Shouto Todoroki": "https://fanfics.me/images/fandoms_heroes/876-1512804660.jpg"]
    
    @State private var selectedHero: String?
    
    @State private var selectedPhoto: (name: String, photo: String)?
    
    var body: some View {
        VStack {
            if let photoUrl = selectedPhoto, let url = URL(string: photoUrl.photo){
                AsyncImage(url: url){
                    image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 400)
                        .cornerRadius(10)
                }
                placeholder:{
                    ProgressView()
                }
                Text(photoUrl.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
            }
            else{
                Text("who is your hero?")
            }
            
            Button("push for your hero"){
                if let randomItem = heroPhoto.randomElement(){
                    selectedPhoto = (name: randomItem.key, photo: randomItem.value)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
