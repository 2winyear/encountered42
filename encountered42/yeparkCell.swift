//
//  yeparkCell.swift
//  encountered42
//
//  Created by 박영광 on 2020/12/18.
//  Copyright © 2020 박영광. All rights reserved.
//

import UIKit

class yeparkCell: UITableViewCell {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func makeYeparkCell(info: Welcome) {
        firstLabel.text = info.comment
        secondLabel.text = info.feedback
    }
}
