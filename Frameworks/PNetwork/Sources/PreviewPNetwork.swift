import PResources

extension PNetwork {
    public static let previewValue: PNetwork = Self(
        getImage: { url in
            return PResourcesAsset.testImage.swiftUIImage
        }
    )
}
