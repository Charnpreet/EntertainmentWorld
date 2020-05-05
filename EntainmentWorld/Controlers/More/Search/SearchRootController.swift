//
//  SearchRootController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 4/5/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
class SearchRootController<T: Hashable> : RootControllerWithUICollectionView<T>{
    
    var searchTextField : UISearchTextField!
    var text_To_search : String?
    var curentPage: Int = 1
    var totalPages: Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField  = setUpSearchTextField()
        navigationController?.navigationBar.addSubview(self.searchTextField)
        self.view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
    }
    //
    //
    public func setUpSearchTextField() -> UISearchTextField{
        let  searchTextField = Shared.setUpSearchTextField(text: "Search TV Shows")
        return searchTextField
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
        guard let searchTextField = searchTextField else {return}
        searchTextField.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
        guard let searchTextField = searchTextField else {return}
        searchTextField.isHidden = true
    }
}
