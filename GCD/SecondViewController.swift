//
//  SecondViewController.swift
//  GCD
//
//  Created by Лера Тарасенко on 19.09.2020.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        
        set {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            //return to main queue
            DispatchQueue.main.async {
                
                self.image = UIImage(data: imageData)
            }
        }
    }
}
