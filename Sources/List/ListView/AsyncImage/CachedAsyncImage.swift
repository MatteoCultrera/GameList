import SwiftUI
import ComposableArchitecture
import PCache

/// A  simple Async Image with a cache mechanism to avoid multiple loading for the same url.
/// This first quick implementation is based internally on an Async Image, in the next step we should implement the image download.
/// Available only for `iOS 15` or superior.
@available(iOS 15.0, *)
public struct CachedAsyncImage<Content: View>: View {
  
  // MARK: - Stored Properties
  
  /// The view model of the cached async image.
  private let viewModel: CachedAsyncImageViewModel
  
  /// The content of the cached async image.
  private let content: (AsyncImagePhase) -> Content
  
  // MARK: - Init
  
  /// Creates a cached async image.
  /// - Parameters:
  ///   - url: The `URL` to download the image.
  ///   - scale: A scaling factor to scale the image.
  ///   - transaction: An animation performed when the image state changes.
  ///   - viewodel: The view model of the cached async image.
  public init(
    url: URL?,
    scale: CGFloat = 1.0,
    transaction: Transaction = Transaction(),
    @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
  ) {
    self.viewModel = CachedAsyncImageViewModel(url: url, scale: scale, transaction: transaction)
    self.content = content
  }
  
  public var body: some View {
    if let phase = viewModel.phase() {
      content(phase)
    } else {
      AsyncImage(
        url: viewModel.url,
        scale: viewModel.scale,
        transaction: viewModel.transaction
      ) { phase in
        cacheAndRender(phase: phase)
      }
    }
  }
  
  /// This function cache the image and render the image.
  /// - Parameter phase: An `AsyncImagePhase` to manage the state of the download.
  /// - Returns: The content with the given phase.
  private func cacheAndRender(phase: AsyncImagePhase) -> some View {
    viewModel.phaseChanged(to: phase)
    return content(phase)
  }
}

