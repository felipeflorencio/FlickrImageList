//
//  FlickrImageViewCell.swift
//  FlickrTest
//
//  Created by Felipe Florencio Garcia on 5/9/16.
//  Copyright © 2016 Felipe Florencio Garcia. All rights reserved.
//

import Foundation
import UIKit

class FlickrImageViewCell: UITableViewCell {
    
    @IBOutlet var imagePartyView: UIImageView!
    
    @IBOutlet var loaderIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        //        We need do that because we can handle at storyboard our indicator size
        loaderIndicator.transform = CGAffineTransformMakeScale(1.5, 1.5)
        loaderIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        loaderIndicator.color = UIColor.blueColor()
        loaderIndicator.hidesWhenStopped = true
    }
    
}