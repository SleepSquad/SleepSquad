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
    
    @IBAction func changeTimeLeft(sender: AnyObject) {
        
        timeLeft.text = "fsafdsbkdsgdgf"
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

