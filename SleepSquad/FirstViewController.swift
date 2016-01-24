//
//  FirstViewController.swift
//  SleepSquad
//
//  Created by Agustin Malo  on 1/23/16.
//  Copyright © 2016 SleepSquad. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var progressView: CircleProgressView!
    @IBOutlet var hoursLabel: UILabel!
    @IBOutlet var minutesLabel: UILabel!
    @IBOutlet var timePicker: UIDatePicker!
    
    var defaults: NSUserDefaults = NSUserDefaults(suiteName: "group.com.SleepSquad.app")!
    

    let dict =
        ["Monday": ["hours": 7, "minutes": 4, "ampm": "AM"],
        "Tuesday": ["hours": 7, "minutes": 4, "ampm": "AM"],
        "Wednesday": ["hours": 7, "minutes": 4, "ampm": "AM"],
        "Thursday": ["hours": 7, "minutes": 4, "ampm": "AM"],
        "Friday": ["hours": 7, "minutes": 4, "ampm": "AM"],
        "Saturday": ["hours": 7, "minutes": 4, "ampm": "AM"],
        "Sunday": ["hours": 7, "minutes": 4, "ampm": "AM"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        timePicker.datePickerMode = UIDatePickerMode.Time;
        setTimeUntil();
        self.view.backgroundColor = UIColor(red: 0.153, green: 0.192, blue: 0.247, alpha: 1.0);
        
        // Do any additional setup after loading the view, typically from a nib.
        defaults.setObject(dict, forKey: "SavedDict")
        getDateInfo()
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTimeUntil() {
        self.hoursLabel.text = String(04);
        self.minutesLabel.text = String(31);
        self.progressView.progress = 0.32

    }

    func getDayOfWeek(today:String)->Int? {
        
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let todayDate = formatter.dateFromString(today) {
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            let myComponents = myCalendar.components(.Weekday, fromDate: todayDate)
            let weekDay = myComponents.weekday
            return weekDay
        } else {
            return nil
        }
    }
    
    func getDateInfo() {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year, .Hour, .Minute], fromDate: date)
    
        let year =  components.year
        let month = components.month
        let day = components.day
        let hour = components.hour;
        let minutes = components.minute;
        
        let dayOfWeek = String(getDayOfWeek(String(year) + "-" + String(month) + "-" + String(day))!)
    
        print(year)
        print(month)
        print(day)
        print(hour)
        print(minutes)
        print(dayOfWeek)
        
    }


}

