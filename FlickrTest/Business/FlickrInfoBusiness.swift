//
//  FlickrInfoBusiness.swift
//  FlickrTest
//
//  Created by Felipe Florencio Garcia on 5/7/16.
//  Copyright © 2016 Felipe Florencio Garcia. All rights reserved.
//
//  Here is where all business logic come 

import Foundation

typealias FlickrPartyResponse = (flickrData: PhotoInfoModel?, status: Bool) -> ()
typealias FlickrImageResponse = (flickrImageData: NSData?, status: Bool) -> ()

class FlickrInfoBusiness: NSObject {
    
    // A way for pattern error throw
    enum ParseError: ErrorType {
        case Empty
        case KeyParse
        case Aware(String)
    }
    
    // Made constant, for this kind of 'app' we will not change,
    // but its a important part of request, so is best do this way
    // for future manager
    let itensPerPage = "10"
    
    
    // Here we can get our list of images party
    func flickrPartyData(page: Int?, response: FlickrPartyResponse) -> Void {
        
        let pageNumber = (page != nil) ? "\(page!)" : "1"
        
        //        We hard-coded our "tag" but we easily make a parameter and "ta-da" search
        //        for any think we and, just a small change 
        let urlRequestWithTag = "https://\(EnviromentUtil().baseUrl!)&tags=Party&per_page=\(itensPerPage)&page=\(pageNumber)"
        
        let urlRequest = NSURLRequest(URL: NSURL(string: urlRequestWithTag)!)
        
        APIConnection.get(urlRequest) { (success, failure) in
            
            if let _ = success {
                
                do {
                    
                    let JSON = try NSJSONSerialization.JSONObjectWithData(success!, options:NSJSONReadingOptions(rawValue: 0))
                    guard let JSONDictionary :NSDictionary = JSON as? NSDictionary else {
                        print("Not a Dictionary, an error happened")
                        return
                    }
                    
                    let dataParsed = try! self.parsePhotoListData(JSONDictionary)
                    
                    response(flickrData: dataParsed, status: true)
                    
                }
                catch let JSONError as NSError {
                    print("\(JSONError)")
                }
                
            } else {
                response(flickrData: nil, status: false)
            }
            
        }
        
    }
    
    
    // Here is the method for get image
    func flickrPhotoImage(photoData: PhotoModel, response: FlickrImageResponse) -> Void {
        
        let urlFormated = "https://farm\(photoData.farm).staticflickr.com/\(photoData.server)/\(photoData.id)_\(photoData.secret).jpg"
        
        let urlRequest = NSURLRequest(URL: NSURL(string: urlFormated)!)
        
        APIConnection.get(urlRequest) { (success, failure) in
            
            if let _ = success {
                
                response(flickrImageData: success, status: true)
            } else {
                response(flickrImageData: nil, status: false)
            }
            
        }
        
    }
    
    
    // MARK: - Parse Helper
    // TODO: - Throw error to a handle class or similar, for now just "try!"
    
    // This is a ugly way, we have good libs to do this, but here we 
    // can show some good practice to validate and maybe handle error
    private func parsePhotoListData(photoData: NSDictionary) throws -> PhotoInfoModel {
        
        guard photoData["photos"] != nil else {
            throw ParseError.Empty
        }
        
        guard photoData["photos"]!["photo"] != nil else {
            throw ParseError.Empty
        }
        
        let photosArray: Array = (photoData["photos"]!["photo"] as? Array<Dictionary<String,AnyObject>>)!
        
        guard photosArray.count != 0 else {
            throw ParseError.Empty
        }
        
        var parsedArrayPhoto = Array<PhotoModel>()
        
        for dt in photosArray {
            
            guard dt["id"] != nil else {
                throw ParseError.KeyParse
            }
            
            guard dt["owner"] != nil else {
                throw ParseError.KeyParse
            }
            
            guard dt["secret"] != nil else {
                throw ParseError.KeyParse
            }
            
            guard dt["server"] != nil else {
                throw ParseError.KeyParse
            }
            
            guard dt["farm"] != nil else {
                throw ParseError.KeyParse
            }
            
            guard dt["title"] != nil else {
                throw ParseError.KeyParse
            }
            
            let model = PhotoModel(id: dt["id"] as! String, owner: dt["owner"] as! String, secret: dt["secret"] as! String, server: dt["server"] as! String, farm: dt["farm"] as! Int, title: dt["title"] as! String)
            
            parsedArrayPhoto.append(model)
            
        }
        
        let photosInfo: Dictionary<String,AnyObject> = photoData["photos"] as! Dictionary<String,AnyObject>
        
        guard photosInfo["page"] != nil else {
            throw ParseError.KeyParse
        }
        
        guard photosInfo["pages"] != nil else {
            throw ParseError.KeyParse
        }
        
        guard photosInfo["perpage"] != nil else {
            throw ParseError.KeyParse
        }
        
        guard photosInfo["total"] != nil else {
            throw ParseError.KeyParse
        }
        
        let photoModelInfo = PhotoInfoModel(page: photosInfo["page"] as! Int, pages: photosInfo["pages"] as! Int, perpage: photosInfo["perpage"] as! Int, total: photosInfo["total"] as! Int, photo: parsedArrayPhoto)
        
        return photoModelInfo
        
    }
    
}