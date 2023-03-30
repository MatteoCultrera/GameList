import Dependencies
import Foundation
import SwiftUI
import XCTestDynamicOverlay

public protocol PImageCache {
	func get(key: URL) -> Image?
	func set(value: Image?, for key: URL)
}

public extension PImageCache {
	/// Offers write and read access to the cache.
	subscript(key: URL) -> Image? {
		get {
			get(key: key)
		}
		nonmutating set {
			set(value: newValue, for: key)
		}
	}
}

private enum PImageCacheKey: DependencyKey {
	static let liveValue: any PImageCache = LiveImageCache()
	static let previewValue: any PImageCache = PreviewImageCache()
}

extension DependencyValues {
	public var imageCache: any PImageCache {
		get { self[PImageCacheKey.self] }
		set { self[PImageCacheKey.self] = newValue }
	}
}
