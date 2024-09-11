//
//  FeedbackViewController.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 20.05.2024.
//

import UIKit
import MessageUI
import StoreKit

class FeedbackViewController: RootViewController {
    
    let feedbackLabel = UILabel()
    let linkToEmail = AditionalButton()
    let linkToAppStore = AditionalButton()
    let linkToShareApp = AditionalButton()
    let linkToGitHub = AditionalButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFeedback()
        setupConstraints()
        setupButtonActions()
        
        // Set the presentation controller delegate
        self.presentationController?.delegate = self
    }
    
    func setupFeedback() {
        feedbackLabel.text = String(localized: "Feedback")
        feedbackLabel.font = UIFont.systemFont(ofSize: 20)
        feedbackLabel.textColor = AppAssetsConfigs.Colors.textMain
        feedbackLabel.textAlignment = .center
        
        linkToEmail.setTitle(String(localized: "Send feedback to email"), for: .normal)
        linkToEmail.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        linkToEmail.setTitleColor(AppAssetsConfigs.Colors.textMain, for: .normal)
        linkToEmail.titleLabel?.textAlignment = .center
        linkToEmail.titleLabel?.numberOfLines = 2
        linkToEmail.backgroundColor = AppAssetsConfigs.Colors.cellBackground
        linkToEmail.layer.cornerRadius = 16
        linkToEmail.clipsToBounds = true
        
        linkToAppStore.setTitle(String(localized: "Rate us in AppStore"), for: .normal)
        linkToAppStore.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        linkToAppStore.setTitleColor(AppAssetsConfigs.Colors.textMain, for: .normal)
        linkToAppStore.titleLabel?.textAlignment = .center
        linkToAppStore.backgroundColor = AppAssetsConfigs.Colors.cellBackground
        linkToAppStore.layer.cornerRadius = 16
        linkToAppStore.clipsToBounds = true
        
        linkToShareApp.setTitle(String(localized: "Share the app"), for: .normal)
        linkToShareApp.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        linkToShareApp.setTitleColor(AppAssetsConfigs.Colors.textMain, for: .normal)
        linkToShareApp.titleLabel?.textAlignment = .center
        linkToShareApp.backgroundColor = AppAssetsConfigs.Colors.cellBackground
        linkToShareApp.layer.cornerRadius = 16
        linkToShareApp.clipsToBounds = true
        
        linkToGitHub.setTitle(String(localized: "View on GitHub"), for: .normal)
        linkToGitHub.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        linkToGitHub.setTitleColor(AppAssetsConfigs.Colors.textMain, for: .normal)
        linkToGitHub.titleLabel?.textAlignment = .center
        linkToGitHub.backgroundColor = AppAssetsConfigs.Colors.cellBackground
        linkToGitHub.layer.cornerRadius = 16
        linkToGitHub.clipsToBounds = true
        
        view.addSubview(feedbackLabel)
        view.addSubview(linkToEmail)
        view.addSubview(linkToAppStore)
        view.addSubview(linkToShareApp)
        view.addSubview(linkToGitHub)
    }
    
    func setupConstraints() {
        let padding: CGFloat = 20
        let cellHeight: CGFloat = 68
        
        feedbackLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(padding * 2)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(padding)
        }
        
        linkToEmail.snp.makeConstraints { make in
            make.top.equalTo(feedbackLabel.snp.bottom).offset(padding)
            make.height.equalTo(cellHeight)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(padding)
        }
        
        linkToAppStore.snp.makeConstraints { make in
            make.top.equalTo(linkToEmail.snp.bottom).offset(padding)
            make.height.equalTo(cellHeight)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(padding)
        }
        
        linkToShareApp.snp.makeConstraints { make in
            make.top.equalTo(linkToAppStore.snp.bottom).offset(padding)
            make.height.equalTo(cellHeight)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(padding)
        }
        
        linkToGitHub.snp.makeConstraints { make in
            make.top.equalTo(linkToShareApp.snp.bottom).offset(padding)
            make.height.equalTo(cellHeight)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(padding)
        }
    }
    
    private func setupButtonActions() {
        linkToEmail.addTarget(self, action: #selector(emailTapped), for: .touchUpInside)
        linkToAppStore.addTarget(self, action: #selector(rateUsTapped), for: .touchUpInside)
        linkToShareApp.addTarget(self, action: #selector(shareTheAppTapped), for: .touchUpInside)
        linkToGitHub.addTarget(self, action: #selector(githubTapped), for: .touchUpInside)
    }
    
    @objc func emailTapped() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["d3f0ld@proton.me"])
            mail.setSubject("Feedback for 5words10seconds")
            mail.setMessageBody("Here is my feedback:", isHTML: false)
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    @objc func rateUsTapped() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    @objc func shareTheAppTapped() {
        guard let bunchProposeLuminousBracket = URL(string: "https://itunes.apple.com/app/id6479040398") else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [bunchProposeLuminousBracket], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func githubTapped() {
        guard let url = URL(string: "https://github.com/foxfollow/5words10seconds") else { return }
        UIApplication.shared.open(url)
    }
                            
}

// MFMailComposeViewControllerDelegate
extension FeedbackViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

// UIAdaptivePresentationControllerDelegate
extension FeedbackViewController: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        if linkToEmail.isTouchInside || linkToAppStore.isTouchInside || linkToShareApp.isTouchInside {
            // Prevent dismissal
        } else {
            // Allow dismissal
            dismiss(animated: true, completion: nil)
        }
    }
}
