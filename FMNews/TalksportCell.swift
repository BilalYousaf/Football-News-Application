//
//  TalksportCell.swift
//  FM

//  Created by Dione on 05/01/2018.
//  Copyright © 2018 Dione. All rights reserved.


import UIKit

class TalksportCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var PictureView: UIImageView!
    
    
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
