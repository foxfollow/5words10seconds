//
//  AlertCollectionView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 03.03.2024.
//

import UIKit
import SnapKit


//protocol AlertTableViewDelegate: AnyObject {
//    func updateCollection()
//}

class AlertCollectionView: UIView {
    
//    weak var delegate: AlertTableViewDelegate?
    
    let teamsCount: Int
    
    let heightOfCollection: CGFloat
    
    let categoryViewModel: CategoryViewModel?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(TeamsMiniCellView.self, forCellWithReuseIdentifier: "TeamsMiniCellView")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    weak var overlayView: UIView?
    
    lazy var bordersView: UIView = {
        var view = UIView()
        
        view.backgroundColor = AppAssetsConfigs.Colors.cellBackground
        
        view.layer.borderWidth = 2
        view.layer.borderColor = AppAssetsConfigs.Colors.strokeAlert.cgColor
        
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
//    var buttonsColor: UIColor? {
//        didSet {
//            guard let buttonsColor else { return }
//            acceptButton.setTitleColor(AppAssetsConfigs.Colors.textMain, for: .normal)
//            acceptButton.setTitleColor(AppAssetsConfigs.Colors.textContrast, for: .highlighted)
//            acceptButton.backgroundColor = buttonsColor//.withAlphaComponent(0.05)
//        }
//    }
    
    var acceptButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
//        button.setTitleColor(.red, for: .normal)
//        button.setTitleColor(UIColor(red: 1, green: 0, blue: 0, alpha: 0.5), for: .highlighted )
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.setTitleColor(AppAssetsConfigs.Colors.textMain, for: .normal)
        button.setTitleColor(AppAssetsConfigs.Colors.cellBackground, for: .highlighted)

        button.backgroundColor = AppAssetsConfigs.Colors.buttonAccept
        button.layer.borderColor = AppAssetsConfigs.Colors.strokeButtons.cgColor
        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.red.cgColor
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        return button
    }()
    
    var acceptAction: (() -> Void)?
    
    required init(frame: CGRect, caterogyViewModel: CategoryViewModel) {
        self.categoryViewModel = caterogyViewModel
        self.teamsCount = caterogyViewModel.teams.value.count // teamsCount
        self.heightOfCollection = CGFloat(40 * teamsCount) > 600 ? 600 : CGFloat(40 * teamsCount)
        super.init(frame: frame)
        setupView()
        setupConstraints()
        
        self.clipsToBounds = true
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        self.teamsCount = 0
        self.heightOfCollection = 0
        self.categoryViewModel = nil
        super.init(coder: coder)
    }

    private func setupView() {
        addSubview(bordersView)
        bordersView.addSubview(titleLabel)
        bordersView.addSubview(collectionView)
        bordersView.addSubview(acceptButton)
        
        acceptButton.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        bordersView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bordersView.snp.top).offset(20)
            make.leading.equalTo(bordersView.snp.leading).offset(24)
            make.trailing.equalTo(bordersView.snp.trailing).offset(-24)
            make.height.equalTo(60)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(bordersView.snp.leading).offset(24)
            make.trailing.equalTo(bordersView.snp.trailing).offset(-24)
            make.height.equalTo(heightOfCollection)
        }
        
        acceptButton.snp.makeConstraints { make in
            make.bottom.equalTo(bordersView.snp.bottom).offset(-20)
            make.leading.equalTo(bordersView.snp.leading).offset(24)
            make.trailing.equalTo(bordersView.snp.trailing).offset(-24)
            make.height.equalTo(60)
        }
    }
    
    @objc private func acceptButtonTapped(animateOverlay: UIView?) {
        if let overlay = overlayView {
            UIView.animate(withDuration: 0.3, animations: {
                overlay.alpha = 0
            }) { _ in
                self.acceptAction?()
                self.removeFromSuperview()
                overlay.removeFromSuperview()
            }
        } else {
            acceptAction?()
            self.removeFromSuperview()
        }
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        bordersView.layoutIfNeeded()
    }
    
    func adjustAlertHeight() {
        self.frame.size.height += heightOfCollection + 40
    }
}


//extension AlertTableView: UICollectionViewDataSource, UICollectionViewDelegate {
extension AlertCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsMiniCellView", for: indexPath) as! TeamsMiniCellView
        
        guard let categoryViewModel else { return cell }
        
        cell.tag = indexPath.row
        
        cell.minusComplition = {
            categoryViewModel.changeScore(isIncrement: false, index: cell.tag)
//            DispatchQueue.main.async {
//                self?.collectionView.reloadData()
//                cell.setupConstraints()
//            }
        }
        cell.plusComplition = { // [weak self] in
            categoryViewModel.changeScore(isIncrement: true, index: cell.tag)
//            DispatchQueue.main.async {
//                self?.collectionView.reloadData()
//                cell.setupConstraints()
//            }
        }
        
        cell.configure(with: categoryViewModel.teams.value[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    
}
