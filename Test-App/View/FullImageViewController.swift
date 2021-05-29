//
//  FullImageViewController.swift
//  Test-App
//
//  Created by Adnann Muratovic on 06.04.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import UIKit

class FullImageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var selecedImage: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareSaveImages))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePhotos))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        let imageURL = NSURL(string: self.selecedImage)
        let imageData = NSData(contentsOf: imageURL! as URL)
        
        self.imageView.image = UIImage(data: imageData! as Data)
        
    }
    
    // MARK: - Share Photos
    @objc private func shareSaveImages() {
        guard let imageURL = NSURL(string: self.selecedImage) else  { return }
        
        let ac = UIActivityViewController(activityItems: [imageURL], applicationActivities: nil)
        present(ac, animated: true)
    }
    
    // MARK: - Save Photos
    @IBAction func savePhotos(_ sender: Any) {
        guard let image = imageView.image else {
            let ac = UIAlertController(title: "Error", message: "No image selected", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
        } else {
            let ac = UIAlertController(title: "Saved", message: "Your image has been saved to your photos.Enjoy!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
