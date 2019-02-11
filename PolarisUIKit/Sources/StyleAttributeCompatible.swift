//
//  StyleAttributedCompatible.swift
//  PolarisUIKit
//
//  Created by overtheleaves on 02/02/2019.
//  Copyright © 2019 overtheleaves. All rights reserved.
//

public protocol StyleAttributeCompatible {
    associatedtype CompatibleType
    
    var styleAttr: StyleAttributeExtension<CompatibleType> { get set }
}

public extension StyleAttributeCompatible {
    public var styleAttr: StyleAttributeExtension<Self> {
        get { return StyleAttributeExtension(self) }
        set { }
    }
}

public class StyleAttributeExtension<Base> {
    public let base: Base
    
    init(_ base: Base) {
        self.base = base
    }
}
