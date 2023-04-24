import Foundation

extension Models.App {
  public enum Platform: String, Comparable, CaseIterable {
    public static func < (lhs: Models.App.Platform, rhs: Models.App.Platform) -> Bool {
      return lhs.sortValue() < rhs.sortValue()
    }
    
    case pc
    case playstation5
    case playstation4
    case xboxOne = "xbox-one"
    case xboxSeriesX = "xbox-series-x"
    case nintendoSwitch = "nintendo-switch"
    case ios
    case android = "android"
    case nintendo3DS = "nintendo-3ds"
    case nintendoDS = "nintendo-ds"
    case nintendoDSi = "nintendo-dsi"
    case macOS = "macos"
    case linux
    case xbox360
    case xbox = "xbox-old"
    case playstation3
    case playstation2
    case playstation1
    case psVita = "ps-vita"
    case psp
    case wiiU = "wii-u"
    case wii
    case gamecube
    case nintendo64 = "nintendo-64"
    case gameBoyAdvance = "game-boy-advance"
    case gameBoyColor = "game-boy-color"
    case gameBoy = "game-boy"
    case snes
    case nes
    case macintosh
    case appleII = "apple-ii"
    case commodore = "commodore-amiga"
    case atari7800 = "atari-7800"
    case atari5200 = "atari-5200"
    case atari2600 = "atari-2600"
    case atariFlashback = "atari-flashback"
    case atari8bit = "atari-8-bit"
    case atariST = "atari-st"
    case atariLynx = "atari-lynx"
    case atariXegs = "atari-xegs"
    case segaGenesis = "genesis"
    case segaSaturn = "sega-saturn"
    case segaCD = "sega-cd"
    case sega32x = "sega-32x"
    case segaMaster = "sega-master-system"
    case dreamcast = "dreamcast"
    case panasonic3do = "3do"
    case jaguar
    case gameGear = "game-gear"
    case neoGeo = "neogeo"
    
    public func prettyString() -> String {
      switch self {
      case .pc:
        return "PC"
      case .playstation5:
        return "PlayStation 5"
      case .playstation4:
        return "PlayStation 4"
      case .xboxOne:
        return "Xbox One"
      case .xboxSeriesX:
        return "Xbox Series S/X"
      case .nintendoSwitch:
        return "Nintendo Switch"
      case .ios:
        return "iOS"
      case .android:
        return "Android"
      case .nintendo3DS:
        return "Nintendo 3DS"
      case .nintendoDS:
        return "Nintendo DS"
      case .nintendoDSi:
        return "Nintendo DSi"
      case .macOS:
        return "MacOS"
      case .linux:
        return "Linux"
      case .xbox360:
        return "Xbox 360"
      case .xbox:
        return "Xbox"
      case .playstation3:
        return "PlayStation 3"
      case .playstation2:
        return "PlayStation 2"
      case .playstation1:
        return "PlayStation 1"
      case .psVita:
        return "PlayStation Vita"
      case .psp:
        return "PSP"
      case .wiiU:
        return "Wii U"
      case .wii:
        return "Wii"
      case .gamecube:
        return "GameCube"
      case .nintendo64:
        return "Nintendo 64"
      case .gameBoyAdvance:
        return "GameBoy Advance"
      case .gameBoyColor:
        return "GameBoy Color"
      case .gameBoy:
        return "GameBoy"
      case .snes:
        return "SNES"
      case .nes:
        return "NES"
      case .macintosh:
        return "Machintosh"
      case .appleII:
        return "Apple II"
      case .commodore:
        return "Commodore"
      case .atari7800:
        return "Atari 7800"
      case .atari5200:
        return "Atari 5200"
      case .atari2600:
        return "Atari 2600"
      case .atariFlashback:
        return "Atari Flashback"
      case .atari8bit:
        return "Atari 8-bit"
      case .atariST:
        return "Atari ST"
      case .atariLynx:
        return "Atari Lynx"
      case .atariXegs:
        return "Atari XEGS"
      case .segaGenesis:
        return "Sega Genesis"
      case .segaSaturn:
        return "Sega Saturn"
      case .segaCD:
        return "Sega CD"
      case .sega32x:
        return "Sega 32x"
      case .segaMaster:
        return "Sega Master"
      case .dreamcast:
        return "Dreamcast"
      case .panasonic3do:
        return "3DO"
      case .jaguar:
        return "Jaguar"
      case .gameGear:
        return "Game Gear"
      case .neoGeo:
        return "Neo Geo"
      }
    }
    
    public func sortValue() -> Int {
      switch self {
      case .pc:
        return 0
      case .xboxOne:
        return 1
      case .xboxSeriesX:
        return 2
      case .xbox360:
        return 3
      case .xbox:
        return 4
      case .playstation5:
        return 5
      case .playstation4:
        return 6
      case .playstation3:
        return 7
      case .playstation2:
        return 8
      case .playstation1:
        return 9
      case .psVita:
        return 10
      case .psp:
        return 11
      case .nintendoSwitch:
        return 12
      case .wiiU:
        return 13
      case .wii:
        return 14
      case .nintendo3DS:
        return 15
      case .nintendoDSi:
        return 16
      case .nintendoDS:
        return 17
      case .gameBoyAdvance:
        return 18
      case .gameBoyColor:
        return 19
      case .gameBoy:
        return 20
      case .nintendo64:
        return 21
      case .gamecube:
        return 22
      case .snes:
        return 23
      case .nes:
        return 24
      case .gameGear:
        return 25
      case .ios:
        return 26
      case .macOS:
        return 27
      case .macintosh:
        return 28
      case .appleII:
        return 29
      case .android:
        return 30
      case .linux:
        return 31
      case .commodore:
        return 32
      case .atari7800:
        return 33
      case .atari5200:
        return 34
      case .atari2600:
        return 35
      case .atariFlashback:
        return 36
      case .atari8bit:
        return 37
      case .atariST:
        return 38
      case .atariLynx:
        return 39
      case .atariXegs:
        return 40
      case .segaGenesis:
        return 41
      case .segaSaturn:
        return 42
      case .segaCD:
        return 43
      case .sega32x:
        return 44
      case .segaMaster:
        return 45
      case .dreamcast:
        return 46
      case .panasonic3do:
        return 47
      case .jaguar:
        return 48
      case .neoGeo:
        return 49
      }
    }
  }
}
