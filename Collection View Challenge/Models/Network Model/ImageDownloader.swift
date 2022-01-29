//
//  ImageDownloader.swift
//  Collection View Challenge
//
//  Created by Dina ElShabassy on 1/29/22.
//  Copyright © 2022 Dina_ElShabassy. All rights reserved.
//

import Foundation
import UIKit

final class ImageDownloader {

    static let shared = ImageDownloader()
    
    private var cachedImages: [String: UIImage]
    private var imagesDownloadTasks: [String: URLSessionDataTask]
    
    // MARK: Private init
    private init() {
        cachedImages = [:]
        imagesDownloadTasks = [:]
    }
    
     /**
    Downloads and returns images through the completion closure to the caller

     - Parameter imageUrlString: The remote URL to download images from
     - Parameter completionHandler: A completion handler which returns two parameters. First one is an image which may or may
     not be cached and second one is a bool to indicate whether we returned the cached version or not
     - Parameter placeholderImage: Placeholder image to display as we're downloading them from the server
     */
     
    // A serial queue to be able to write the non-thread-safe dictionary
    let serialQueueForImages = DispatchQueue(label: "images.queue", attributes: .concurrent)
    let serialQueueForDataTasks = DispatchQueue(label: "dataTasks.queue", attributes: .concurrent)
    	
    
    func downloadImage(with imageUrlString: String?,
                   completionHandler: @escaping (UIImage?, Bool) -> Void,
                   placeholderImage: UIImage?) {

    guard let imageUrlString = imageUrlString else {
        completionHandler(placeholderImage, true)
        return
    }

    if let image = getCachedImageFrom(urlString: imageUrlString) {
        completionHandler(image, true)
    } else {
        guard let url = URL(string: imageUrlString) else {
            completionHandler(placeholderImage, true)
            return
        }

        if let _ = getDataTaskFrom(urlString: imageUrlString) {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let data = data else {
                return
            }

            if let _ = error {
                DispatchQueue.main.async {
                    completionHandler(placeholderImage, true)
                }
                return
            }

            let image = UIImage(data: data)
         
            // Store the downloaded image in cache
            self.serialQueueForImages.sync(flags: .barrier) {
                self.cachedImages[imageUrlString] = image
            }

            // Clear out the finished task from download tasks container
            _ = self.serialQueueForDataTasks.sync(flags: .barrier) {
                self.imagesDownloadTasks.removeValue(forKey: imageUrlString)
            }

            // Always execute completion handler explicitly on main thread
            DispatchQueue.main.async {
                completionHandler(image, false)
            }
        }
        
        // We want to control the access to no-thread-safe dictionary in case it's being accessed by multiple threads at once
        self.serialQueueForDataTasks.sync(flags: .barrier) {
            imagesDownloadTasks[imageUrlString] = task
        }

        task.resume()
    }
    
    }
    private func getCachedImageFrom(urlString: String) -> UIImage? {
        // Reading from the dictionary should happen in the thread-safe manner.
        serialQueueForImages.sync {
            return cachedImages[urlString]
        }
    }

    private func getDataTaskFrom(urlString: String) -> URLSessionTask? {

        // Reading from the dictionary should happen in the thread-safe manner.
        serialQueueForDataTasks.sync {
            return imagesDownloadTasks[urlString]
        }
    }


}
    

