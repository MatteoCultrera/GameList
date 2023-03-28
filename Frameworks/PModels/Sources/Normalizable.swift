//
//  Normalizable.swift
//  GameList
//
//  Created by Matteo Cultrera on 21/03/23.
//

protocol Normalizable {
    associatedtype AppModel
    func normalize() -> AppModel
}

protocol OptionalNormalizable {
    associatedtype AppModel
    func normalize() -> AppModel?
}
