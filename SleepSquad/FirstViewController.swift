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
    
    var year = -1
    var month = -1
    var day = -1
    var hour = -1
    var minutes = -1
    var dayOfWeek = -1 //dayOfWeek is values 0-6.
    
    var dict = NSDictionary()
    
//    var dict =
//        [0: ["hours": 1, "minutes": 55], //Sunday
//        1: ["hours": 1, "minutes": 10], //Monday, etc...
//        2: ["hours": 7, "minutes": 04],
//        3: ["hours": 7, "minutes": 04],
//        4: ["hours": 7, "minutes": 04],
//        5: ["hours": 7, "minutes": 04],
//        6: ["hours": 7, "minutes": 04]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let data = defaults.objectForKey("Schedule") as? NSData!
        dict = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! NSDictionary
        
        timePicker.datePickerMode = UIDatePickerMode.Time;
        setTimeUntil();
        self.view.backgroundColor = UIColor(red: 0.153, green: 0.192, blue: 0.247, alpha: 1.0);
        
        // Do any additional setup after loading the view, typically from a nib.
        
        getDateInfo()
        getTimeUntilWakeup()
        //saveToNSUserDefault()
        print("this is what im talking about")
        print(dict)
        let totalMinutesUntilWakeUp = getTimeUntilWakeup()!
        let hoursUntilWakeUp = (totalMinutesUntilWakeUp/60)
        let minsUntilWakeUp = totalMinutesUntilWakeUp % 60
        
        
    }
    
    func saveToNSUserDefault(){
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(dict)
        defaults.setObject(data, forKey: "Schedule")
        

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
    
        year =  components.year
        month = components.month
        day = components.day
        hour = components.hour;
        minutes = components.minute;
        
        dayOfWeek = (Int(getDayOfWeek(String(year) + "-" + String(month) + "-" + String(day))!)) - 1 //Gives back day as 1-7 for Sunday-Saturday, so subtract 1 to make it match our array representations of the week.
    
        print(year)
        print(month)
        print(day)
        print(hour)
        print(minutes)
        print(dayOfWeek)
        
    }
    func getTimeAs24Hr(dateAsString:String)->NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.dateFromString(dateAsString)
        return date!
    }
    
    func getTimeUntilWakeup()->Int? {
        
        //Compare the current time to the wakeup time for today.
        
        let wakeupHour = dict[dayOfWeek]!["hours"] as! Int
        let wakeupMinutes = dict[dayOfWeek]!["minutes"] as! Int
        
        var timeString = "" + String(wakeupHour) + ":" + String(wakeupMinutes) //Get time into format 06:35
        
        var wakeUpTodayObject = getTimeAs24Hr(timeString) //wakeupDateObject is object storing time to wake up
        
        let currentTimeObject = getTimeAs24Hr("" + String(hour) + ":" + String(minutes))
        
        var extra = 0.0 //Exists to add 24 hours if the wakeup time is the next day
        
        if (currentTimeObject.compare(wakeUpTodayObject) != NSComparisonResult.OrderedAscending) //If it is on or after the wakeup hour,
        {
            //The next wakeup hour is the next day. Change the object representing the next wakeup hour
            var wakeUpDay = 0
            if (dayOfWeek == 6) //Wraparound
            {
                wakeUpDay = 0
            }
            else
            {
                wakeUpDay = dayOfWeek+1
            }
            
            //Recalculate the wakeup time so that it is the proper day.
            timeString = "" + String(dict[wakeUpDay]!["hours"] as! Int) + ":" + String(dict[wakeUpDay]!["minutes"] as! Int) //Get time into format 06:35
            wakeUpTodayObject = getTimeAs24Hr(timeString) //wakeupDateObject is object storing time to wake up
            
            //Add 24 hours to wakeup time
            extra = 1440.0
        }
        else //If it is before the wakeup hour,
        {
            //The next wakeup hour is the one for that day.
            //wakeUpTodayObject is already set to this day, so don't change it.
        }
        
        let timeUntilWakeup = floor(Double(wakeUpTodayObject.timeIntervalSinceDate(currentTimeObject))/60) + extra
        
        return Int(timeUntilWakeup) //Returns time in minutes, as a double.
    }
    
    func getDayName(dayInt:Int)->String? {
        var days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        return days[dayInt]
        
    }


}

