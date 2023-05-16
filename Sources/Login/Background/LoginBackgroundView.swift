import PResources
import SwiftUI

struct LoginBackgroundView: View {
  @Environment(\.colorScheme) var colorScheme
  
  var body: some View {
    VStack {}
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .overlay(alignment: .topLeading) {
      ZStack(alignment: .topLeading) {
        Text("RAWG")
          .padding(.top, 20)
          .padding(.leading, 16)
          .font(Font(PResourcesFontFamily.HeadlinerNo45.regular.font(size: 130)))
          .foregroundColor(.white)
        
        frontImage
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    .background(alignment: .bottomLeading) {
      backgroundImage
    }
  }
  
  var frontImage: some View {
    Group {
      if colorScheme == .dark {
        PResourcesAsset.loginDark.swiftUIImage
      } else {
        PResourcesAsset.loginLight.swiftUIImage
          .offset(x: -100)
      }
    }
    .padding(.top, 20)
  }
  
  var backgroundImage: some View {
    Group {
      if colorScheme == .dark {
        PResourcesAsset.loginDarkBackground.swiftUIImage
          .resizable()
          .scaledToFill()
          .edgesIgnoringSafeArea(.all)
      } else {
        PResourcesAsset.loginLightBackground.swiftUIImage
          .resizable()
          .scaledToFill()
          .edgesIgnoringSafeArea(.all)
      }
    }
  }
}

struct LoginBackgroundView_Previews: PreviewProvider {
  static var previews: some View {
    LoginBackgroundView()
      .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
    
    LoginBackgroundView()
      .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
    
    
    LoginBackgroundView()
      .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
  }
}
