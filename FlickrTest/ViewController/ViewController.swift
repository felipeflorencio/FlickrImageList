//
//  ViewController.swift
//  FlickrTest
//
//  Created by Felipe Florencio Garcia on 5/1/16.
//  Copyright © 2016 Felipe Florencio Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let managerData = FlickrManager()
    
    var photoInfoModel: PhotoInfoModel? = nil
    
    var flickrImageData: Array<PhotoModel> = []
    
    var imageListCache: Dictionary<Int,UIImage> = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadListData(nil)
        
    }
    //    This is here because we need some access and manage little thinks inside my view controller
    //    like my table view, otherwise this should be at business class
    func loadListData(page: Int?) {
        self.managerData.requestFlickrPartyImagesList(page) { [weak self] (flickrData, status) in
            
            if status {
                self?.photoInfoModel = flickrData
                
                // Little trick for continuous up page number
                if (flickrData!.page > 1){
                    self?.flickrImageData += (flickrData?.photo)!
                } else {
                    self?.flickrImageData = (flickrData?.photo)!
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self!.tableView.reloadData()
                })
            }
            
        }
    }
    
}

