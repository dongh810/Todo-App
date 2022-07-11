import UIKit

class ViewController: UIViewController {
    
    
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
        print("ViewDidLoad call")
        
    }
    
}
