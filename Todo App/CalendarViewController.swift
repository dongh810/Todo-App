//
//  CalendarViewController.swift
//  Todo App
//
//  Created by 백동현 on 2022/07/02.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource{
    
    @IBOutlet weak var contentBtn: UITableView!
    @objc func contentBtnTapped(sender:UITapGestureRecognizer) {
        let storyBoard = UIStoryboard(name: "Sub", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ModifyViewController") as! ModifyViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    @IBOutlet weak var tableView_custom: UITableView!
    let cellName:String="customCell"
    let cellTitle: Array<String> = ["111","222","333"]
    let cellimage: Array<String> = ["circlebadge.fill","circlebadge.fill","circlebadge.fill"]
    
    // 테이블 뷰 커스텀
    /*
     let data:[[String]] = [["하암 너무 졸려","오늘은 가슴하는날","개졸려"],["111","222","333"]]
     let sub:[[String]] = [["얼른자야딩", "가슴개맛있겠따", "딥슬립~"],["4444","5555","66666"]]
     let headers:[String] = ["Numbered","Lettered"]*/
    
    // 테이블 뷰
    
    // 테이블 뷰 부분
    /*@IBOutlet weak var tableView: UITableView!
     let cellIdentifier: String = "cell"
     
     let korean: [String] = ["에스프레소", "아메리카노"]
     let english: [String] = ["espresso", "americano"]*/
    
    // 네비게이션 전환 코드
    @IBAction func plusBtn(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Sub", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //캘린더
    @IBOutlet var calendarView: FSCalendar!
    @IBOutlet weak var dateLabel: UILabel!
    private var currentPage: Date?
    private lazy var today: Date = {
        return Date()
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "yyyy년 M월"
        return df
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setCalendar()
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        /* 테이블 사이즈 알아서 조절
         self.tableView.estimatedRowHeight = 50
         self.tableView.rowHeight = UITableViewAutomaticDimension
         */
    }
    private func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
        
        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendarView.setCurrentPage(self.currentPage!, animated: true)
    }
    
    
    func setCalendar() {
        calendarView.delegate = self
        calendarView.delegate = self
        calendarView.headerHeight = 0
        calendarView.scope = .month
        dateLabel.text = self.dateFormatter.string(from: calendarView.currentPage)
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.dateLabel.text = self.dateFormatter.string(from: calendar.currentPage)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.headerHeight = 0      // YYYY년 M월 표시부 영역 높이
        calendarView.weekdayHeight = 16    // 날짜 표시부 행의 높이
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0    //헤더 좌,우측 흐릿한 글씨 삭제
        calendarView.placeholderType = .none
        calendarView.appearance.headerDateFormat = "YYYY년 MM월"      //날짜(헤더) 표시 형식
        dateLabel.font = UIFont(name: "Inter-SemiBold", size: 18)
        calendarView.scrollEnabled = true
        calendarView.calendarHeaderView.isHidden = true
        calendarView.backgroundColor = .white   // 배경색
        calendarView.appearance.weekdayTextColor = UIColor(red: 113/255, green: 113/255, blue: 122/255, alpha: 1) //요일(월,화,수..) 글씨 색
        calendarView.appearance.selectionColor = UIColor(red: 59/255, green: 130/255, blue: 246/255, alpha: 1) //선택 된 날의 동그라미 색
        calendarView.appearance.titleWeekendColor = .black //주말 날짜 색
        calendarView.appearance.titleDefaultColor = .black //기본 날짜 색
        
        calendarView.appearance.titleTodayColor = .none          //Today에 표시되는 특정 글자색
        calendarView.appearance.todayColor = .none              //Today에 표시되는 선택 전 동그라미 색
        calendarView.appearance.todaySelectionColor = .none     //Today에 표시되는 선택 후 동그라미 색
    
        calendarView.appearance.titleFont = UIFont(name: "Inter-SemiBold", size: 10)
        calendarView.appearance.weekdayFont = UIFont(name: "Inter-SemiBold", size: 10)
        calendarView.calendarWeekdayView.weekdayLabels[0].text = "SUN"
        calendarView.calendarWeekdayView.weekdayLabels[1].text = "MON"
        calendarView.calendarWeekdayView.weekdayLabels[2].text = "TUE"
        calendarView.calendarWeekdayView.weekdayLabels[3].text = "WED"
        calendarView.calendarWeekdayView.weekdayLabels[4].text = "THU"
        calendarView.calendarWeekdayView.weekdayLabels[5].text = "FRI"
        calendarView.calendarWeekdayView.weekdayLabels[6].text = "SAT"
        
        //테이블
        tableView_custom.delegate = self
        tableView_custom.dataSource = self
       
        
        //클릭액션
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(contentBtnTapped))
        contentBtn.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    
    
    
}
extension CalendarViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int{
        return cellTitle.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView_custom.dequeueReusableCell(withIdentifier: cellName,for:indexPath) as! CustomCell
        customCell.icon.image = UIImage(systemName: cellimage[indexPath.row])
        customCell.head.text = cellTitle[indexPath.row]
        customCell.selectionStyle = .none
        
        return customCell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
