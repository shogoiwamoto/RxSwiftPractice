//
//  ViewController.swift
//  RxSwiftPractice
//
//  Created by 岩本省吾 on 2020/06/12.
//  Copyright © 2020 岩本省吾. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var stateSegmentedControl: UISegmentedControl!
    @IBOutlet weak var freeTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    //オブジェクトの解放用
    let disposeBag = DisposeBag()
    
    enum State: Int {
        case useButtones
        case useTextField
    }
    
    //初期化時の初期値の設定
    let lastSelectingGreeting:Variable<String> = Variable("こんにちは")
    
    @IBOutlet var greetingButtons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //テキスト入力のイベントを観測対象とする
        let nameObservable:Observable<String?> = nameTextField.rx.text.asObservable()
        
        //自由入力のテキストのイベントを観測対象とする
        let freeObservable:Observable<String?> = freeTextField.rx.text.asObservable()
        
        // Do any additional setup after loading the view.
    }
    
    

    
    

}

