//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Mohammed Hossain on 10/1/20.
//  Copyright © 2020 Mohammed Hossain. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Create rounded message bubble
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
