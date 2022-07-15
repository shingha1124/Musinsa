//
//  ImageManager.swift
//  Musinsa
//
//  Created by seongha shin on 2022/07/13.
//

import UIKit

final class ImageManager {
    
    static let shared = ImageManager()
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    func loadImage(url: URL) async -> UIImage? {
        let imageName = url.lastPathComponent
        
        if let cacheImage = self.imageCache.object(forKey: imageName as NSString) {
            return cacheImage
        }

        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return UIImage()
        }

        let destination = cachesDirectory.appendingPathComponent(imageName)
        
        if FileManager.default.fileExists(atPath: destination.path),
           let image = UIImage(contentsOfFile: destination.path) {
            self.imageCache.setObject(image, forKey: imageName as NSString)
            return image
        }
        
        let result = Task { () -> UIImage? in
            guard let (url, _) = try? await URLSession.shared.download(from: url) else {
                return nil
            }
            try? FileManager.default.copyItem(at: url, to: destination)
            guard let image = UIImage(contentsOfFile: destination.path) else {
                return UIImage()
            }
            self.imageCache.setObject(image, forKey: imageName as NSString)
            return image
        }
        
        return await result.value
    }
}
