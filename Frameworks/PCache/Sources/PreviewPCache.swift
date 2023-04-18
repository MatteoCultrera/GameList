import SwiftUI
import PResources

struct PreviewImageCache: PImageCache {
	func get(key: URL) -> Image? {
		return nil
	}
	
	func set(value: Image?, for key: URL) { }
}
