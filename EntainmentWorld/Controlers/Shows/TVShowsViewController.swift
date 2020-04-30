//
//  TVShowsViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 14/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
class TVShowsViewController: BaseViewController {
    var dataprovider: DataSourceProviderForTable!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BackGroundColor.getBackgrndClr() 
        SetupDataProviders()
    }
    
   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       //  navigationController?.navigationBar.topItem?.title = "Shows"
    }
    override func setUptable(){
           super.setUptable()
           table.register(UItableCell.self, forCellReuseIdentifier: Constants.TABLE_VIEW_CELL_IDENTIFIER)
       }
    func SetupDataProviders(){
        dataprovider = DataSourceProviderForTable()
        guard let dataprovider = dataprovider else{return}
        table.dataSource = dataprovider
        table.delegate  = dataprovider
        dataprovider.screenSegus = self
    }
}
extension TVShowsViewController : DoSegus {
    func LoadSegus(item : TVShows) {
        let detailVC = UIStoryboard(name: Constants.SHOW_DETAILS_STORYBOARD_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.SHOW_DETAILS_VIEW_CONTROLLER_IDENTIFIER) as! ItemDetailViewControllerForTable
        detailVC.item = item
        navigationController?.pushViewController(detailVC, animated: true)
    }


}
