//
//  AdvertTableViewCell.swift
//  PetSearchIosApp
//
//  Created by Andrei Poliakov on 14.05.2019.
//  Copyright © 2019 Andrei Poliakov. All rights reserved.
//

import UIKit

class AdvertTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var advertImageView: UIImageView!
    
    @IBOutlet weak var saveOfflineBtn: UIImageView!
    
    @IBOutlet weak var advertDescriptionTextView: UITextView!
    
    @IBOutlet weak var advertTitleLabel: UILabel!
    
    var model:Advert?
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        persistAdvert(nil)
        // Your action
    }
    
    func persistAdvert(_ sender: Any?) {
        if RealmHelper.isAdvertSavedLocal((model?.id)!) {
            RealmHelper.deleteAdvert(model!)
            NotificationCenter.default.post(name: Notification.Name("ReceiveData"), object: nil)
            let image : UIImage  = #imageLiteral(resourceName: "save_offline")
            saveOfflineBtn.image = image
        } else {
            RealmHelper.saveAdvert(model!)
            let image : UIImage  = #imageLiteral(resourceName: "trash")
            saveOfflineBtn.image = image
        }
    }
    
    func setup(from advert: Advert) {
        if let decodedData = Data(base64Encoded: advert.image, options: .ignoreUnknownCharacters) {
            let image = UIImage(data: decodedData)
            self.advertImageView.image = image
        }
        self.advertDescriptionTextView.text = StringUtils.truncate(advert.descr, length: 255)
        self.advertTitleLabel.text = StringUtils.truncate(advert.title, length: 30)
        self.model = advert
        
        if RealmHelper.isAdvertSavedLocal((model?.id)!) {
            let image : UIImage  = #imageLiteral(resourceName: "trash")
            saveOfflineBtn.image = image
        } else {
            let image : UIImage  = #imageLiteral(resourceName: "save_offline")
            saveOfflineBtn.image = image
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        saveOfflineBtn.isUserInteractionEnabled = true
        saveOfflineBtn.addGestureRecognizer(tapGestureRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
