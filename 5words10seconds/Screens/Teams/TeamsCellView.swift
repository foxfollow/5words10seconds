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
    var indexPath: IndexPath?
    weak var delegate: TeamsCellViewModelDelegate?

    private let crossImg = UIButton(type: .system)

    let cellView = UILabel()

    var cellViewModel: TeamsCellViewModel? {
        didSet {
            teamNameLbl.text = cellViewModel?.name
            crossImg.isUserInteractionEnabled = true
            crossImg.removeTarget(nil, action: nil, for: .allEvents) // Remove previous targets
            crossImg.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        }
    }

    @objc func deleteButtonTapped() {
        if let indexPath = indexPath {
            delegate?.deleteButtonTapped(at: indexPath)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubviews()
    }

    private func setupSubviews() {
//        contentView.backgroundColor = #colorLiteral(red: 0.7862124443, green: 0.9268439412, blue: 1, alpha: 1)
//        let cellHeight: CGFloat = 48

        contentView.addSubview(cellView)
        cellView.addSubview(teamNameLbl)
        contentView.addSubview(crossImg)

        setupCellConstaints()

        crossImg.contentMode = .scaleAspectFit
        crossImg.clipsToBounds = true
        crossImg.isUserInteractionEnabled = true
        crossImg.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        crossImg.tintColor = .orange
        crossImg.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
}

extension TeamsCellView {
    @objc func crossImgTapped() {
        print("crossImgTapped")
    }
}

extension TeamsCellView {
    func setupCellConstaints() {
        cellView.translatesAutoresizingMaskIntoConstraints = false
        teamNameLbl.translatesAutoresizingMaskIntoConstraints = false
        crossImg.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // // Cell View Constraints
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),

            // Team Name Label Constraints
            teamNameLbl.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16),
            teamNameLbl.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),

            // Cross Image Button Constraints
            crossImg.leadingAnchor.constraint(equalTo: teamNameLbl.trailingAnchor, constant: 8),
            crossImg.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            crossImg.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -16),
            crossImg.widthAnchor.constraint(equalTo: crossImg.heightAnchor),
        ])
    }
}
