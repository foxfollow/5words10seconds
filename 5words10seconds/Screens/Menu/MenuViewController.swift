//
//  MenuViewController.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//

import UIKit
import AVFoundation

class MenuViewController: RootViewController, AVAudioPlayerDelegate {

    let game5w10sBtn = UIButton()
    let game3w5sBtn = UIButton()

    let backgroundViewUpper = UIView()
    let backgroundViewLower = UIView()

//    let setupViewModel = MenuViewModel()
    
    var endSoundPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews() // in MenuView.swift
        setupButtonTargets()
        
    }
    
    private func setupButtonTargets() {
        game5w10sBtn.addTarget(self, action: #selector(fiveTenButtonClicked), for: .touchUpInside)
        
        game3w5sBtn.addTarget(self, action: #selector(threeFiveTenButtonClicked), for: .touchUpInside)
    }
    
    @objc func fiveTenButtonClicked() {
        let controller = TeamsViewController()
        navigationItem.backButtonTitle = String(localized: "Back")
        navigationController?.navigationBar.tintColor = AppAssetsConfigs.Colors.textMain
        navigationController?.pushViewController(controller, animated: true)
        //        present(controller, animated: true)
    }
    
    @objc func threeFiveTenButtonClicked() {
        print(String(localized: "Doesn't work yet (in dev)"))
        //        private func playEndSound() {
        guard let url = Bundle.main.url(forResource: "endringing", withExtension: "mp3", subdirectory: "Sounds") else { print("failed sound"); return }
        do {
            endSoundPlayer = try AVAudioPlayer(contentsOf: url)
            endSoundPlayer?.delegate = self
            endSoundPlayer?.play()
        } catch {
            print("Failed to play end sound: \(error.localizedDescription)")
        }
        //        }
    }

}
