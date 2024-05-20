//
//  FeedbackViewController.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 20.05.2024.
//

import UIKit
import MessageUI

class FeedbackViewController: RootViewController, MFMailComposeViewControllerDelegate {

    let feedbackLabel = UILabel()
    let linkToEmail = UILabel()
    let linkToAppStore = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFeedback()
        setupConstraints()
        
        setupLinkToEmail()
        setupRateUs()
    }
    
    func setupFeedback() {
        feedbackLabel.text = String(localized: "Feedback")
        feedbackLabel.font = UIFont.systemFont(ofSize: 20)
        feedbackLabel.textColor = AppAssetsConfigs.Colors.textMain
        feedbackLabel.textAlignment = .center
        
        linkToEmail.text = String(localized: "Send feedback to email")
        linkToEmail.font = UIFont.systemFont(ofSize: 20)
        linkToEmail.textColor = AppAssetsConfigs.Colors.textMain
        linkToEmail.textAlignment = .center
        linkToEmail.backgroundColor = AppAssetsConfigs.Colors.cellBackground
        linkToEmail.layer.cornerRadius = 16
        linkToEmail.clipsToBounds = true
        
        linkToAppStore.text = String(localized: "Rate us in AppStore")
        linkToAppStore.font = UIFont.systemFont(ofSize: 20)
        linkToAppStore.textColor = AppAssetsConfigs.Colors.textMain
        linkToAppStore.textAlignment = .center
        linkToAppStore.backgroundColor = AppAssetsConfigs.Colors.cellBackground
        linkToAppStore.layer.cornerRadius = 16
        linkToAppStore.clipsToBounds = true
        linkToAppStore.isHidden = true
        
        view.addSubview(feedbackLabel)
        view.addSubview(linkToEmail)
        view.addSubview(linkToAppStore)
    }
    
    func setupConstraints() {
        let padding: CGFloat = 20
        
        feedbackLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(padding * 2)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(padding)
        }
        
        linkToEmail.snp.makeConstraints { make in
            make.top.equalTo(feedbackLabel.snp.bottom).offset(padding)
            make.height.equalTo(50)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(padding)
        }
        
        linkToAppStore.snp.makeConstraints { make in
            make.top.equalTo(linkToEmail.snp.bottom).offset(padding)
            make.height.equalTo(50)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(padding)
        }
    }
    
    func setupLinkToEmail() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(emailTapped))
        linkToEmail.isUserInteractionEnabled = true
        linkToEmail.addGestureRecognizer(tap)
    }
    
    func setupRateUs() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(rateUsTapped))
        linkToAppStore.isUserInteractionEnabled = true
        linkToAppStore.addGestureRecognizer(tap)
    }
    
    
    @objc func emailTapped() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["d3f0ld@protonmail.com"]) // replace with your email
            mail.setSubject("Feedback for 5words10seconds")
            mail.setMessageBody("Here is my feedback:", isHTML: false)

            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    @objc func rateUsTapped() {
//        if let url = URL(string: "itms-apps://itunes.apple.com/app/idYOUR_APP_ID") { // replace with your app id
//            if UIApplication.shared.canOpenURL(url) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            }
//        }
    }

    // MFMailComposeViewControllerDelegate

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
