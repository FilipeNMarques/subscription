//
//  SubscriptionView.swift
//  subscription
//
//  Created by Filipe Marques on 31/07/24.
//

import UIKit

final class SubscriptionView: UIView {
    lazy var headerStackView: UIStackView = {
        let hStack = UIStackView()

        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.backgroundColor = .black

        return hStack
    }()

    lazy var headerImageView: UIImageView = {
        let image = UIImageView()

        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit

        return image
    }()

    lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()

    lazy var mainContentVStackView: UIStackView = {
        let vStack = UIStackView()

        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 8

        return vStack
    }()

    lazy var coverImageView: UIImageView = {
        let image = UIImageView()

        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit

        return image
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black

        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black

        return label
    }()

    lazy var offersHStack: UIStackView = {
        let hStack = UIStackView()

        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        hStack.distribution = .fillProportionally
        hStack.alignment = .center
        hStack.spacing = 8

        return hStack
    }()

    lazy var offersDivider: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray

        return view
    }()

    lazy var benefitsButton: UIButton = {
        let button = UIButton()

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("What is \"News+?\"", for: .normal)
        button.setTitleColor(.black, for: .normal)

        return button
    }()

    lazy var disclaimerLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black

        return label
    }()

    lazy var subscribeButton: UIButton = {
        let button = UIButton()

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Subscribe Now", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .white

        addSubview(headerStackView)
        headerStackView.addArrangedSubview(headerImageView)

        addSubview(scrollView)
        scrollView.addSubview(mainContentVStackView)

        addSubview(mainContentVStackView)
        mainContentVStackView.addArrangedSubview(coverImageView)
        mainContentVStackView.addArrangedSubview(titleLabel)
        mainContentVStackView.addArrangedSubview(subtitleLabel)
        mainContentVStackView.addArrangedSubview(offersHStack)

        offersHStack.addArrangedSubview(offersDivider)

        mainContentVStackView.addArrangedSubview(benefitsButton)
        mainContentVStackView.addArrangedSubview(subscribeButton)
        mainContentVStackView.addArrangedSubview(disclaimerLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerStackView.heightAnchor.constraint(equalToConstant: 70),

            headerImageView.topAnchor.constraint(equalTo: headerStackView.topAnchor, constant: 8),
            headerImageView.bottomAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: -8),

            scrollView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 18),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -18),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            mainContentVStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainContentVStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainContentVStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainContentVStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainContentVStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            titleLabel.heightAnchor.constraint(equalToConstant: 50),

            disclaimerLabel.bottomAnchor.constraint(equalTo: mainContentVStackView.bottomAnchor),
            disclaimerLabel.heightAnchor.constraint(equalToConstant: 60),

            coverImageView.heightAnchor.constraint(equalToConstant: 200),

            offersHStack.leadingAnchor.constraint(equalTo: mainContentVStackView.leadingAnchor),
            offersHStack.trailingAnchor.constraint(equalTo: mainContentVStackView.trailingAnchor),
            offersHStack.heightAnchor.constraint(equalToConstant: 120),

            offersDivider.widthAnchor.constraint(equalToConstant: 1),
            offersDivider.heightAnchor.constraint(equalToConstant: 70),
            offersDivider.centerXAnchor.constraint(equalTo: centerXAnchor),

            subscribeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func configure(with viewModel: SubscriptionViewModel) {
        if let url = viewModel.headerLogo {
            headerImageView.load(url: url)
        }

        if let url = viewModel.coverImage {
            coverImageView.load(url: url)
        }

        titleLabel.text = viewModel.subscribeTitle
        subtitleLabel.text = viewModel.subscribeSubtitle

        offersHStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for (index, offer) in viewModel.offers.enumerated() {
            let offerView = createOfferView(for: offer)
            offersHStack.addArrangedSubview(offerView)
            if index == 0 && viewModel.offers.count > 1 {
                offersHStack.addArrangedSubview(offersDivider)
            }
        }

        disclaimerLabel.text = viewModel.disclaimer
    }

    private func createOfferView(for offer: OfferModel) -> UIView {
        let offerView = makeOfferStackView()
        let priceLabel = makeOfferPrice(price: offer.price)
        let descriptionLabel = makeOfferDescription(description: "\(offer.description)")

        offerView.addSubview(priceLabel)
        offerView.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: offerView.topAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: offerView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: offerView.trailingAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: offerView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: offerView.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: offerView.bottomAnchor)
        ])

        return offerView
    }
}

// MARK: - Factory methods
extension SubscriptionView {
    private func makeOfferStackView() -> UIStackView {
        let vStack = UIStackView()

        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.alignment = .center

        return vStack
    }

    private func makeOfferPrice(price: Double) -> UILabel {
        let label = UILabel()

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"

        if let formattedPrice = formatter.string(from: NSNumber(value: price)) {
            label.text = formattedPrice
        } else {
            label.text = "$\(price)"
        }

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 26, weight: .black)
        label.textColor = .black

        return label
    }

    private func makeOfferDescription(description: String) -> UILabel {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = description
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .black

        return label
    }
}

/// Helper extension to load images from URL
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
