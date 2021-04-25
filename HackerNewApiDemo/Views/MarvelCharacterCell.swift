//
//  NewsArticleListCellTableViewCell.swift
//  HackerNewApiDemo
//
//  Created by jyothish.johnson on 26/03/21.
//

import UIKit
import SDWebImage

class MarvelCharacterCell: UITableViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    var imageURL : String? {
        didSet {
            characterImage.sd_setImage(with: URL(string: imageURL ?? ""), placeholderImage: nil)
        }
    }
    var characterName : String? {
        didSet {
            characterNameLabel.text = characterName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        characterImage.layer.cornerRadius = 8
    }
    
    override func prepareForReuse() {
        self.accessoryType = .none
    }
    
}
