//
//  FlickrPhotoModel.swift
//  FlickrTest
//
//  Created by Felipe Florencio Garcia on 5/8/16.
//  Copyright © 2016 Felipe Florencio Garcia. All rights reserved.
//

import Foundation

// Our model, don't need say why Struct ;)
struct PhotoModel {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
}