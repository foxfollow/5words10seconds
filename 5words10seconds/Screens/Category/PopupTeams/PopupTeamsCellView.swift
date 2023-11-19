////
////  miniTeamsCellView.swift
////  5words10seconds
////
////  Created by Heorhii Savoiskyi on 06.11.2023.
////
//
//import UIKit
//
//class PopupTeamsCellView: UITableViewCell {
//    
//    let teamNameLbl = UILabel()
//    let scoreLbl = UILabel()
//    let incrementBtn = UIButton()
//    let decrementBtn = UIButton()
//    
//    var popupTeamViewModel: PopupTeamsViewModel? {
//        didSet {
//            guard let teamViewModel = popupTeamViewModel else { return }
//            teamNameLbl.text = teamViewModel.team.value.name // think if need to bind
//            teamViewModel.team.bind { [weak self] team in
//                self?.scoreLbl.text = "\(team.score)"
//            }
//        }
//    }
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        setupButtons()
//        setupButtonActions()
//        
//        addSubview(teamNameLbl)
//        addSubview(scoreLbl)
//        addSubview(incrementBtn)
//        addSubview(decrementBtn)
//        
//        addConstraints()
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setupButtons() {
//        incrementBtn.setTitle("+", for: .normal)
//        decrementBtn.setTitle("-", for: .normal)
//        
////        decrementBtn.backgroundColor = .brown
//        incrementBtn.setTitleColor(.black, for: .normal)
//        decrementBtn.setTitleColor(.black, for: .normal)
//        
////        incrementBtn.addTarget(self, action: #selector(increase), for: .touchUpInside)
////        decrementBtn.addTarget(self, action: #selector(decrease), for: .touchUpInside)
//        
//        incrementBtn.isExclusiveTouch = true
//        decrementBtn.isExclusiveTouch = true
//        
//    }
//    
//    @objc private func increase() {
//        popupTeamViewModel?.incrementScore()
//        print("inside)")
//    }
//    
//    @objc private func decrease() {
//        popupTeamViewModel?.decrementScore()
//    }
//    
//    private func setupButtonActions() {
//        let incrementAction = UIAction { [weak self] _ in
//            self?.popupTeamViewModel?.incrementScore()
//        }
//        let decrementAction = UIAction { [weak self] _ in
//            self?.popupTeamViewModel?.decrementScore()
//        }
//        incrementBtn.addAction(incrementAction, for: .touchUpInside)
//        decrementBtn.addAction(decrementAction, for: .touchUpInside)
//
//    }
//}
//
//extension PopupTeamsCellView {
//    
//    private func addConstraints() {
//        teamNameLbl.translatesAutoresizingMaskIntoConstraints = false
//        scoreLbl.translatesAutoresizingMaskIntoConstraints = false
//        incrementBtn.translatesAutoresizingMaskIntoConstraints = false
//        decrementBtn.translatesAutoresizingMaskIntoConstraints = false
//        
////        let sALG = view.safeAreaLayoutGuide
//        NSLayoutConstraint.activate([
//            
//            teamNameLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            teamNameLbl.leftAnchor.constraint(equalTo: self.leftAnchor),
//            
//            scoreLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            scoreLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            
//            decrementBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            decrementBtn.rightAnchor.constraint(equalTo: self.rightAnchor),
//            
//            incrementBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            incrementBtn.rightAnchor.constraint(equalTo: decrementBtn.leftAnchor),
//
//        ])
//    }
//}
