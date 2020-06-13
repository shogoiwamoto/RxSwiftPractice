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
        
        //name,freeそれぞれの最新の値同士を結合
        let freewordWithNameObservable:Observable<String?> = Observable.combineLatest(nameObservable, freeObservable) {
            (string1: String?,string2: String?) in
            
            return string1! + string2!
            
            
        }
        
        //(bindTo)イベントのプロパティ接続をする ※bindToの引数内に表示対象のUIパーツを設定
        //(DisposeBag)購読[監視?]状態からの解放を行う
        freewordWithNameObservable.bindTo(greetingLabel.rx.text).addDisposableTo(disposeBag)
        
        //セグメントコントロールの値変化を観測対象にする
        let segementedControlObservable: Observable<Int> = stateSegmentedControl.rx.value.asObservable()
        
        
        //セグメントコントロールの値変化を検知。その状態に対応するenumの値を返す
        //(map)別の要素に変換する ※IntからStateへ変換
        let stateObservable: Observable<State> = segementedControlObservable.map { (selectedIndex:Int) -> State in
            
            return State(rawValue: selectedIndex)!
        }
        
        //enumの値変化を検知。textFieldが値を受け付ける状態かを返す
        //(map)別の要素に変換する ※StateからBoolへ変換
        let greetingTextFieldEnabledObservable: Observable<Bool> = stateObservable.map { (state: State) -> Bool in
            
            return state == .useTextField
        }
        
        
        //(bindTo)イベントのプロパティ接続をする ※bindToの引数内に表示対象のUIパーツを設定
        //(DisposeBag)観測状態からの解放を行う
        greetingTextFieldEnabledObservable.bindTo(freeTextField.rx.isEnabled).addDisposableTo(disposeBag)
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    

    
    

}

