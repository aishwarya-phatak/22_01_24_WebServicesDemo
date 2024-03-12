//
//  PostTableViewCell.swift
//  22_01_24_WebServicesDemo
//
//  Created by Vishal Jagtap on 12/03/24.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
