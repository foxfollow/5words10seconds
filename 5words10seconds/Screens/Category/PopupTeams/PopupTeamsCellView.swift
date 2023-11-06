//
//  miniTeamsCellView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 06.11.2023.
//

import UIKit

class PopupTeamsCellView: UITableViewCell {
    
    let teamNameLbl = UILabel()
    let scoreLbl = UILabel()
    let incrementBtn = UIButton()
    let decrementBtn = UIButton()
    
    var teamViewModel: PopupTeamsViewModel? {
        didSet {
            guard let teamViewModel = teamViewModel else { return }
            teamNameLbl.text = teamViewModel.team.value.name // think if need to bind
            teamViewModel.team.bind { [weak self] team in
                self?.scoreLbl.text = "\(team.score)"
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupButtons()
        
        addSubview(teamNameLbl)
        addSubview(scoreLbl)
        addSubview(incrementBtn)
        addSubview(decrementBtn)
        
        addConstraints()
        // TODO: Set up constraints for your labels and buttons
        // TODO: Add target actions for your buttons
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButtons() {
        incrementBtn.setTitle("-", for: .normal)
        decrementBtn.backgroundColor = .brown
    }
}

extension PopupTeamsCellView {
    
    private func addConstraints() {
        teamNameLbl.translatesAutoresizingMaskIntoConstraints = false
        scoreLbl.translatesAutoresizingMaskIntoConstraints = false
        incrementBtn.translatesAutoresizingMaskIntoConstraints = false
        decrementBtn.translatesAutoresizingMaskIntoConstraints = false
        
//        let sALG = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            teamNameLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            teamNameLbl.leftAnchor.constraint(equalTo: self.leftAnchor),
            
            scoreLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            scoreLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            incrementBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            incrementBtn.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            decrementBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            decrementBtn.rightAnchor.constraint(equalTo: incrementBtn.leftAnchor),

        ])
    }
}
