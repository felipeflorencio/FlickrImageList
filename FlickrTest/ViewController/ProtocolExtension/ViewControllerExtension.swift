//
//  ViewControllerExtension.swift
//  FlickrTest
//
//  Created by Felipe Florencio Garcia on 5/9/16.
//  Copyright © 2016 Felipe Florencio Garcia. All rights reserved.
//

import Foundation
import UIKit


// Here we can make our view controller smallest and readable 
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    //    MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //        We use that for get last table view and make a new data request
        if (indexPath.row == self.flickrImageData.count - 1) {
            self.loadListData((self.photoInfoModel?.page)! + 1)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.flickrImageData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellImage = tableView.dequeueReusableCellWithIdentifier("FlickrImageViewCell", forIndexPath: indexPath) as! FlickrImageViewCell
        
        cellImage.loaderIndicator.startAnimating()
        
        //        Not best, but is one way for avoid to much request, its a cache
        if (self.imageListCache.indexForKey(indexPath.row) != nil) {
            cellImage.loaderIndicator.stopAnimating()
            cellImage.imagePartyView.image = self.imageListCache[indexPath.row]
        } else {
            
            // Little trick for avoid "wrong image" while not loaded ;)
            cellImage.imagePartyView.alpha = 0
            
            self.managerData.getFlickrPartyImage(self.flickrImageData[indexPath.row], responseData: { [weak self] (flickrImageData, status) in
                
                if status {
                    
                    //                    Need do that for avoid layout error trying update at background thread!
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        // Little trick for avoid "wrong image" while not loaded ;)
                        cellImage.imagePartyView.alpha = 1
                        
                        let image = UIImage(data: flickrImageData!)
                        cellImage.imagePartyView.image = image
                        
                        self?.imageListCache[indexPath.row] = image! //append(image!)
                        
                        self?.tableView.beginUpdates()
                        self?.tableView.reloadRowsAtIndexPaths(
                            [indexPath],
                            withRowAnimation: .Fade)
                        self?.tableView.endUpdates()
                        
                        cellImage.loaderIndicator.stopAnimating()
                        
                    })
                    
                }
                
                
                })
        }
        
        return cellImage
    }
    
    //    MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 289
    }
    
}