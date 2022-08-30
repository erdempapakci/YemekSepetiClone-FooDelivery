//
//  SlideOutTableViewCell.swift
//  YemekSepetiClone
//
//  Created by Erdem Papakçı on 23.08.2022.
//

import UIKit


class SlideOutTableViewCell: BaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

