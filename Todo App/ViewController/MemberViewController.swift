//
//  MemberViewController.swift
//  Todo App
//
//  Created by 백동현 on 2022/07/02.
//

import UIKit
import Alamofire



class MemberViewController: UIViewController {
    
    @IBOutlet weak var signbtnr: UIButton!
    @IBOutlet weak var idInput: UITextField!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var pwInput: UITextField!
    @IBOutlet weak var pwcheck: UITextField!
    @IBAction func enrollBtn(_ sender: UIButton) {
        let id = idInput.text ?? ""
        let pw = pwInput.text ?? ""
        let pwCk = pwcheck.text ?? ""
        let name = nameInput.text ?? ""
        
        let param = EnrollRequest(user_id: id, user_pw: pw, user_confirmPw: pwCk, user_name: name)
        enroll(param)
    }
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
    func enroll(_ parameters: EnrollRequest) {
        let url = "http://15.164.102.4:3001/enroll"
        AF.request(url, method: .post, parameters:parameters, encoder:JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: EnrollResponse.self) {
                [self] response in
                switch response.result {
                case .success(let response):
                    if response.isSuccess == true{
                        print(response.message)
                    }
                    else{
                        print(response.message)
                    }
                case .failure(let error):
                    print("\(error.localizedDescription)")
                }
            }

    }

    
}


