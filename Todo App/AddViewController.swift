//
//  AddViewController.swift
//  Todo App
//
//  Created by 백동현 on 2022/07/09.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var myTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextView.isScrollEnabled = false
        myTextView.delegate = self
        myTextView.text = "내용을 입력해주세요"
        myTextView.textColor = UIColor(red: 161/255, green: 161/255, blue: 170/255, alpha: 1)
        myTextView.font = UIFont(name: "Inter-SemiBold", size: 14)
        myTextView.sizeToFit()
        addBtn.layer.cornerRadius = 10
        addBtn.layer.shadowColor = UIColor.gray.cgColor
        addBtn.layer.masksToBounds = false
        addBtn.layer.shadowOffset = CGSize(width: 4, height: 4)
        addBtn.layer.shadowRadius = 5
        addBtn.layer.shadowOpacity = 0.3
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.myTextView.resignFirstResponder()
        }
    
}
extension AddViewController: UITextViewDelegate {
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            
            /// 180 이하일때는 더 이상 줄어들지 않게하기
            if estimatedSize.height <= 20{
                
            }
            else {
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
        }
    }
    



func textViewDidEndEditing(_ textView: UITextView) {
    if myTextView.text.isEmpty {
        myTextView.text =  "내용을 입력해주세요"
        myTextView.textColor = UIColor(red: 161/255, green: 161/255, blue: 170/255, alpha: 1)
    }
    
}


func textViewDidBeginEditing(_ textView: UITextView) {
    if myTextView.textColor == UIColor(red: 161/255, green: 161/255, blue: 170/255, alpha: 1) {
        myTextView.text = nil
        myTextView.textColor = UIColor.black
    }
}



}

