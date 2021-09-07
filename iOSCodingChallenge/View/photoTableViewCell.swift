//
//  photoTableViewCell.swift
//  iOSCodingChallenge
//
//  Created by Farid Afzal on 06/09/2021.
//

import UIKit

class photoTableViewCell: UITableViewCell {

    // Outlets
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
