//
//  ModifyViewController.swift
//  Todo App
//
//  Created by 백동현 on 2022/07/16.
//

import UIKit

class ModifyViewController: UIViewController {
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var modifyBtn: UIButton!
    @IBOutlet weak var metextView: UITextView!
    @IBOutlet weak var headText: UITextField!
    @IBOutlet weak var mDate: UITextField!
    var modifyHead: String = ""
    var modifyconctent: String = ""
    var date: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        metextView.sizeToFit()
        metextView.isScrollEnabled = false
        metextView.delegate = self
        deleteBtn.layer.cornerRadius = 10
        deleteBtn.layer.shadowColor = UIColor.gray.cgColor
        deleteBtn.layer.masksToBounds = false
        deleteBtn.layer.shadowOffset = CGSize(width: 4, height: 4)
        deleteBtn.layer.shadowRadius = 5
        deleteBtn.layer.shadowOpacity = 0.3
        modifyBtn.layer.cornerRadius = 10
        modifyBtn.layer.shadowColor = UIColor.gray.cgColor
        modifyBtn.layer.masksToBounds = false
        modifyBtn.layer.shadowOffset = CGSize(width: 4, height: 4)
        modifyBtn.layer.shadowRadius = 5
        modifyBtn.layer.shadowOpacity = 0.3
        headText.text = modifyHead
        metextView.text = modifyconctent
        mDate.text = date
        
        
        
        // Do any additional setup after loading the view.
    }
}
extension ModifyViewController: UITextViewDelegate {
        
        
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
}
