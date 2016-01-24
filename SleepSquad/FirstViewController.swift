//
//  FirstViewController.swift
//  SleepSquad
//
//  Created by Agustin Malo  on 1/23/16.
//  Copyright © 2016 SleepSquad. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var timeLeft: UILabel!
    
    var defaults: NSUserDefaults = NSUserDefaults(suiteName: "group.com.SleepSquad.app")!
    
//    let dict = ["Monday": (hour: 8, min: 27, ampm: "AM"), "Tuesday": (hour: 8, min: 27, ampm: "AM"), "Wednesday": (hour: 8, min: 27, ampm: "AM"), "Thursday": (hour: 8, min: 27, ampm: "AM"), "Friday": (hour: 8, min: 27, ampm: "AM"), "Saturday": (hour: 8, min: 27, ampm: "AM"), "Sunday": (hour: 8, min: 27, ampm: "AM")]
    
    let dict =
        ["Monday": ["hours": 7, "minutes": 4, "ampm": "AM"],
        "Tuesday": ["hours": 7, "minutes": 4, "ampm": "AM"],
        "Wednesday": ["hours": 7, "minutes": 4, "ampm": "AM"],
        "Thursday": ["hours": 7, "minutes": 4, "ampm": "AM"],
        "Friday": ["hours": 7, "minutes": 4, "ampm": "AM"],
        "Saturday": ["hours": 7, "minutes": 4, "ampm": "AM"],
        "Sunday": ["hours": 7, "minutes": 4, "ampm": "AM"]]
    
    
    
    @IBAction func changeTimeLeft(sender: AnyObject) {
        
        timeLeft.text = "fsafdsbkdsgdgf"
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        defaults.setObject(dict, forKey: "SavedDict")
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

