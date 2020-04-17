//
//  itemDetailSegus.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 12/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class itemDetailSegus: UIStoryboardSegue {
    override func perform() {
           ShowSegues()
       }
      // it display segues screen
      // has some animations
      func ShowSegues(){
          let destiNationViewController = self.destination
          let sourceViewController = self.source
          let ContainerView = sourceViewController.view.superview
          let originalCenter = sourceViewController.view.center
          destiNationViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
          destiNationViewController.view.center = originalCenter
          ContainerView?.addSubview(destiNationViewController.view)
          UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
              destiNationViewController.view.transform = CGAffineTransform.identity
          }, completion: {success in sourceViewController.present(destiNationViewController, animated: false, completion: nil)})
      }
}
