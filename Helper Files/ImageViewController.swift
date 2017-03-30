//
//  ImageViewController.swift
//  
//
//  Created by admin on 3/30/17.
//
//

import UIKit

class ImageViewController: UIViewController
{
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {     // on screen?
                fetchImage()
            }
        }
    }
    
    
    fileprivate var imageView = UIImageView()
    
    private func fetchImage() {
        if  let url = imageURL, let urlContents = try? Data(contentsOf: url) {
            image = UIImage(data: urlContents)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageURL = URL(String:"https://i.ytimg.com/vi/b9q6X0RARtk/maxresdefault.jpg")//Put your URL here!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 3.0
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
        }
    }
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }
}

extension ImageViewController:  UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
