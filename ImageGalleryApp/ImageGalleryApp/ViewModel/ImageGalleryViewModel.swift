import SwiftUI

class ImageGalleryViewModel: ObservableObject {
    @Published var images: [ImageModel] = []

    var existingURLs = Set<String>()  // Store unique image URLs

    func fetchRandomImages() {
        let dispatchGroup = DispatchGroup()
        var newImages: [ImageModel] = []
        let syncQueue = DispatchQueue(label: "com.example.imageSyncQueue") // Serial queue for synchronization

        for _ in 1...5 {
            dispatchGroup.enter()
            DispatchQueue.global(qos: .userInitiated).async {
                let width = Int(UIScreen.main.bounds.width / 2 - 12)
                let height = Int.random(in: 200...350)
                let uniqueID = UUID().uuidString
                let uniqueURL = "https://picsum.photos/seed/\(uniqueID)/\(width)/\(height)"

                syncQueue.sync {
                    if !self.existingURLs.contains(uniqueURL) {
                        self.existingURLs.insert(uniqueURL)
                        
                        if let url = URL(string: uniqueURL) {
                            let newImage = ImageModel(url: url)
                            newImages.append(newImage)
                        }
                    }
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            self.images.append(contentsOf: newImages)
        }
    }
}

