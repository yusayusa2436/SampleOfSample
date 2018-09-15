//
//  MainVC.swift
//  OptionalApp
//
//  Created by 佐藤優輝 on H30/04/25.
//  Copyright © 平成30年 佐藤優輝. All rights reserved.
//

import UIKit
import Foundation

/// 処理パターンの列挙型
/// - exeIf
/// - exeGuard
public enum BindingType: String {
    case exeIf = "if let"
    case exeGuard = "guard let"
}

class MainVC: UIViewController {
    
    let some: Optional<Any> = nil
    
    private var stsBarHeight: CGFloat = 0
    private var naviHeight: CGFloat = 0
    private var visibleHeight: CGFloat = 0

    private var sizeOfSv: (top: CGSize, middle: CGSize, bottom: CGSize) = (.zero, .zero, .zero)
    private var posOfButton: (CGPoint, CGPoint) = (.zero, .zero)

    private var opt: CustomOptional?

    private var tmpOptStrArray = [String?]()
    
    /// スタックビュー: 上部
    private lazy var svTopElement: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.spacing = 20
        sv.distribution = .fillEqually
        sv.addArrangedSubview(lbForOptParamArray)
        sv.addArrangedSubview(svBtnTop)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.widthAnchor.constraint(equalToConstant: sizeOfSv.top.width).isActive = true
        sv.heightAnchor.constraint(equalToConstant: sizeOfSv.top.height).isActive = true
        return sv
    }()
    
    /// スタックビュー: 上部: 要素1
    private lazy var lbForOptParamArray: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.numberOfLines = 0
        lb.sizeToFit()
        lb.textAlignment = .center
        lb.textColor = .black
        lb.font = .systemFont(ofSize: sizeOfSv.top.width / 20)
        lb.backgroundColor = .white
        lb.layer.borderWidth = 0
        lb.layer.borderColor = UIColor.darkGray.cgColor
//        lb.translatesAutoresizingMaskIntoConstraints = false
//        lb.widthAnchor.constraint(equalToConstant: sizeOfSv.top.width).isActive = true
//        lb.heightAnchor.constraint(equalToConstant: sizeOfSv.top.height * 0.75).isActive = true
        return lb
    }()

    /// スタックビュー: 上部: 要素2
    private lazy var svBtnTop: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.spacing = 10
        sv.distribution = .fillEqually
        sv.addArrangedSubview(btn.0)
        sv.addArrangedSubview(btn.1)
        sv.addArrangedSubview(btn.2)
        return sv
    }()
    
    /// スタックビュー: 中央
    private lazy var svMiddleElement: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.spacing = 20
        sv.distribution = .fillEqually
        sv.addArrangedSubview(lbResult.ifLet)
        sv.addArrangedSubview(lbResult.guardLet)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.widthAnchor.constraint(equalToConstant: sizeOfSv.middle.width).isActive = true
        sv.heightAnchor.constraint(equalToConstant: sizeOfSv.middle.height).isActive = true
        return sv
    }()
    
    /// 画面中央のOptional Binding の実行結果ラベル
    /// - ifLet: if let 構文の結果用ラベル
    /// - guardLet: guard let 構文の結果用ラベル
    private lazy var lbResult: (ifLet: UILabel, guardLet: UILabel) = {
        
        var lbArray = [UILabel]()
        for i in 0...1 {
            let lb = UILabel()
            lb.text = Const.QUESTION + Const.PLACE_HOLDER
            lb.textAlignment = .center
            lb.numberOfLines = 0
            lb.adjustsFontSizeToFitWidth = true
            lb.textColor = .white
            lb.font = .systemFont(ofSize: sizeOfSv.middle.width / 20)
            lb.backgroundColor = .black
            
            lb.layer.borderWidth = 5
            lb.layer.borderColor = UIColor.darkGray.cgColor
            //        lb.layer.cornerRadius = 10
            lb.layer.shadowRadius = 0
            lb.layer.shadowOpacity = 1
            lb.layer.shadowOffset = CGSize(width: 5, height: 5)
            //        lb.layer.masksToBounds = false
            
            lbArray.append(lb)
        }
        return (lbArray[0], lbArray[1])
    }()
    
    /// スタックビュー: 下部
    private lazy var svBottomElement: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.spacing = 20
        sv.distribution = .fillEqually
        sv.addArrangedSubview(btn.3)
        sv.addArrangedSubview(btn.4)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.widthAnchor.constraint(equalToConstant: sizeOfSv.bottom.width).isActive = true
        sv.heightAnchor.constraint(equalToConstant: sizeOfSv.bottom.height).isActive = true
        return sv
    }()
    
    /// ボタン要素タプル
    /// - 0: nil
    /// - 1: 0〜100のランダムな数字
    /// - 2: CustomOptionalクラスのnil化
    /// - 3: if let 構文の実行
    /// - 4: guard let 構文の実行
    private lazy var btn: (UIButton, UIButton, UIButton, UIButton, UIButton) = {
        var btnArray = [UIButton]()
        for i in 0...4 {
            let b = UIButton()
            b.tag = i
            switch i {
            case 0: b.setTitle("nil", for: .normal)
            case 1: b.setTitle("ランダム", for: .normal)
            case 2: b.setTitle("クラスnil切り替え", for: .normal)
            case 3: b.setTitle(BindingType.exeIf.rawValue, for: .normal)
            case 4: b.setTitle(BindingType.exeGuard.rawValue, for: .normal)
            default: break
            }
            b.backgroundColor = .customMain
            if i == 3 {
                b.setTitleColor(.white, for: .normal)
            } else {
            }
            b.setTitleColor(.white, for: .normal)
            b.setTitleColor(.yellow, for: .highlighted)
            b.titleLabel?.sizeToFit()
            b.layer.borderWidth = 5
            b.layer.borderColor = UIColor.darkGray.cgColor
            b.layer.masksToBounds = false
            b.layer.cornerRadius = 10
            b.layer.shadowRadius = 3
            b.layer.shadowOpacity = 1
            b.layer.shadowOffset = CGSize(width: 3, height: 3)
            b.addTarget(self, action: #selector(MainVC.exeTappedButton(_:)), for: .touchUpInside)
            
            btnArray.append(b)
        }
        return (btnArray[0], btnArray[1], btnArray[2], btnArray[3], btnArray[4])
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        exeSetupItemSize()
        exeSetupUiItems()

        opt = CustomOptional()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        tmpOptStrArray = []
    }

}

extension MainVC {
    
    private func exeSetupItemSize() {
        
        let size = UIScreen.main.bounds
        stsBarHeight = UIApplication.shared.statusBarFrame.size.height
        naviHeight = (self.navigationController?.navigationBar.frame.size.height)!
        
        visibleHeight = size.height - (stsBarHeight + naviHeight)
        
        let commonBaseWidth: CGFloat = size.width * 0.9
        let commonBaseHeight = visibleHeight * 0.9
        sizeOfSv = (
            .init(width: commonBaseWidth, height: (commonBaseHeight * 0.45) * 0.9), // top
            .init(width: commonBaseWidth, height: (commonBaseHeight * 0.45) * 0.9), // middle
            .init(width: commonBaseWidth, height: (commonBaseHeight * 0.1) * 0.9)  // bottom
        )
    }
    
    private func exeSetupUiItems() {
        
        self.navigationItem.title = Const.TITLE
        
        view.backgroundColor = .customBase
        
        // UI追加
        view.addSubview(svTopElement)
        view.addSubview(svMiddleElement)
        view.addSubview(svBottomElement)

        // 制約設定（座標）
        svTopElement.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        svTopElement.topAnchor.constraint(equalTo: view.topAnchor, constant: stsBarHeight + naviHeight + 10).isActive = true

        svMiddleElement.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        svMiddleElement.topAnchor.constraint(equalTo: svTopElement.bottomAnchor, constant: 30).isActive = true

        svBottomElement.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        svBottomElement.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
    
    @objc private func exeTappedButton(_ sender: UIButton) {
        switch sender.tag {
        case 0...2: exeAppendTestDataForOB(sender.tag)
        case 3: exe(.exeIf)
        case 4: exe(.exeGuard)
        default: break
        }
    }
    
    /// OB = Optional Binding
    private func exeAppendTestDataForOB(_ tag: Int) {
        
        if lbForOptParamArray.text != nil && lbForOptParamArray.text != "" {
            lbForOptParamArray.text?.append(Const.COMMA_AND_SPACE)
        }
        switch tag {
        case 0:
            lbForOptParamArray.text?.append(Const.STR_NIL)
            tmpOptStrArray.append(nil)
        case 1:
            let tmpStrNum = exeCreateRandomNumberWithString()
            lbForOptParamArray.text?.append(tmpStrNum)
            tmpOptStrArray.append(tmpStrNum)
        case 2:
            // カスタムオプショナル自体をnilにする
            opt = opt == nil ? CustomOptional() : nil
        default: break
        }
    }
    
    /// 0〜100で生成した配列をシャッフルして、末要素を文字列で返す
    private func exeCreateRandomNumberWithString() -> String {
        var random = (0...100).map { $0 }
        random.exeShuffle()
        return "\(random.last!)"
    }

    private func exe(_ type: BindingType) {
        
        guard let opt = opt else {
            if type == .exeIf {
                lbResult.ifLet.text = Const.CUSTOM_OPTIONAL_IS_NIL
                lbResult.guardLet.text = ""
            } else {
                lbResult.ifLet.text = ""
                lbResult.guardLet.text = Const.CUSTOM_OPTIONAL_IS_NIL
            }
            return
        }
        
        var shuffledArray = tmpOptStrArray
        shuffledArray.exeShuffle()
        var paramOptStrArray = [String?]()

        var questionOptStrArray = [String?]()
        for opt in shuffledArray where questionOptStrArray.count < 5 {
            
            print("\(String(describing: opt))")
            guard let str = opt else {
                questionOptStrArray.append("nil")
                paramOptStrArray.append(nil)
                continue
            }
            questionOptStrArray.append("\(str)")
            paramOptStrArray.append(str)
        }
        
        var tmpStr = ""
        for i in 0..<questionOptStrArray.count {
            guard let str = questionOptStrArray[i] else { continue }
            tmpStr.append(str)
            if (i + 1) < questionOptStrArray.count { tmpStr.append(Const.COMMA_AND_SPACE) }
        }
        
        let placeHolders = String(format: Const.QUESTION, tmpStr) + Const.PLACE_HOLDER
        if type == .exeIf {
            lbResult.ifLet.text = placeHolders
            lbResult.ifLet.text?.append(opt.exeOptionalBinding(type, optStrArray: paramOptStrArray))
        } else {
            lbResult.guardLet.text = placeHolders
            lbResult.guardLet.text?.append(opt.exeOptionalBinding(type, optStrArray: paramOptStrArray))
        }
    }
}

extension Array {
    /// 配列要素のシャッフル
    mutating func exeShuffle() {
        for i in 0..<self.count {
            let j = Int(arc4random_uniform(UInt32(self.indices.last!)))
            if i != j {
                self.swapAt(i, j)
            }
        }
    }
    
    var shuffled: Array {
        var copied = Array<Element>(self)
        copied.exeShuffle()
        return copied
    }
}
