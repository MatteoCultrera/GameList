import SwiftUI
import PResources

struct PreviewImageCache: PImageCache {
	func get(key: URL) -> Image? {
		return PResourcesAsset.testImage.swiftUIImage
	}
	
	func set(value: Image?, for key: URL) { }
}
