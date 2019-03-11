import UIKit

public class KeyboardFriendlyScrollController {
    /// contentInsets of the target scrollView when keyboard is hidden
    public var defaultContentInsets: UIEdgeInsets {
        didSet {
            adjustScrollViewInsets()
        }
    }

    private weak var viewController: UIViewController?
    private let scrollView: UIScrollView
    private var keyboardObservers: [NSObjectProtocol] = []

    private enum KeyboardState {
        case shown(keyboardFrame: CGRect)
        case hidden
    }
    private var currentState: KeyboardState = .hidden

    public init(viewController: UIViewController, scrollView: UIScrollView, defaultContentInsets: UIEdgeInsets = .zero) {
        self.viewController = viewController
        self.scrollView = scrollView
        self.defaultContentInsets = defaultContentInsets
    }

    deinit {
        removeObservers()
    }

    public func start() -> KeyboardFriendlyScrollController {
        addObservers()
        return self
    }

    private func addObservers() {
        let keyboardWasShownObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) { [weak self] notification in
            self?.keyboardWasShown(notification)
        }
        let keyboardWillBeHiddenObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { [weak self] notification in
            self?.keyboardWillBeHidden(notification)
        }
        keyboardObservers = [keyboardWasShownObserver, keyboardWillBeHiddenObserver]
    }

    private func removeObservers() {
        keyboardObservers.forEach { NotificationCenter.default.removeObserver($0) }
    }

    private func keyboardWasShown(_ notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        currentState = .shown(keyboardFrame: keyboardFrame)
        adjustScrollViewInsets()
    }

    private func keyboardWillBeHidden(_ notification: Notification) {
        currentState = .hidden
        adjustScrollViewInsets()
    }

    private func adjustScrollViewInsets() {
        switch currentState {
        case .shown(let keyboardFrame):
            guard let view = viewController?.view, let window = view.window else { return }
            let scrollViewAbsoluteFrame = view.convert(scrollView.frame, to: nil)
            let overlapHeight = scrollViewAbsoluteFrame.maxY - (window.bounds.height - keyboardFrame.height)
            if overlapHeight > 0 {
                var contentInsets = defaultContentInsets
                contentInsets.bottom += overlapHeight
                scrollView.contentInset = contentInsets
                scrollView.scrollIndicatorInsets = contentInsets
            }
        case .hidden:
            scrollView.contentInset = defaultContentInsets
            scrollView.scrollIndicatorInsets = defaultContentInsets
        }
    }
}
