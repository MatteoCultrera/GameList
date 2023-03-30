import SwiftUI
import UIKit

extension PNetwork {
	public static let liveValue = Self(
		getImage: { url in
			guard let url else {
				throw Error.invalidURL
			}
			
			let (imageData, _) = try await URLSession.shared.data(for: URLRequest(url: url))
			guard let image = UIImage(data: imageData) else {
				throw Error.fetchError
			}
			
			return Image(uiImage: image)
		}
	)
}
