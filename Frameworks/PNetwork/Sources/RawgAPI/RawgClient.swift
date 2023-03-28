import Dependencies
import Foundation
import PModels
import XCTestDynamicOverlay

public struct RawgClient: Sendable {
    public var getList: @Sendable (Models.Request.List) async throws -> Models.Response.List
    
    public init(
        getList: @escaping @Sendable (Models.Request.List) async throws -> Models.Response.List) {
            self.getList = getList
        }
}

extension RawgClient: TestDependencyKey {
    public static let testValue = Self(
        getList: unimplemented()
    )
}

extension DependencyValues {
    public var rawgClient: RawgClient {
        get { self[RawgClient.self] }
        set { self[RawgClient.self] = newValue }
    }
}

extension RawgClient {
    public enum Error: Equatable, LocalizedError, Sendable {
        case invalidURL
        case invalidDate
        
        public var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "Invalid URL"
            case .invalidDate:
                return "Invalid Date"
            }
        }
    }
}
