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
    
    override func viewDidLoad() {
        super.viewDidLoad();
        timePicker.datePickerMode = UIDatePickerMode.Time;
        setTimeUntil();
        self.view.backgroundColor = UIColor(red: 0.153, green: 0.192, blue: 0.247, alpha: 1.0);
        
        // Do any additional setup after loading the view, typically from a nib.
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


}

