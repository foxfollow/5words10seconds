//
//  TeamsCellView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 02.11.2023.
//

import UIKit

enum cellsIdentifiers: String {
    case TeamsCellView
}

class TeamsCellView: UITableViewCell {
    
    let teamNameLbl = UILabel()
    private let crossImg = UILabel()    // TODO: make it crossmark button to delete teams
    
    let cellView = UILabel()
    
    var cellViewModel: TeamModel? {     // TODO: remake to use ViewModel not Model
        didSet {
            teamNameLbl.text = cellViewModel?.name
//            nameLabel.text = cellViewModel?.score
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubviews()
    }
    
    private func setupSubviews() {
//                contentView.backgroundColor = #colorLiteral(red: 0.7862124443, green: 0.9268439412, blue: 1, alpha: 1)
        let cellHeight: CGFloat = 48

        cellView.frame = CGRect(x: 8, y: 4, width: contentView.bounds.width - 16, height: cellHeight)

        crossImg.frame = CGRect(x: 8, y: 10, width: cellHeight - 20, height: cellHeight - 20)
        crossImg.contentMode = .scaleAspectFit
        crossImg.clipsToBounds = true

        teamNameLbl.frame = CGRect(
            x:  crossImg.bounds.width + 16,
            y: 4,
            width: cellView.bounds.width - 80,
            height: cellHeight - 8)
        teamNameLbl.font = .systemFont(ofSize: 18)
        teamNameLbl.textColor = .darkText
//        teamNameLbl.textAlignment = .natural
        teamNameLbl.isUserInteractionEnabled = false
//        teamNameLbl.numberOfLines = 0
        
        contentView.addSubview(cellView)
        
        cellView.addSubview(teamNameLbl)
        cellView.addSubview(crossImg)
        
    }

}
