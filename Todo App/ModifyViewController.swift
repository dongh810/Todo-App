//
//  ModifyViewController.swift
//  Todo App
//
//  Created by 백동현 on 2022/07/16.
//

import UIKit

class ModifyViewController: UIViewController {
    
    @IBOutlet weak var metextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        metextView.sizeToFit()
        metextView.isScrollEnabled = false
        metextView.delegate = self
        
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
