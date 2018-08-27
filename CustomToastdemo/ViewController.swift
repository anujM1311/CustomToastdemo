//
//  ViewController.swift
//  CustomToastdemo
//
//  Created by Vikash Kumar Sahu on 21/08/18.
//  Copyright © 2018 Vikash Kumar Sahu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickButton()
    {
        self.view.showToast(toastMessage: "Please Enter Password ", duration: 1)
        self.view.showToast(toastMessage: "Please Enter Password. this is my server side error 2line.", duration: 10)
    }


}

