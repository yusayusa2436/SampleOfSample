//
//  Color.swift
//  OptionalApp
//
//  Created by 佐藤優輝 on H30/04/25.
//  Copyright © 平成30年 佐藤優輝. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    
    /// RGB指定のカラー設定
    /// - Parameters:
    ///   - r: RED
    ///   - g: GREEN
    ///   - b: BLUE
    ///   - a: alpha
    /// - Returns: 指定色
    class func rgb(_ r: Int, _ g: Int, _ b: Int, _ alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    /// メイン: rgb(63, 114, 184, 1.0)
    class var customMain: UIColor { return rgb(63, 114, 184, 1.0) }

    /// ベース: rgb(244, 243, 244, 1.0)
    class var customBase: UIColor { return rgb(244, 243, 244, 1.0) }

    /// アクセント: rgb(98, 98, 98, 1.0)
    class var customAccent: UIColor { return rgb(98, 98, 98, 1.0) }
}
