//
//  photoTableViewCell.swift
//  iOSCodingChallenge
//
//  Created by Hamza Iqbal on 06/09/2021.
//

import UIKit

class photoTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
