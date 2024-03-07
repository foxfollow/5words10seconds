//
//  AlertView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 29.01.2024.
//

import UIKit

class AlertView: UIView {
    
    let isFullWidthButtons: Bool
    
    weak var overlayView: UIView?
    
    lazy var bordersView: UIView = {
        var view = UIView()
        
        view.backgroundColor = .lightGray
        
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor.darkGray.cgColor
        
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
    
    var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    var acceptButtonsColor: UIColor? {
        didSet {
            guard let buttonsColor = acceptButtonsColor else { return }
            acceptButton.setTitleColor(buttonsColor, for: .normal)
            acceptButton.setTitleColor(.white, for: .highlighted)
            acceptButton.layer.borderColor = buttonsColor.cgColor
            acceptButton.backgroundColor = buttonsColor.withAlphaComponent(0.05)
        }
    }
    
    
    var declineButtonsColor: UIColor? {
        didSet {
            guard let buttonsColor = declineButtonsColor else { return }
            declineButton.setTitleColor(buttonsColor, for: .normal)
            declineButton.setTitleColor(.white, for: .highlighted)
            declineButton.layer.borderColor = buttonsColor.cgColor
            declineButton.backgroundColor = buttonsColor.withAlphaComponent(0.05)        }
    }
    
    var acceptButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        
        button.backgroundColor = .lightGray
        button.layer.borderWidth = 4
        button.layer.cornerRadius = 32
        button.clipsToBounds = true
        return button
    }()
    
    var declineButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        
        button.backgroundColor = .lightGray
        button.layer.borderWidth = 4
        button.layer.cornerRadius = 32
        button.clipsToBounds = true
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        if isFullWidthButtons {
            stackView.axis = .vertical
        } else {
            stackView.axis = .horizontal
        }
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        return stackView
    }()
    
    var acceptAction: (() -> Void)?
    var declineAction: (() -> Void)?
    
    init(frame: CGRect, isFullWidthButtons: Bool = false) {
        self.isFullWidthButtons = isFullWidthButtons
        self.acceptButtonsColor = .systemRed
        self.declineButtonsColor = .systemOrange
        super.init(frame: frame)
        setupView()
        setupConstraints()
        
        self.clipsToBounds = true
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        self.isFullWidthButtons = false
        self.acceptButtonsColor = .systemRed
        self.declineButtonsColor = .systemOrange

        super.init(coder: coder)
    }

    private func setupView() {
        addSubview(bordersView)
        bordersView.addSubview(titleLabel)
        bordersView.addSubview(messageLabel)
        bordersView.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(declineButton)
        buttonStackView.addArrangedSubview(acceptButton)
        
        acceptButton.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
        declineButton.addTarget(self, action: #selector(declineButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        bordersView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // bordersView constraints
            bordersView.topAnchor.constraint(equalTo: self.topAnchor),
            bordersView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bordersView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bordersView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            // titleLabel constraints
            titleLabel.topAnchor.constraint(equalTo: bordersView.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: bordersView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: bordersView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: bordersView.trailingAnchor, constant: -24),

            // messageLabel constraints
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.centerXAnchor.constraint(equalTo: bordersView.centerXAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: bordersView.leadingAnchor, constant: 24),
            messageLabel.trailingAnchor.constraint(equalTo: bordersView.trailingAnchor, constant: -24),

            // buttonStackView constraints
            buttonStackView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: bordersView.leadingAnchor, constant: 24),
            buttonStackView.trailingAnchor.constraint(equalTo: bordersView.trailingAnchor, constant: -24),
            buttonStackView.heightAnchor.constraint(equalToConstant: isFullWidthButtons ? 135 : 60),
            buttonStackView.bottomAnchor.constraint(equalTo: bordersView.bottomAnchor, constant: -20)
        ])
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
    
    @objc private func declineButtonTapped() {
        if let overlay = overlayView {
            UIView.animate(withDuration: 0.3, animations: {
                overlay.alpha = 0
            }) { _ in
                self.declineAction?()
                self.removeFromSuperview()
                overlay.removeFromSuperview()
            }
        } else {
            declineAction?()
            self.removeFromSuperview()
        }
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        bordersView.layoutIfNeeded()
    }
}
