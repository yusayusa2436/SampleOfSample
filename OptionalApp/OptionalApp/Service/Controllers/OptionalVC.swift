//
//  ViewController.swift
//  OptionalApp
//
//  Created by 佐藤優輝 on H30/04/25.
//  Copyright © 平成30年 佐藤優輝. All rights reserved.
//

import UIKit

class CustomOptional {
    
    deinit {
        print("CustomOptional => " + #function)
    }
    
}

// MARK: OptionalVCの拡張: 主にクラス内の独自メソッドを作成
extension CustomOptional {
    
    /// オプショナルバインディング(Optional Binding)
    /// Parameters:
    /// - type: _ BindingType
    /// - someArray:
    /// Returns: 引数を連結した文字列
    func exeOptionalBinding(_ type: BindingType, optStrArray: [String?]) -> String {
        
        var tmpStr = ""
        dump(type)
        print(#function + "optStrArray = \(optStrArray)")
        switch type {
        case .exeIf: // パターン1
            for optStr in optStrArray {
                // パターン1
                print("optStr = \(String(describing: optStr))")
                if let str = optStr {
                    print("str = \(str)")
                    tmpStr.append(str)
                }
            }
            return tmpStr
        case .exeGuard: // パターン2
            
            for optStr in optStrArray {
                // パターン2
                print("optStr = \(String(describing: optStr))")
                guard let str = optStr else {
                    return tmpStr
                }
                print("str = \(str)")
                tmpStr.append(str)
            }
            return tmpStr
        }
    }
}


