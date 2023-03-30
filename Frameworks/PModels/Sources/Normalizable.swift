protocol Normalizable {
	associatedtype AppModel
	func normalize() -> AppModel
}

protocol OptionalNormalizable {
	associatedtype AppModel
	func normalize() -> AppModel?
}
