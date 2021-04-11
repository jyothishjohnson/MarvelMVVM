//
//  LoadingCell.swift
//  HackerNewApiDemo
//
//  Created by jyothish.johnson on 11/04/21.
//

import UIKit

class LoadingCell: UITableViewCell {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var isLoading : Bool? {
        didSet {
            if isLoading ?? false {
                loadingIndicator.startAnimating()
            }
            else {
                loadingIndicator.stopAnimating()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
