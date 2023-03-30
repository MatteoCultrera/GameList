import Foundation
import PModels
import Dependencies


extension RawgClient: DependencyKey {
	public static let liveValue = Self(
		getList: { request in
			guard let baseUrl = URL(string: "https://rawg.io/api/games") else {
				throw Error.invalidURL
			}
			
			var queryItems = [URLQueryItem]()
			
			let apiKey = URLQueryItem(name: "key", value: ApiEnvironment.apiToken)
			queryItems.append(apiKey)
			
			if let dates = request.dates {
				let datesString = "\(Self.formatDate(from: dates.startDate)),\(Self.formatDate(from: dates.endDate))"
				queryItems.append(URLQueryItem(name: "dates", value: datesString))
			}
			
			let orderingString = URLQueryItem(name: "ordering", value: "-rating")
			queryItems.append(orderingString)
			
			let page = URLQueryItem(name: "page", value: "\(request.page)")
			let limit = URLQueryItem(name: "page_size", value: "\(request.pageSize)")
			queryItems.append(page)
			queryItems.append(limit)
			
			let url = baseUrl.appending(queryItems: queryItems)
			
			let (data, _) = try await URLSession.shared.data(from: url)
			let response = try JSONDecoder().decode(Models.Response.List.self, from: data)
			return response
		}
	)
	
	private static func formatDate(from date: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "YYYY-MM-dd"
		return dateFormatter.string(from: date)
	}
}
