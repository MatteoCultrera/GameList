import Foundation

extension Models.Response {
    public enum List {}
}

extension Models.Response.List {
    public struct Request: Codable {
        enum CodingKeys: String, CodingKey {
            case page
            case pageSize = "page_size"
            case search
        }
        
        public let page: Int
        public let pageSize: Int
        public let search: String
        
        public init(page: Int, pageSize: Int, search: String) {
            self.page = page
            self.pageSize = pageSize
            self.search = search
        }
    }
    
    public struct Response: Codable, Equatable {
        public let count: Int
        public let next: URL?
        public let previous: URL?
        public let results: [Models.Response.Game]
    }
}
