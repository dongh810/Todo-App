//
//  CustomCell.swift
//  Todo App
//
//  Created by 백동현 on 2022/07/12.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var head: UILabel!
    @IBOutlet weak var sub: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
