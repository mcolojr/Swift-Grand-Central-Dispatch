//
//  ViewController.swift
//  ColonnaMichael_GrandCentralDispatch
//
//  Created by Michael Colonna on 7/5/17.
//  Copyright © 2017 Michael Colonna. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    
    // array of image views
    var images = [UIImageView]()
    // array of urls
    var URLs = [String]()
    // array of Tuples (imageViews, Urls(Strings))
    var imagesAndUrls = [(UIImageView, String)]()
    
    // queues
    var mySerialQueue: DispatchQueue!
    var myCurrentQueue: DispatchQueue!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // populate images array
        images = [image1, image2, image3, image4, image5, image6, image7, image8]
        
        // populate URLs array
        URLs = ["https://bit.ly/2uOrlZU", "https://bit.ly/2sRmFkm", "https://bit.ly/2uP8my6", "https://bit.ly/2sRaNPp", "https://bit.ly/2tWcCiW", "https://bit.ly/2sRhsJu", "https://bit.ly/2sR0lY4", "https://bit.ly/2tuxvPf"]
        
        // setup Tuples array
        imagesAndUrls = [(images[0], URLs[0]), (images[1], URLs[1]), (images[2], URLs[2]), (images[3], URLs[3]), (images[4], URLs[4]), (images[5], URLs[5]), (images[6], URLs[6]), (images[7], URLs[7])]
        
        // set the queues
        mySerialQueue = DispatchQueue(label: "someUniqueStringGoesHere12353466356")
        myCurrentQueue = DispatchQueue(label: "someUniqueStringGoesHereAsWell09694303", attributes: .concurrent)
        
    }
    
    // button actions
    
    @IBAction func DownloadRegularButton(_ sender: UIButton) {
        
        for (image, urll) in imagesAndUrls {
            
            if let url = URL(string: urll) {
                
                if let data = try? Data(contentsOf: url) {
                    // url exists... successful data captured... populate image with data from url
                    image.image = UIImage(data: data)
                } else {
                    // broken url... no data... image will be nil
                    image.image = nil
                }
                
            }
        }
    }
    
    @IBAction func ClearAllButton(_ sender: UIButton) {
        // clear image views and set all images to nil
        for image in images {
            image.image = nil
        }
    }
    
    @IBAction func DownloadSerialButton(_ sender: UIButton) {
        
        for (image, urll) in imagesAndUrls {
            
            mySerialQueue.async { // dispatch to new Queue
                
                if let url = URL(string: urll) {
                    
                    if let data = try? Data(contentsOf: url) {
                        // url exists... successful data captured... populate image with data from url
                        DispatchQueue.main.async() {
                            image.image = UIImage(data: data)
                        }
                    } else {
                        // broken url... no data... image will be nil
                        DispatchQueue.main.async() {
                        image.image = nil
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func DownloadConcurrentButton(_ sender: UIButton) {
        
        for (image, urll) in imagesAndUrls {
            
            myCurrentQueue.async { // dispatch to new Queue
                
                if let url = URL(string: urll) {
                    
                    if let data = try? Data(contentsOf: url) {
                        // url exists... successful data captured... populate image with data from url
                        DispatchQueue.main.async() {
                            image.image = UIImage(data: data)
                        }
                    } else {
                        // broken url... no data... image will be nil
                        DispatchQueue.main.async() {
                            image.image = nil
                        }
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}



