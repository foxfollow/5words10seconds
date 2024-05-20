//
//  TeamsView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//

import UIKit

extension TeamsViewController {
    func setupSubviews() {
        setupBackgroundView()
        setupTableView()
        setupLabels()
        setupButtons()
        addConstraints()
    }

    private func setupBackgroundView() {
        title = String(localized: "Teams")
    }

    // MARK: TableView

    private func setupTableView() {
        tableView.backgroundColor = .none
        tableView.rowHeight = 56
        view.addSubview(tableView)
    }

    // MARK: Labels

    private func setupLabels() {
        descriptionLbl.text = String(localized: "Double tab a team name to change it, press and hold to enter a team name")
        view.addSubview(descriptionLbl)
    }

    // MARK: Buttons

    private func setupButtons() {
        addBtn.setTitle(String(localized: "Add new"), for: .normal)
        addBtn.setTitleColor(AppAssetsConfigs.Colors.textMain, for: .normal)
        addBtn.setTitleColor(AppAssetsConfigs.Colors.textOpositeMain, for: .highlighted)
        addBtn.backgroundColor = AppAssetsConfigs.Colors.buttonAccept
        endBtn.setTitle(String(localized: "Next"), for: .normal)
        endBtn.setTitleColor(AppAssetsConfigs.Colors.textMain, for: .normal)
        endBtn.setTitleColor(AppAssetsConfigs.Colors.textOpositeMain, for: .highlighted)
        endBtn.backgroundColor = AppAssetsConfigs.Colors.buttonAccept

        view.addSubview(addBtn)
        view.addSubview(endBtn)
    }

    // MARK: Constraints

    private func addConstraints() {
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(tableViewHeight)
        }

        addBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(tableView.snp.bottom)
            make.height.equalTo(56)
        }

        endBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(8)
            make.height.equalTo(56)
        }
    }
}
