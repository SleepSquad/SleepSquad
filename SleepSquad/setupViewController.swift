//
//  setupViewController.swift
//  SleepSquad
//
//  Created by Arturo Esquivel on 1/23/16.
//  Copyright © 2016 SleepSquad. All rights reserved.
//

import UIKit

class setupViewController: UIViewController {
    
    var defaults: NSUserDefaults = NSUserDefaults(suiteName: "group.com.SleepSquad.app")!
    
    @IBOutlet weak var doneSetUp: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var mondayTime: UILabel!
    @IBOutlet weak var tuesdayTime: UILabel!
    @IBOutlet weak var wedsTime: UILabel!
    @IBOutlet weak var thursTime: UILabel!
    @IBOutlet weak var friTime: UILabel!
    @IBOutlet weak var satTime: UILabel!
    @IBOutlet weak var sunTime: UILabel!
    
    var labelLastClicked : Int = -1
    var element : Int?
    
    var dict = [0: ["hours": -1, "minutes": -1], //Sunday
        1: ["hours": -1, "minutes": -1], //Monday, etc...
        2: ["hours": -1, "minutes": -1],
        3: ["hours": -1, "minutes": -1],
        4: ["hours": -1, "minutes": -1],
        5: ["hours": -1, "minutes": -1],
        6: ["hours": -1, "minutes": -1]]
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var pickerSubView: UIView!
    
    @IBAction func doneWithPicker(sender: AnyObject) {
        if pickerSubView.hidden == false {
            let tmpButton = self.view.viewWithTag(labelLastClicked) as? UIButton
            tmpButton?.highlighted = false
            pickerSubView.hidden = true;
        }
        else {
            pickerSubView.hidden = false;
        }
    }
    
    @IBAction func dateButtonTouch(sender: UIButton) {
        print(sender.tag)
        for index in 0...7 {
            let tmpButton1 = self.view.viewWithTag(index) as? UIButton
            tmpButton1?.setTitleColor(UIColor.orangeColor(), forState: .Normal)

        }
        labelLastClicked = sender.tag
        let tmpButton = self.view.viewWithTag(labelLastClicked) as? UIButton
        tmpButton?.setTitleColor(UIColor.yellowColor(), forState: .Normal)
        
        if pickerSubView.hidden == false {
            
        }
        else {
            pickerSubView.hidden = false;
        }
    }
    
    
    @IBAction func pickerAction(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        timePicker.datePickerMode = UIDatePickerMode.Time
        let formatterTimer = dateFormatter.stringFromDate(timePicker.date)
        print(timePicker.date)
        
//        let date = dateFormatter.dateFromString(string1)
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components([.Hour, .Minute], fromDate: timePicker.date)
        let hour = comp.hour
        let minute = comp.minute
        print("hour \(hour)" + " min \(minute)" )
        let number = true
        
        switch number {
        case labelLastClicked == 0 :
            element = 10
            let tmpButton = self.view.viewWithTag(element!) as? UILabel
            tmpButton!.text = formatterTimer
            print("\(formatterTimer)")
            
        case labelLastClicked == 1 :
            element = 11
            let tmpButton = self.view.viewWithTag(element!) as? UILabel
            tmpButton!.text = formatterTimer
            print("\(formatterTimer)")
        
        case labelLastClicked == 2 :
            element = 12
            let tmpButton = self.view.viewWithTag(element!) as? UILabel
            tmpButton!.text = formatterTimer
            print("\(formatterTimer)")
        
        case labelLastClicked == 4 :
            element = 14
            let tmpButton = self.view.viewWithTag(element!) as? UILabel
            tmpButton!.text = formatterTimer
            print("\(formatterTimer)")
        
        case labelLastClicked == 5 :
            element = 15
            let tmpButton = self.view.viewWithTag(element!) as? UILabel
            tmpButton!.text = formatterTimer
            print("\(formatterTimer)")
            
        case labelLastClicked == 6 :
            element = 16
            let tmpButton = self.view.viewWithTag(element!) as? UILabel
            tmpButton!.text = formatterTimer
            print("\(formatterTimer)")
            
        case labelLastClicked == 7 :
            element = 17
            let tmpButton = self.view.viewWithTag(element!) as? UILabel
            tmpButton!.text = formatterTimer
            print("\(formatterTimer)")
            labelLastClicked = 3
            
        default :
            break
            
        }
        
            dict[labelLastClicked]!["hours"] = hour
            dict[labelLastClicked]!["minutes"] = minute
        
        
        print(dict)
        saveToNSUserDefault()
        
        var change = false
        for index in 0...6 {
            if (dict[index]!["hours"] == -1){
                change = true
                break
            }
        }
        if change == false {
            doneSetUp.enabled = true;
        }
        

}
    
    func saveToNSUserDefault(){
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(dict)
        defaults.setObject(data, forKey: "Schedule")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.153, green: 0.192, blue: 0.247, alpha: 1.0);
        pickerSubView.hidden = true;
        timePicker.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
        if (defaults.objectForKey("HasLaunchedOnce") == nil){
            defaults.setBool(true, forKey: "HasLaunchedOnce") //FIRST TIME!
            doneSetUp.enabled = false
        }
        else{
            let data = defaults.objectForKey("Schedule") as? NSData!
            dict = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! [Int : Dictionary<String, Int>]
            var str = "";
            var ampm = ("AM","PM")
            for element in 10...16 {
                if element == 13 {
                    let tmpButton = self.view.viewWithTag(17) as? UILabel
                    
                    if dict[3]!["hours"]! > 12 {
                        if dict[3]!["minutes"]! < 10 {
                            str = "\(dict[3]!["hours"]! - 12):0\(dict[3]!["minutes"]!) \(ampm.1)"
                        }
                        else {
                            str = "\(dict[3]!["hours"]! - 12):\(dict[3]!["minutes"]!) \(ampm.1)"
                        }
                    }
                    else{
                        if dict[3]!["minutes"]! < 10 {
                            str = "\(dict[3]!["hours"]!):0\(dict[3]!["minutes"]!) \(ampm.0)"
                        }
                        else{
                            str = "\(dict[3]!["hours"]!):\(dict[3]!["minutes"]!) \(ampm.0)"
                        }
                    }
                    tmpButton!.text = str
                    
                    
                }
                else{
                   let tmpButton = self.view.viewWithTag(element) as? UILabel
                    if dict[element - 10]!["hours"]! > 12 {
                        if dict[element - 10]!["minutes"]! < 10{
                            str = "\(dict[element-10]!["hours"]! - 12):0\(dict[element-10]!["minutes"]!) \(ampm.1)"
                        }else{
                            str = "\(dict[element-10]!["hours"]! - 12):\(dict[element-10]!["minutes"]!) \(ampm.1)"
                        }
                    }
                    else{
                        if dict[element - 10]!["minutes"]! < 10{
                            str = "\(dict[element-10]!["hours"]!):0\(dict[element-10]!["minutes"]!) \(ampm.0)"
                        }
                        else{
                            str = "\(dict[element-10]!["hours"]!):\(dict[element-10]!["minutes"]!) \(ampm.0)"
                        }
                    }
                    tmpButton!.text = str
                }
                
                
                
            }
            
        }

        defaults.setBool(true, forKey: "HasLaunchedOnce")
        saveToNSUserDefault()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
