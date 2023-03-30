import SwiftUI

struct LiveImageCache: PImageCache {
    
    internal let nsCache = NSCache<WrappedKey, WrappedValue>()
    
    func get(key: URL) -> Image? {
        nsCache.object(forKey: WrappedKey(key))?.value
    }
    
    func set(value: Image?, for key: URL) {
        if let value {
            nsCache.setObject(WrappedValue(value), forKey: WrappedKey(key))
        } else {
            nsCache.removeObject(forKey: WrappedKey(key))
        }
    }
}

internal extension LiveImageCache {
    /// Wraps the key to allow the use of value types.
    final class WrappedKey: NSObject {
      /// The key to identify the value in the cache.
      let key: URL
      
      override var hash: Int {
        key.hashValue
      }
      
      /// Creates a wrapped key.
      /// - Parameter key: The key that need to be wrapped.
      init(_ key: URL) {
        self.key = key
      }
      
      override func isEqual(_ object: Any?) -> Bool {
        guard let value = object as? WrappedKey else {
          return false
        }
        
        return value.key == key
      }
    }
    
    /// Wraps the value to allow the use of value types.
    final class WrappedValue {
      /// The value that needs to be cached.
      let value: Image
      
      /// Creates a wrapped value.
      /// - Parameter value: The value that need to be wrapped.
      init(_ value: Image) {
        self.value = value
      }
    }
}
