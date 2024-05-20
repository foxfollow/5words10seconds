//
//  TeamsCellView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 02.11.2023.
//

import UIKit
import SnapKit

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
            crossImg.removeTarget(nil, action: nil, for: .allEvents)
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
        self.backgroundColor = AppAssetsConfigs.Colors.cellBackground
        contentView.backgroundColor = .clear
//        let cellHeight: CGFloat = 48

        contentView.addSubview(cellView)
        cellView.addSubview(teamNameLbl)
        contentView.addSubview(crossImg)

        setupCellConstaints()
        
        

        crossImg.contentMode = .scaleAspectFit
        crossImg.clipsToBounds = true
        crossImg.isUserInteractionEnabled = true
        crossImg.setImage(AppAssetsConfigs.Icons.trash, for: .normal)
//        crossImg.tintColor = AppAssetsConfigs.Colors.buttonNeutralFull
        crossImg.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
}

// MARK: Bind to ViewModel for color change
extension TeamsCellView {
    func bind(to teamsViewModel: TeamsViewModel) {
        teamsViewModel.cellViewModels.bind { [weak self] arrayOfCells in // == to array of teams
            DispatchQueue.main.async {
                self?.crossImg.tintColor = arrayOfCells?.count ?? 0 < 2 ? .gray : AppAssetsConfigs.Colors.trashTint
            }
        }
    }
}

extension TeamsCellView {
    func setupCellConstaints() {
        cellView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(8)
            make.top.equalTo(contentView).offset(4)
            make.trailing.equalTo(contentView).offset(-8)
            make.bottom.equalTo(contentView).offset(-4)
        }
        
        teamNameLbl.snp.makeConstraints { make in
            make.leading.equalTo(cellView).offset(16)
            make.centerY.equalTo(cellView)
        }
        
        crossImg.snp.makeConstraints { make in
            make.leading.equalTo(teamNameLbl.snp.trailing).offset(8)
            make.centerY.equalTo(cellView)
            make.trailing.equalTo(cellView).offset(-16)
            make.width.equalTo(crossImg.snp.height)
            make.height.width.equalTo(24)
        }
        
        crossImg.imageView?.snp.makeConstraints({ make in
            make.height.width.equalTo(24)
        })
    }
}
