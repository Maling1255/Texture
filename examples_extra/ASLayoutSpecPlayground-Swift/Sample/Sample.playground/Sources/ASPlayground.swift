//
//  ASPlayground.swift
//  Texture
//
//  Copyright (c) 2017-present, Pinterest, Inc.  All rights reserved.
//  Licensed under the Apache License, Version 2.0 (the "License").
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
import PlaygroundSupport
import AsyncDisplayKit

public protocol ASPlayground: class {
  func display(inRect: CGRect)
}

extension ASPlayground {
  public func display(inRect rect: CGRect) {
    var rect = rect
    if rect.size == .zero {
      rect.size = CGSize(width: 400, height: 400)
    }

    guard let nodeSelf = self as? ASDisplayNode else {
      assertionFailure("Class inheriting ASPlayground must be an ASDisplayNode")
      return
    }

    let constrainedSize = ASSizeRange(min: rect.size, max: rect.size)
    _ = ASCalculateRootLayout(nodeSelf, constrainedSize)
    nodeSelf.frame = rect
    PlaygroundPage.current.needsIndefiniteExecution = true
    PlaygroundPage.current.liveView = nodeSelf.view
  }
}
