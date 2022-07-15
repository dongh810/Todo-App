//
//  MemberViewController.swift
//  Todo App
//
//  Created by 백동현 on 2022/07/02.
//

import UIKit



class MemberViewController: UIViewController {
    
    @IBOutlet weak var signbtnr: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        signbtnr.layer.cornerRadius = 10
        signbtnr.layer.shadowColor = UIColor.gray.cgColor
        signbtnr.layer.masksToBounds = false
        signbtnr.layer.shadowOffset = CGSize(width: 4, height: 4)
        signbtnr.layer.shadowRadius = 5
        signbtnr.layer.shadowOpacity = 0.3
        // Do any additional setup after loading the view.
    }
    
    
}


