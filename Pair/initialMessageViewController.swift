//
//  initialMessageViewController.swift
//  Pair
//
//  Created by Chatan Konda on 4/27/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class initialMessageViewController: UIViewController {

    var user1ID: String?
    var user2ID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user1ID)
        print(user2ID)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
