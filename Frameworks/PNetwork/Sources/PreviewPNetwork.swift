import PResources

extension PNetwork {
	public static let previewValue: PNetwork = Self(
		getImage: { url in
      throw Error.fetchError
		}
	)
}
