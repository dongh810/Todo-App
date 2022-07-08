//
//  AddViewController.swift
//  Todo App
//
//  Created by 백동현 on 2022/07/09.
//

import UIKit

class AddViewController: UIViewController {
    
    // 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
            self.myTextView.resignFirstResponder()
        }
    // 키보드 올라올때 화면도 올리기
    override func viewWillAppear(_ animated: Bool) {
        // 옵져버를 등록
        // 옵저버 대상 self
        // 옵져버 감지시 실행 함수
        // 옵져버가 감지할 것
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardUp(notification:NSNotification) {
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
           let keyboardRectangle = keyboardFrame.cgRectValue
       
            UIView.animate(
                withDuration: 0.3
                , animations: {
                    self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardRectangle.height)
                }
            )
        }
    }
    @objc func keyboardDown() {
        self.view.transform = .identity
    }

     

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBOutlet weak var myTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextView.delegate = self
        myTextView.text = "내용을 입력해주세요"
        myTextView.textColor = UIColor.lightGray
        myTextView.layer.borderWidth = 1
        myTextView.layer.borderColor = UIColor.black.cgColor
        myTextView.font = UIFont(name: "Roboto-Medium", size: 14)

        // Do any additional setup after loading the view.
    }
  
}
extension AddViewController: UITextViewDelegate {
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if myTextView.text.isEmpty {
            myTextView.text =  "내용을 입력해주세요"
            myTextView.textColor = UIColor.lightGray
        }

    }

    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if myTextView.textColor == UIColor.lightGray {
            myTextView.text = nil
            myTextView.textColor = UIColor.black
        }
    }


}
