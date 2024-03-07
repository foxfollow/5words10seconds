//
//  TeamsMiniCellView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 06.03.2024.
//

import UIKit
import SnapKit

class TeamsMiniCellView: UICollectionViewCell {
    
    var plusComplition: (() -> Void)?
    var minusComplition: (() -> Void)?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .right
        return label
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.setImage(UIImage(systemName: "plus.square"), for: .highlighted)
        return button
    }()

    let minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus.circle"), for: .normal)
        button.setImage(UIImage(systemName: "minus.square"), for: .highlighted)
        return button
    }()

    let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
        setupConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        addSubview(nameLabel)
        addSubview(scoreLabel)
        addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(plusButton)
        buttonsStackView.addArrangedSubview(minusButton)

        plusButton.addTarget(self, action: #selector(plusButtonAction), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonAction), for: .touchUpInside)
    }
    
    func setupConstraints() {
        
        buttonsStackView.snp.remakeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalToSuperview()
            make.width.equalTo(65)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
        }
        
        // TODO: make bigger buttons
        plusButton.snp.remakeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        minusButton.snp.remakeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        scoreLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.trailing.equalTo(buttonsStackView.snp.leading).offset(-10)
            make.width.equalTo(30)
        }
        
        nameLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.trailing.equalTo(scoreLabel.snp.leading).offset(-5).priority(.high)
        }
        
    }
    
    func configure(with team: TeamModel) {
        nameLabel.text = team.name
        scoreLabel.text = "\(team.score)"
    }
    
    @objc func plusButtonAction() {
        print("Plus button tapped")
        plusComplition?()
    }
    
    @objc func minusButtonAction() {
        print("Minus button tapped")
        minusComplition?()
    }
    
}
