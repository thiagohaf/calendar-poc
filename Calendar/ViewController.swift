//
//  ViewController.swift
//  Calendar
//
//  Created by Thiago Henrique Alves Ferreira on 02/04/22.
//

import UIKit
import FSCalendar

class ViewController: UIViewController {
    
    var calendar: FSCalendar!
    var formatter = DateFormatter()
    let today = Date()
    
    lazy var fsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("FSSample", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(fsButtonTapped), for: .touchUpInside)
        return button
    }()

    private func setupCalendarAppearence() {
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 17)
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 18)
        calendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 16)
        
        calendar.appearance.todayColor = .systemGreen
        calendar.appearance.titleTodayColor = .systemYellow
        calendar.appearance.titleDefaultColor = .systemBlue
        calendar.appearance.headerTitleColor = .systemRed
        calendar.appearance.weekdayTextColor = .systemPurple
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupUI()
        
        calendar = FSCalendar(frame: CGRect(x: 0.0,
                                            y: 50.0,
                                            width: self.view.frame.size.width,
                                            height: 300.0))
        
        calendar.scrollDirection = .horizontal
        calendar.scope = .month
        calendar.locale = Locale(identifier: "pt-br")
        self.view.addSubview(calendar)
        
        calendar.dataSource = self
        calendar.delegate = self
        
        setupCalendarAppearence()
    }

    @objc func fsButtonTapped() {
        print("fs tapped")
//        var popUpWindowVC = PopUpWindowViewcontroller(title: "test", text: "vamos sao paulo", buttontext: "bora")
//        self.present(popUpWindowVC, animated: true)
    }
    
    func isWeekend(date: Date) -> Bool {
        let myCalendar = Calendar(identifier: .gregorian)
        let components = myCalendar.dateComponents([.weekday], from: date)

        if components.weekday == 1 || components.weekday == 7 {
            return true
        }
        return false
    }
    
    func isHoliday(date: Date) -> Bool {
        formatter.dateFormat = "dd-MM-yyyy"
        guard let excludedDate = formatter.date(from: "19-04-2022") else { return false }
        if date.compare(excludedDate) == .orderedSame {
            return true
        }
        return false
    }
}

extension ViewController {
    func setupUI() {
        view.addSubview(fsButton)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            fsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            fsButton.widthAnchor.constraint(equalToConstant: 100),
            fsButton.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}

extension ViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd-MM-yyyy"
        print(">>>> selecionado >>>> \(formatter.string(from: date))")
    }
}

extension ViewController: FSCalendarDataSource {
    func minimumDate(for calendar: FSCalendar) -> Date {
        return today
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        let modifiedDate = Calendar.current.date(byAdding: .day, value: 90, to: today)
//        return Date().addingTimeInterval((24*60*60)*5)
        return modifiedDate ?? today
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        if isWeekend(date: date) || isHoliday(date: date) {
            return false
        }
        return true
    }
}

extension ViewController: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if isHoliday(date: date) {
            return .red
        }
        
        if isWeekend(date: date) {
            return .lightGray
        }
        return nil
    }
}
