import PModels
import SwiftUI

extension Models.App.Platform {
    public var imageAsset: PResourcesImages {
        switch self {
        case .pc:
            return PResourcesAsset.windows
        case .playstation5, .playstation4, .playstation3,
                .playstation2, .playstation1, .psVita, .psp:
            return PResourcesAsset.playstation
        case .xboxOne, .xboxSeriesX, .xbox360, .xbox:
            return PResourcesAsset.xbox
        case .nintendoSwitch:
            return PResourcesAsset.swift
        case .ios, .macintosh, .macOS, .appleII:
            return PResourcesAsset.apple
        case .android:
            return PResourcesAsset.android
        case .nintendo3DS, .nintendoDS, .nintendoDSi,
                .wii, .wiiU, .gamecube, .nintendo64,
                .gameBoyAdvance, .gameBoyColor, .gameBoy,
                .gameGear:
            return PResourcesAsset.nintendo
        case .linux:
            return PResourcesAsset.linux
        case .snes, .nes, .segaGenesis, .segaSaturn,
                .segaCD, .sega32x, .segaMaster:
            return PResourcesAsset.sega
        case .commodore:
            return PResourcesAsset.sega
        case .atari7800, .atari5200, .atari2600,
                .atariFlashback, .atari8bit, .atariST,
                .atariLynx, .atariXegs:
            return PResourcesAsset.atari
        case .dreamcast:
            return PResourcesAsset.atari
        case .panasonic3do:
            return PResourcesAsset.atari
        case .jaguar:
            return PResourcesAsset.atari
        case .neoGeo:
            return PResourcesAsset.atari
        }
    }
}
