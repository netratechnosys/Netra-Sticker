//
//  InfoViewController.swift
//  The Pomegranate
//
//  Created by Developer 3 on 11/01/19.
//  Copyright © 2019 NetraTechnosys. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnDonePressed(_ sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }

}
