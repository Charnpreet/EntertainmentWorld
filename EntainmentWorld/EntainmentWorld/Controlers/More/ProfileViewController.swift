//
//  ProfileViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 7/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var profileImage : UIImageView!
    var signoutButton : UIButton!
    var label: CustomUILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        InitSetup()
        let frame = Constants.DARK_MODE_UI_LABEL_FRAME
        label = CustomUILabel(frame: frame)
        label.text = Constants.DARK_MODE_UI_LABEL_TEXT
        self.view.addSubview(label)
        // Do any additional setup after loading the view.
    }
    func createSwitch(){
        let frame = Constants.DARK_MODE_SWITCH_FRAME
        let swtich = UISwitch(frame: frame)
        self.view.addSubview(swtich)
    }
    func addconstrainstToProfileButton(){
        signoutButton.translatesAutoresizingMaskIntoConstraints = false
        signoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signoutButton.widthAnchor.constraint(equalToConstant: Constants.IOS_SCREEN_WIDTH-40).isActive = true
        signoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    func setupButton(){
        signoutButton =  customButtons.getUIButton(title: "Sign Out", bColor: UIColor.systemBlue)
        view.addSubview(signoutButton)
        addconstrainstToProfileButton()
    }
    func setupProfileImage(){
        let frame = Constants.PROFILE_IMAGE_FRAME
        profileImage =  customUIImage.getRoundedImageView(frame: frame)
        profileImage.image = UIImage(named: "img1") // replace with profile image
        view.addSubview(profileImage)
    }
    func InitSetup(){
        setupProfileImage()
        setupButton()
        createSwitch()
    }
    
    // add constrints to the image
    func addConstraintsToImage(){
        
    }

}
