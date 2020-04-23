//
//  LoginViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 7/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
import WebKit
class LoginViewController: UIViewController {
    let cp = CircularAnimationView(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
    fileprivate var label = CustomUILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    @IBOutlet var webViewKit: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        // Do any additional setup after loading the view.
        setup()
    }
    // setuping up webview with custom URL
    func loadWebView(){
        let url = URL(string: Constants.WEBVIEW_LOGINSCREEN_URL)
        let urlRequest = URLRequest(url: url!)
        webViewKit.load(urlRequest)
        webViewKit.addObserver(self, forKeyPath: Constants.WEBVIEW_KEYPATH, options: .new, context: nil)
        webViewKit.navigationDelegate = self
    }
    
    func LoadCircularAnimation(){
        cp.progressColor =  .systemPink
        view.addSubview(cp)
        cp.center = view.center
    }
    func loadLabel(){
        label.text  = ""
        label.layer.borderWidth = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        view.addSubview(label)
        label.center = view.center
    }
    func setup(){
        loadLabel()
        LoadCircularAnimation()
        loadWebView()
    }
}



extension LoginViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        cp.isHidden = true
        label.isHidden = true
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        cp.progress.strokeEnd = 0.0
        cp.LoadingBarAnimation(toValue: 0.8)
        
        // pulsing is not working as expected
        //cp.pulsatingAnimation()

    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == Constants.WEBVIEW_KEYPATH {
            label.text = "\(Int(self.webViewKit.estimatedProgress * 100))%"
            cp.progress.strokeEnd = CGFloat(self.webViewKit.estimatedProgress)
            
        }
    }
}
