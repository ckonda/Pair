//
//  Extensions.swift
//  Pair
//
//  Created by Chatan Konda on 5/2/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView{
    
    func loadImageUsingCacheWithUrlString(urlString: String){
        
        self.image = nil
        
        //check cache for an image first
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject){
            self.image = (cachedImage as! UIImage)
            
            return
        }
        //otherwise download another image
        
        let url = URL(string: urlString)
        print("before")
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil{
                print(error!)//download hit error so return out
            }
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!){
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    
                    self.image = downloadedImage
                }
                
    
            })
        }).resume()
        
        
    }
    
    
}
