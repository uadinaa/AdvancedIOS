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
                HeroImageView(imageURL: hero.images.lg)

                Text(hero.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 5)

                BiographyView(biography: hero.biography)
                AppearanceView(appearance: hero.appearance)
                WorkView(work: hero.work)
                ConnectionsView(connections: hero.connections)
            }
            .padding()
        }
    }
}


struct HeroImageView: View {
    let imageURL: String

    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 300, height: 300)
        .cornerRadius(10)
        .shadow(radius: 5)
        .clipShape(Circle())
    }
}

struct BiographyView: View {
    let biography: Biography

    var body: some View {
        InfoCardView(title: "Biography", content: [
            "Full Name: \(biography.fullName ?? "Unknown")",
            "First Appearance: \(biography.firstAppearance ?? "Unknown")",
            "Place of Birth: \(biography.placeOfBirth ?? "Unknown")",
            "Publisher: \(biography.publisher ?? "Unknown")"
        ], color: Color.blue.opacity(0.1))
    }
}

struct AppearanceView: View {
    let appearance: Appearance

    var body: some View {
        InfoCardView(title: "Appearance", content: [
            "👤 Gender: \(appearance.gender)",
            "🧬 Race: \(appearance.race ?? "Unknown")",
//            "📏 Height: \(appearance.height.last ?? "Unknown")",
//            "⚖️ Weight: \(appearance.weight.last ?? "Unknown")",
            "👁 Eye Color: \(appearance.eyeColor)",
            "💇 Hair Color: \(appearance.hairColor)"
        ], color: Color.green.opacity(0.1))
    }
}

struct WorkView: View {
    let work: Work

    var body: some View {
        InfoCardView(title: "Work", content: [
            "💼 Occupation: \(work.occupation ?? "Unknown")",
            "📍 Base: \(work.base ?? "Unknown")"
        ], color: Color.pink.opacity(0.1))
    }
}

struct ConnectionsView: View {
    let connections: Connections

    var body: some View {
        InfoCardView(title: "Connections", content: [
            "👥 Group Affiliation: \(connections.groupAffiliation ?? "None")",
            "👨‍👩‍👧‍👦 Relatives: \(connections.relatives ?? "Unknown")"
        ], color: Color.orange.opacity(0.1))
    }
}


struct InfoCardView: View {
    let title: String
    let content: [String]
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline)
            ForEach(content, id: \.self) { Text($0) }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color)
        .cornerRadius(10)
    }
}



