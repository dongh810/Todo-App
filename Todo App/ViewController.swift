import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var loginBtnr: UIButton!
    @IBAction func loginBtn(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Sub", bundle: nil)
        let calendarVC = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        self.navigationController?.pushViewController(calendarVC, animated: true)
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
    
}
