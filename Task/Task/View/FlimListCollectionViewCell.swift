//
//  FlimListCollectionViewCell.swift
//  Task
//
//  Created by Bala on 01/07/22.
//

import UIKit

class FlimListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView : UIView!
    @IBOutlet weak var imageviewPoster : UIImageView!
    @IBOutlet weak var labelTitle : UILabel!
    
    
    func cellConfigureForFlimList(element:Search){
        mainView.layer.borderColor = UIColor.gray.cgColor
        mainView.layer.borderWidth = 1.0
        if let urlString = element.poster{
            self.imageviewPoster.loadFrom(URLAddress: urlString)
        }
        self.labelTitle.text = element.title
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
