import Dependencies
import SwiftUI
import Foundation
import XCTestDynamicOverlay

public struct PNetwork: Sendable {
    public var getImage: @Sendable (URL?) async throws -> Image
    
    public init(
        getImage: @escaping @Sendable (URL?) async throws -> Image
    ) {
        self.getImage = getImage
    }
}

extension PNetwork: DependencyKey {
    public static let testValue = Self(getImage: unimplemented())
}

extension DependencyValues {
    public var pNetwork: PNetwork {
        get { self[PNetwork.self] }
        set { self[PNetwork.self] = newValue }
    }
}

extension PNetwork {
    public enum Error: Equatable, LocalizedError, Sendable {
        case fetchError
        case invalidURL
        
        public var errorDescription: String? {
            switch self {
            case .fetchError:
                return "Fetch error"
            case .invalidURL:
                return "Invalid URL"
            }
        }
    }
}
