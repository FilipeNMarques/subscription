//
//  SubscriptionViewModel.swift
//  subscription
//
//  Created by Filipe Marques on 31/07/24.
//

import Foundation

protocol SubscriptionViewModelDelegate: AnyObject {
    func didUpdateSubscription()
}

class SubscriptionViewModel {
    private var subscription: SubscriptionModel?
    private var coreDataManager: CoreDataManagerProtocol
    weak var delegate: SubscriptionViewModelDelegate?

    var headerLogo: URL? {
        return subscription?.headerLogo
    }

    var coverImage: URL? {
        return subscription?.coverImage
    }

    var subscribeTitle: String? {
        return subscription?.subscribeTitle
    }

    var subscribeSubtitle: String? {
        return subscription?.subscribeSubtitle
    }

    var offers: [OfferModel] {
        return subscription?.offers ?? []
    }

    var benefits: [String] {
        return subscription?.benefits ?? []
    }

    var disclaimer: String? {
        return subscription?.disclaimer
    }

    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }

    func fetchSubscriptionData() async {
            do {
                let payload = try await NetworkManager.shared.fetch()
                await updateCoreData(with: payload)
                subscription = self.convertPayloadToSubscription(payload)

                DispatchQueue.main.async {
                    self.notifyUpdate()
                }
            } catch {
                print("error")
            }
    }

    func updateCoreData(with payload: SubscriptionPayload) async {
        let subscriptionModel = convertPayloadToSubscription(payload)

        coreDataManager.saveSubscription(subscription: subscriptionModel)
    }

    func convertPayloadToSubscription(_ payload: SubscriptionPayload) -> SubscriptionModel {
        return SubscriptionModel(
            id: payload.id,
            headerLogo: URL(string: payload.record.header_logo)!,
            coverImage: URL(string: payload.record.subscription.cover_image)!,
            subscribeTitle: payload.record.subscription.subscribe_title,
            subscribeSubtitle: payload.record.subscription.subscribe_subtitle,
            offers: payload.record.subscription.offers.map { OfferModel(price: $0.value.price, description: $0.value.description) },
            benefits: payload.record.subscription.benefits,
            disclaimer: payload.record.subscription.disclaimer
        )
    }

    func checkForUpdates() async {
        await fetchSubscriptionData()
    }

    private func notifyUpdate() {
        delegate?.didUpdateSubscription()
    }
}

