import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private let cache = URLCache.shared

    func loadImage(from url: URL) {
        let request = URLRequest(url: url)

        // checking the cache first
        if let cachedResponse = cache.cachedResponse(for: request),
           let cachedImage = UIImage(data: cachedResponse.data) {
            self.image = cachedImage
            return
        }

        // downloading an image if it is not cached
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, let response = response, let image = UIImage(data: data) else { return }
                
                // storing there
                let cachedData = CachedURLResponse(response: response, data: data)
                self.cache.storeCachedResponse(cachedData, for: request)

                DispatchQueue.main.async {
                    self.image = image
                }
            }.resume()
        }
    }
}
