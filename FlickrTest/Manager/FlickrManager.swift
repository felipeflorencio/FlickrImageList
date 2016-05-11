//
//  FlickrManager.swift
//  FlickrTest
//
//  Created by Felipe Florencio Garcia on 5/7/16.
//  Copyright © 2016 Felipe Florencio Garcia. All rights reserved.
//

import Foundation


//  Its a good practice we have some think like interface, so my view controller
//  don't know nothing about my view and vice versa, all stay clean :)
class FlickrManager: NSObject {
    
    private let business = FlickrInfoBusiness()
    
    func requestFlickrPartyImagesList(page: Int?, responseData: FlickrPartyResponse) -> Void {
        
        self.business.flickrPartyData(page, response: responseData)
    }
    
    func getFlickrPartyImage(photoData: PhotoModel, responseData: FlickrImageResponse) -> Void {
        
        self.business.flickrPhotoImage(photoData, response: responseData)
    }
    
}