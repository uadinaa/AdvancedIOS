//import SwiftUI
//
//struct ContentView: View {
//    @State private var imageUrls: [URL] = []
//    @State private var width: String = ""
//    @State private var height: String = ""
//    @State private var WLabel = "W"
//    @State private var HLabel = "H"
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Form {
//                    Section(header: Text("Enter image size")) {
//                        LabeledContent(WLabel) {
//                            TextField("Width", text: $width)
//                                .keyboardType(.numberPad)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                        }
//                        LabeledContent(HLabel) {
//                            TextField("Height", text: $height)
//                                .keyboardType(.numberPad)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                        }
//                        Button(action: {
//                            fetchRandomImage()
//                        }) {
//                            VStack {
//                                Image(systemName: "photo.stack.fill")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 50, height: 50)
//                                    .foregroundStyle(Color.pink)
//                                Text("Get random photos")
//                                    .foregroundStyle(Color.pink.secondary)
//                            }
//                        }
//                    }
//                }
//                
//                ScrollView {
//                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
//                        ForEach(imageUrls, id: \.self) { imageUrl in
//                            AsyncImage(url: imageUrl) { phase in
//                                switch phase {
//                                case .success(let image):
//                                    image.resizable()
//                                        .scaledToFill()
//                                        .frame(height: 150)
//                                        .clipped()
//                                        .cornerRadius(10)
//                                default:
//                                    ProgressView()
//                                }
//                            }
//                        }
//                    }
//                    .padding()
//                }
//            }
//            .navigationTitle("Image Gallery")
//        }
//    }
//
//    func fetchRandomImage() {
//        guard let width = Int(width) else { return }
//        let heightString = height.trimmingCharacters(in: .whitespaces)
//        let urlString = heightString.isEmpty ? "https://picsum.photos/\(width)" : "https://picsum.photos/\(width)/\(heightString)"
//        if let url = URL(string: urlString) {
//            imageUrls.append(url)
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ImageGalleryViewModel()

    var columns: [GridItem] {
        let itemWidth = UIScreen.main.bounds.width / 2 - 12
        return [
            GridItem(.fixed(itemWidth)),
            GridItem(.fixed(itemWidth))
        ]
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    viewModel.fetchRandomImages()
                }) {
                    VStack {
                        Image(systemName: "photo.stack.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(Color.pink)
                        Text("Get 5 random photos")
                            .foregroundStyle(Color.pink.secondary)
                    }
                }
                .padding()

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 24) {
                        ForEach(viewModel.images) { image in
                            AsyncImage(url: image.url) { phase in
                                switch phase {
                                case .success(let image):
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.main.bounds.width / 2 - 12)
                                        .clipped()
                                        .cornerRadius(10)
                                default:
                                    ProgressView()
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                }
            }
            .background(Color.brown.opacity(0.1))
            .navigationTitle("Image Gallery")
        }
    }
}

#Preview {
    ContentView()
}
