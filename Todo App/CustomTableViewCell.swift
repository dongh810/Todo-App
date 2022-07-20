//
//  CustomTableViewCell.swift
//  Todo App
//
//  Created by 백동현 on 2022/07/17.
//
import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {

   
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var head: UILabel!
    @IBOutlet weak var blueImg: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
