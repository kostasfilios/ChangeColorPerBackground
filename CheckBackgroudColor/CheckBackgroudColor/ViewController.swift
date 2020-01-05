//
//  ViewController.swift
//  CheckBackgroudColor
//
//  Created by Kostas Filios on 5/1/20.
//  Copyright © 2020 Kostas Filios. All rights reserved.
//

import UIKit

final class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var closeButton: UIButton!
    private var cropArea:CGRect{
        get{
            let scale = 1/scrollView.zoomScale
            let imageFrame = imageView.imageFrame()
            let x = (scrollView.contentOffset.x + closeButton.frame.origin.x - imageFrame.origin.x) * scale
            let y = (scrollView.contentOffset.y + closeButton.frame.origin.y - imageFrame.origin.y) * scale
            let width = closeButton.frame.size.width * scale
            let height = closeButton.frame.size.height * scale
            return CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "download")
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
      return imageView
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        stopScrolling(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        stopScrolling(scrollView)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        print("Close Tapped")
        let croppedCGImage = imageView.image?.cgImage?.cropping(to: cropArea)
        let croppedImage = UIImage(cgImage: croppedCGImage!)
        imageView.image = croppedImage
        scrollView.zoomScale = 1
    }
    
    private func stopScrolling(_ scrollView: UIScrollView) {
        print("Scrolling finish")
        guard let croppedCGImage = imageView.image?.cgImage?.cropping(to: cropArea) else {
            return
        }
        let croppedImage = UIImage(cgImage: croppedCGImage)
        closeButton.setTitleColor(croppedImage.averageColor()?.inverse(), for: .normal) 
    }
}

