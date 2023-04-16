import ComposableArchitecture
import SwiftUI

public struct SliderCore: ReducerProtocol {
	@Dependency(\.uuid) var uuid
	
	public enum Constants {
		static var sliderHeight: CGFloat = 80
		static var borderSize: CGFloat = 1
		static var sliderBottomOffset: CGFloat = 200
		
		static var toggleMinWidth: CGFloat {
			sliderHeight - 2 * borderSize
		}
		
		static var sliderCornerRadius: CGFloat {
			sliderHeight / 2
		}
	}
	
	public enum StateMachine {
		case interactable
		case backToStart
		case loading
		case loaded
	}
	
	public struct State: Equatable {
		public static func == (lhs: SliderCore.State, rhs: SliderCore.State) -> Bool {
			lhs.stateMachine == rhs.stateMachine &&
			lhs.toggleOffset == rhs.toggleOffset &&
			lhs.sliderWidth == rhs.sliderWidth &&
			lhs.sliderSize == rhs.sliderSize &&
			lhs.sliderYOffset == rhs.sliderYOffset
		}
		
		
		var stateMachine: StateMachine = .interactable
		var toggleOffset: CGFloat = 0
		var sliderWidth: CGFloat = 300
		var sliderSize: CGSize = .zero
		var sliderYOffset: CGFloat = 0
		let animation = PResourcesAnimations.sliderArrow
	}
	
	public enum Action: Equatable {
		case updateSliderSize(newSize: CGSize)
		case updateSliderWidth(newWidth: CGFloat)
		case updateStateMachine(newState: StateMachine)
		case updateToggleOffset(newOffset: CGFloat)
		case updateAnimationComplete
		case updateSliderYOffset
		case loadAnimationComplete
	}
	
	public var body: some ReducerProtocol<State, Action> {
		Reduce { state, action in
			switch action {
			case .updateStateMachine(let newState):
				state.stateMachine = newState
				switch newState {
				case .interactable:
					break
				case .backToStart:
					state.toggleOffset = 0
					state.stateMachine = .interactable
				case .loading:
					state.toggleOffset = state.sliderSize.width/2 - Constants.sliderHeight/2
					state.sliderWidth = Constants.sliderHeight
					state.animation.setBool(bool: .download, value: true)
				case .loaded:
					return .task {
						try await Task.sleep(until: .now + .seconds(0.5), clock: .continuous)
						return .updateAnimationComplete
					}
				}
				return .none
			case .updateToggleOffset(let newOffset):
				state.toggleOffset = newOffset
				return .none
			case .updateSliderWidth(let newWidth):
				state.sliderWidth = newWidth
				return .none
			case .updateSliderSize(let newSize):
				state.sliderSize = newSize
				state.sliderWidth = newSize.width
				return .none
			case .updateAnimationComplete:
				state.animation.trigger(trigger: .downloaded)
				return .task {
					try await Task.sleep(until: .now + .seconds(2), clock: .continuous)
					 return .updateSliderYOffset
				 }
			case .updateSliderYOffset:
				state.sliderYOffset = Constants.sliderBottomOffset
				return .task {
					try await Task.sleep(until: .now + .seconds(1), clock: .continuous)
					 return .loadAnimationComplete
				 }
			case .loadAnimationComplete:
				return .none
			}
		}
	}
}
