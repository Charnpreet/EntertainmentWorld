//
//  ViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 7/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    @IBOutlet var profileButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var movieButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginButton.isHidden = false
        customButtons.styleForButtons(button: movieButton)
        customButtons.styleForButtons(button: loginButton)
        customButtons.styleForButtons(button: profileButton)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
   
}

