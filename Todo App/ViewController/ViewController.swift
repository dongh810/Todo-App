import UIKit
import Alamofire

class ViewController: UIViewController {
    
    
    @IBOutlet weak var loginBtnr: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBAction func loginBtn(_ sender: UIButton) {
        let id = idTextField.text ?? ""
        let pw = pwTextField.text ?? ""
        
        let param = loginrequest(user_id: id, user_pw: pw)
        login(param)
        
        
    }
    
    @IBAction func signInBtn(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MemberViewController") as! MemberViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtnr.layer.cornerRadius = 10
        loginBtnr.layer.shadowColor = UIColor.gray.cgColor
        loginBtnr.layer.masksToBounds = false
        loginBtnr.layer.shadowOffset = CGSize(width: 4, height: 4)
        loginBtnr.layer.shadowRadius = 5
        loginBtnr.layer.shadowOpacity = 0.3
        
    }
    
    
    func login(_ parameters: loginrequest) {
        let url = "http://15.164.102.4:3001/login"
        
        AF.request(url, method: .post, parameters:parameters, encoder:JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: loginresponse.self) {
                [self] response in
                switch response.result {
                case .success(let response):
                    if response.isSuccess == true{
                        print(response.message)
                        UserDefaults.standard.set(response.data.token, forKey: "userToken")
                        print(UserDefaults.standard.string(forKey: "userToken") ?? "no userToken")
                        print(response.data)
                        //로그인버튼 눌렀을때 캘린더화면으로 가는 코드
                        let storyBoard = UIStoryboard(name: "Sub", bundle: nil)
                        let calendarVC = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
                        self.navigationController?.pushViewController(calendarVC, animated: true)
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
//"\(response.data)"
