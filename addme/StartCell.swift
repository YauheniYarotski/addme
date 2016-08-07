//
//  StartCell.swift
//  addme
//
//  Created by Evgeniy Demeshkevich on 07.08.16.
//  Copyright © 2016 Yauheni Yarotski. All rights reserved.
//

import UIKit

class StartCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var descriptionName: UILabel!
    @IBOutlet weak var name: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
