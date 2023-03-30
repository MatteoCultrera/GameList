import SwiftUI
import PCache
import ComposableArchitecture

/// The view model of `CacheAsyncImage`.
struct CachedAsyncImageViewModel {
    
    // MARK: - Stored Properties
    
    /// The url of the image.
    let url: URL?
    
    /// The scaling factor for the image.
    let scale: CGFloat
    
    /// A possible transaction to manage animations during state changes.
    let transaction: Transaction
    
    @Dependency(\.imageCache) var imageCache
    
    // MARK: - Init
    
    /// Creates a `CacheAsyncImageViewModel`.
    /// - Parameters:
    ///   - url: An `URL` to download the image.
    ///   - scale: A scaling factor to scale the image.
    ///   - transaction: An animation on image state changes.
    init(
        url: URL?,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction()
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
    }
    
    /// If present, it returns the cached image.
    /// - Parameter cache: The `NSCache` where the images are stored.
    /// Return the success phase with the image.
    func phase() -> AsyncImagePhase? {
        guard let url else {
            return .failure(NSError())
        }
        
        guard let image = imageCache.get(key: url) else {
            return nil
        }
        
        return AsyncImagePhase.success(image)
    }
    
    /// A function that saves the image to cache.
    /// - Parameters:
    ///   - phase: The `AsyncImagePhase` to know the current state.
    ///   - cache: The `NSCache` where the images are stored.
    func phaseChanged(to phase: AsyncImagePhase) {
        guard case let .success(image) = phase, let url else {
            return
        }
        
        imageCache[url] = image
    }
}

