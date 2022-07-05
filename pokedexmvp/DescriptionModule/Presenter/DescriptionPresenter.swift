import Foundation

// MARK: - Protocols

protocol DescriptionViewProtocol: AnyObject {
    func setDescription (description: Description)
}

protocol DescriptionPresenterProtocol: AnyObject {
    init(view: DescriptionViewProtocol, router: RouterProtocol, description: Description)
    func setDescription()
    func tap()
}

// MARK: - Classes
class DescriptionPresenter: DescriptionPresenterProtocol {

    weak var viewDelegate: DescriptionViewProtocol?
    var description: Description?
    var router: RouterProtocol?

    required init(view: DescriptionViewProtocol, router: RouterProtocol, description: Description) {
        self.viewDelegate = view
        self.description = description
        self.router = router
    }

    func tap() {
        router?.popToRoot()
    }

   public func setDescription() {
       if let unwrapDescription = description {
           self.viewDelegate?.setDescription(description: unwrapDescription)
       }
    }

}
