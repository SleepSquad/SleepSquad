//
//  setupViewController.swift
//  SleepSquad
//
//  Created by Arturo Esquivel on 1/23/16.
//  Copyright © 2016 SleepSquad. All rights reserved.
//

import UIKit

class setupViewController: UIViewController {
    
    @IBOutlet weak var mondayTime: UILabel!
    @IBOutlet weak var tuesdayTime: UILabel!
    @IBOutlet weak var wedsTime: UILabel!
    @IBOutlet weak var thursTime: UILabel!
    @IBOutlet weak var friTime: UILabel!
    @IBOutlet weak var satTime: UILabel!
    @IBOutlet weak var sunTime: UILabel!
    
    var labelLastClicked : Int = -1
    var element : Int?
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var pickerSubView: UIView!
    
    @IBAction func doneWithPicker(sender: AnyObject) {
        if pickerSubView.hidden == false {
            pickerSubView.hidden = true;
        }
        else {
            pickerSubView.hidden = false;
        }
    }
    
    @IBAction func dateButtonTouch(sender: UIButton) {
        print(sender.tag)
        labelLastClicked = sender.tag
        
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
            
        case labelLastClicked == 7 :
            element = 17
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
            
        default : break
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerSubView.hidden = true;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
