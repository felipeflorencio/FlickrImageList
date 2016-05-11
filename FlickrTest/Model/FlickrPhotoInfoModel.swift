//
//  FlickrPhotoInfoModel.swift
//  FlickrTest
//
//  Created by Felipe Florencio Garcia on 5/10/16.
//  Copyright © 2016 Felipe Florencio Garcia. All rights reserved.
//

import Foundation

// Our model, don't need say why Struct ;)
struct PhotoInfoModel {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: Array<PhotoModel>
}