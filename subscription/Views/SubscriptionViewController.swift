//
//  SubscriptionViewController.swift
//  subscription
//
//  Created by Filipe Marques on 31/07/24.
//

import UIKit

class SubscriptionViewController: UIViewController, SubscriptionViewModelDelegate {
    private let viewModel: SubscriptionViewModel
    private let subscriptionView = SubscriptionView()

    init(viewModel: SubscriptionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = subscriptionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        subscriptionView.benefitsButton.addTarget(self, action: #selector(toggleBenefits), for: .touchUpInside)
        subscriptionView.subscribeButton.addTarget(self, action: #selector(subscribeButtonTapped), for: .touchUpInside)

        Task(priority: .background) {
            await viewModel.checkForUpdates()
        }
    }

    func didUpdateSubscription() {
        subscriptionView.configure(with: viewModel)
    }

    @objc
    private func toggleBenefits() {
        let benefits = viewModel.benefits.joined(separator: "\n")
        makeAlert(title: "What news?", message: benefits, closeLabel: "Close")
    }

    @objc
    private func subscribeButtonTapped() {
        makeAlert(title: "Thank you", message: "You will receive an email with instructions", closeLabel: "Great!")
    }
}

extension SubscriptionViewController {
    private func makeAlert(title: String, message: String, closeLabel: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: closeLabel, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
