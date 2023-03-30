import ComposableArchitecture
import PModels
import PResources
import SwiftUI

struct GameItemView: View {
	let store: StoreOf<GameItem>
	
	var body: some View {
		WithViewStore(self.store, observe: { $0 }) { viewStore in
			VStack(spacing: 15) {
				Spacer()
					.frame(maxWidth: .infinity)
					.frame(height: 200)
					.background {
						gameImage(image: viewStore.gameImage)
							.animation(.default, value: viewStore.gameImage)
							.transition(.opacity)
					}
					.mask(RoundedRectangle(cornerRadius: 20))
				let images = getPlatformImages(platforms: viewStore.game.platforms)
				titleHeader(
					name: viewStore.game.name,
					genres: getGenresString(genres: viewStore.game.genres),
					platforms: images.images,
					residual: images.residual
				)
			}
			.padding()
			.background {
				gameImage(image: viewStore.gameImage)
					.overlay(.thinMaterial)
			}
			.clipped()
			.cornerRadius(20)
			.onAppear {
				viewStore.send(.cardAppeared)
			}
		}
	}
	
	@ViewBuilder
	private func titleHeader(
		name: String,
		genres: String,
		platforms: [ImageAsset],
		residual: Int
	) -> some View {
		VStack(spacing: 5) {
			Text(name)
				.foregroundColor(.primary)
				.font(.title2.bold())
				.frame(maxWidth: .infinity, alignment: .leading)
			Text(genres)
				.foregroundColor(.secondary)
				.font(.footnote)
				.frame(maxWidth: .infinity, alignment: .leading)
			
			Spacer()
				.frame(height: 5)
			
			HStack(spacing: 15) {
				ForEach(platforms, id: \.name) { platform in
					platform
						.image
						.renderingMode(.template)
						.resizable()
						.frame(width: 15, height: 15)
				}
				
				if residual > 0 {
					Text("+ \(residual)")
				}
			}
			.frame(maxWidth: .infinity, alignment: .leading)
		}
	}
	
	@ViewBuilder
	private func gameImage(image: Image?) -> some View {
		if let image {
			image
				.resizable()
				.scaledToFill()
		} else {
			VStack{
				
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(Color.red)
		}
	}
	
	private struct ImageAsset {
		let image: Image
		let name: String
	}
}

// MARK: - Helper Functions

private extension GameItemView {
	
	private func getGenresString(genres: [Models.App.Genre]) -> String {
		genres.map { $0.prettyString() }.joined(separator: " • ")
	}
	
	private func getPlatformImages(platforms: [Models.App.Platform]) -> (images: [ImageAsset], residual: Int) {
		var distinctImages = Dictionary<String, (image: Image, sortValue: Int)>()
		platforms.forEach { platform in
			distinctImages[platform.imageAsset.name] = (image: platform.imageAsset.swiftUIImage, sortValue: platform.sortValue())
		}
		
		let assets = distinctImages.enumerated().sorted(by: { $0.element.value.sortValue < $1.element.value.sortValue})
			.map {
				ImageAsset(image: $0.element.value.image, name: $0.element.key)
			}
		
		let firstElements: [ImageAsset]
		if assets.count > 4 {
			firstElements = Array(assets[0...3])
		} else {
			firstElements = assets
		}
		
		return (firstElements, assets.count - firstElements.count)
	}
}

struct GameItemView_Previews: PreviewProvider {
	static var previews: some View {
		GameItemView(
			store: Store(
				initialState: GameItem.State(
					id: 1,
					game: Models.App.Game(
						name: "Sekiro",
						genres: [.MMO, .action],
						platforms: [
							.pc,
							.playstation5,
							.xboxSeriesX,
							.xbox360,
							.xbox,
							.nintendo64,
							.atari8bit
						]
					)),
				reducer: GameItem()
			)
		)
	}
}
