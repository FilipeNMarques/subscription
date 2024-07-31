//
//  CoreDataManager.swift
//  subscription
//
//  Created by Filipe Marques on 31/07/24.
//

import Foundation
import CoreData

internal protocol CoreDataManagerProtocol {
    var context: NSManagedObjectContext { get }
    func saveContext()
    func saveSubscription(subscription: SubscriptionModel)
    func fetchSubscriptions() -> [Subscription]
}

class CoreDataManager: CoreDataManagerProtocol {
    static let shared = CoreDataManager()
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Subscription")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetchSubscriptions() -> [Subscription] {
        let fetchRequest: NSFetchRequest<Subscription> = Subscription.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch subscriptions: \(error)")
            return []
        }
    }

    func saveSubscription(subscription: SubscriptionModel) {
        let entity = Subscription(context: context)
        entity.headerLogo = subscription.headerLogo.absoluteString
        entity.coverImage = subscription.coverImage.absoluteString
        entity.subscribeTitle = subscription.subscribeTitle
        entity.subscribeSubtitle = subscription.subscribeSubtitle
        entity.disclaimer = subscription.disclaimer

        for offerModel in subscription.offers {
            let offerEntity = Offer(context: context)
            offerEntity.price = offerModel.price
            offerEntity.descriptionText = offerModel.description
        }

        saveContext()
    }
}
