//
//  ExtensionOnImage.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 4/21/22.
//

import Foundation
import SwiftUI

extension Image {
  /// Resize an image with fill aspect ratio and specified frame dimensions.
  ///   - parameters:
  ///     - width: Frame width.
  ///     - height: Frame height.
  func resizedToFill(width: CGFloat, height: CGFloat) -> some View {
    self
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: width, height: height)
  }
}
