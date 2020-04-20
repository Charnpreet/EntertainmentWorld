//
//  BottomSheetViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 18/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class BottomSheetViewController: UIViewController {
    let fullView: CGFloat = 10
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 80
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(BottomSheetViewController.panGesture))
        view.addGestureRecognizer(gesture)
        // Do any additional setup after loading the view.
    }
    
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
              let velocity = recognizer.velocity(in: self.view)
              let y = self.view.frame.minY
              if (y + translation.y >= fullView) && (y + translation.y <= partialView) {
                  self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
                  recognizer.setTranslation(CGPoint.zero, in: self.view)
              }
              
              if recognizer.state == .ended {
                  var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )

                  duration = duration > 1.3 ? 1 : duration

                  UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                      if  velocity.y >= 0 {
                          self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                      } else {
                          self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                      }

                      }, completion: { [weak self] _ in
                          if ( velocity.y < 0 ) {
                             // self?.tableView.isScrollEnabled = true
                           // self?.navigationController?.navigationBar.isTranslucent = false

                          }
                  })
              }
        
        
    }
    
    func prepareBackgroundView(){
        //view.backgroundColor = .clear
        let blurEffect = UIBlurEffect.init(style: .systemThinMaterialDark)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        
        view.insertSubview(bluredView, at: 0)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.tabBarController?.tabBar.isHidden = true
        prepareBackgroundView()
        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame
            let yComponent = self?.partialView
            self?.view.frame = CGRect(x: 0, y: yComponent!, width: frame!.width, height: frame!.height-100)
        }
    }
       override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)

       }
       override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
            self.tabBarController?.tabBar.isHidden = false
       }
}
