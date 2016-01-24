//
//  TodayViewController.swift
//  SSWidget
//
//  Created by Agustin Malo  on 1/23/16.
//  Copyright © 2016 SleepSquad. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var sleepLeftLabel: UILabel!
    
    var year = -1
    var month = -1
    var day = -1
    var hour = -1
    var minutes = -1
    var dayOfWeek = -1 //dayOfWeek is values 0-6.
    
    var dict = NSDictionary()
    
    var defaults: NSUserDefaults = NSUserDefaults(suiteName: "group.com.SleepSquad.app")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        let data = defaults.objectForKey("Schedule") as? NSData!
        dict = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! NSDictionary
       
        //setTimeUntil();
        getDateInfo()
        getTimeUntilWakeup()
        
        let totalMinutesUntilWakeUp = getTimeUntilWakeup()!
        let hoursUntilWakeUp = (totalMinutesUntilWakeUp/60)
        let minsUntilWakeUp = totalMinutesUntilWakeUp % 60
        
        sleepLeftLabel.text = "If you go to sleep now... You'll get " + String(hoursUntilWakeUp) + " hours and " + String(minsUntilWakeUp) + " minutes of sleep."
        
        
        
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
