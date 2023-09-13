//
//  JokeListingTableViewCell.swift
//  JokeListing
//
//  Created by Anushka Tripathi on 11/09/23.
//

import UIKit

class JokeListingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var jokeName: UILabel!
    @IBOutlet weak var jokeTime: UILabel!
    @IBOutlet weak var backgroundVC: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundVC.layer.cornerRadius = 7
        self.backgroundVC.layer.masksToBounds = true
        
    }
    
}
