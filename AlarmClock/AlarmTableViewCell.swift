//
//  AlarmTableViewCell.swift
//  AlarmClock
//
//  Created by Ben Shockley on 10/25/16.
//  Copyright © 2016 Ben Shockley. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {

    
    @IBOutlet weak var alarmTimeLable: UILabel!
    @IBOutlet weak var soundClipLabel: UILabel!
    @IBOutlet weak var alarmRepeatInfoLabel: UILabel!
    @IBOutlet weak var alarmActivatedSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
