import Foundation
import PModels
import Dependencies


extension RawgClient: DependencyKey {
    public static let liveValue = Self(
        getList: { request in
            guard let baseUrl = URL(string: "https://rawg.io/api/games") else {
                throw Error.invalidURL
            }
            
            let apiKey = URLQueryItem(name: "key", value: "d38c2292730847f1be0a763017a96f8f")
            
            let startDate = Date(timeIntervalSince1970: 1_546_300_800)
            let endDate = Date()
            
            let datesString = "\(Self.formatDate(from: startDate)),\(Self.formatDate(from: endDate))"
            let date = URLQueryItem(name: "dates", value: datesString)
            
            let orderingString = URLQueryItem(name: "ordering", value: "-metacritic")
            
            let page = URLQueryItem(name: "page", value: "\(request.page)")
            let limit = URLQueryItem(name: "page_size", value: "\(request.pageSize)")
            
            let url = baseUrl.appending(queryItems: [
                apiKey,
                page,
                limit,
                date,
                orderingString
            ])
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(Models.Response.List.Response.self, from: data)
            return response
        }
    )
    
    private static func formatDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: date)
    }
}
