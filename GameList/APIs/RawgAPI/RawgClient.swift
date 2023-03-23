import Dependencies
import Foundation
import XCTestDynamicOverlay

public struct RawgClient: Sendable {
    public var getList: @Sendable (List.Request) async throws -> List.Response
    
    public init(
        getList: @escaping @Sendable (List.Request) async throws -> List.Response) {
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

      public var errorDescription: String? {
        switch self {
        case .invalidURL:
          return "Invalid URL"
        }
      }
    }
}

extension RawgClient {
    public enum List {
        public struct Request: Codable {
            enum CodingKeys: String, CodingKey {
                case page
                case pageSize = "page_size"
                case search
            }
            
            let page: Int
            let pageSize: Int
            let search: String
        }
        
        public struct Response: Codable, Equatable {
            let count: Int
            let next: URL?
            let previous: URL?
            let results: [Models.Response.Game]
        }
    }
}
