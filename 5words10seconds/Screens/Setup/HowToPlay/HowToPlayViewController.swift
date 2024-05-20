//
//  HowToPlayViewController.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 20.05.2024.
//

import UIKit
import SnapKit

class HowToPlayViewController: RootViewController {
    
    let scrollView = UIScrollView()
    let howToPlayLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHowToPlay()
        addConstraints()
    }
    
    func setupHowToPlay() {
        howToPlayLabel.text = String(localized: "How to play")
        howToPlayLabel.numberOfLines = 0
        howToPlayLabel.font = UIFont.systemFont(ofSize: 20)
        howToPlayLabel.textAlignment = .center
        howToPlayLabel.textColor = AppAssetsConfigs.Colors.textMain
        howToPlayLabel.clipsToBounds = true
        
        scrollView.addSubview(howToPlayLabel)
        view.addSubview(scrollView)
    }
    
    func addConstraints() {
        let padding: CGFloat = 20

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        howToPlayLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(padding)
            make.left.equalTo(scrollView.snp.left).offset(padding)
            make.right.equalTo(scrollView.snp.right).offset(-padding)
            make.bottom.equalTo(scrollView.snp.bottom).offset(-padding)
            make.width.equalTo(scrollView.snp.width).offset(-2 * padding)
        }
    }
}
