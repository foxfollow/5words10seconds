//
//  CategoryViewController.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//

import AVFoundation
import UIKit

class CategoryViewController: UIViewController, AVAudioPlayerDelegate {
    let descriptionLbl = UILabel()
    let categoryLbl = UILabel()
    let backgroundRectangle = UIView()

    let categoryViewModel: CategoryViewModel

    var timerViewModel = TimerViewModel()
    var timerView: TimerView! // inited in CategoryView.swift - setupTimer()

    let tableView = UITableView() // setuped in PopupViewsFuncs.swift - listTeamsTableViewPopup()

    var endSoundPlayer: AVAudioPlayer?

    init(viewModel: CategoryViewModel) {
        categoryViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupSubviews() // in CategoryView.swift
        setupBinders()
        isReadyPopup() // in PopupViewsFuncs.swift
    }

    private func setupBinders() {
        // MARK: Timer binder

        timerViewModel.timerDidEnd.bind { [weak self] didEnd in
            self?.timerView.circle.backgroundColor = didEnd ? .red : .white
            if didEnd && (self?.categoryViewModel.currentCtgr.value != nil) {
                DispatchQueue.main.async {
                    self?.timerEndPopup()
                    self?.playEndSound()
                }
            } else if !didEnd {
                // DispatchQueue.main.async {
                //     self?.playStartSound()
                // }
            }
        }

        timerViewModel.timerValue.bind { [weak self] newValue in
            // DispatchQueue.main.async {
            //     if newValue > 0 && newValue < 4 {
            //         self?.playThreeSecondSound()
            //     }
            // }

            DispatchQueue.main.async {
                self?.timerView.label.text = "\(newValue)"
            }
        }

        // MARK: Category-word binder

        categoryViewModel.currentCtgr.bind { [weak self] category in
            self?.categoryLbl.text = category?.name
        }

        // MARK: Team binder

        categoryViewModel.currentTeam.bind { [weak self] team in
            print("Team changed to \(team?.name ?? "")")
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        categoryViewModel.teams.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        // Bind scoreLabel to teams.value[row].score
//        categoryViewModel.teams.bind { [weak self] teams in
//            guard let self = self else { return }
//            let score = teams[indexPath.row].score
//            self.scoreLabel.text = "\(score)"
//        }
    }

    private func playEndSound() {
        guard let url = Bundle.main.url(forResource: "endringing", withExtension: "mp3", subdirectory: "Sounds") else { print("failed sound"); return }
        do {
            endSoundPlayer = try AVAudioPlayer(contentsOf: url)
            endSoundPlayer?.delegate = self
            endSoundPlayer?.play()
        } catch {
            print("Failed to play end sound: \(error.localizedDescription)")
        }
    }
}

extension CategoryViewController {
    func setupNavigationBar() {
        let backButton = UIBarButtonItem(title: String(localized: "Quit"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }

    @objc func backButtonTapped() {
        let alert = UIAlertController(title: String(localized: "Are you sure you want to quit?"), message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: String(localized: "Yes"), style: .default, handler: { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: String(localized: "No"), style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
