import UIKit

public protocol KeyboardFriendlyScrolling: class {
    var keyboardFriendlyScrollView: UIScrollView { get }
    var defaultContentInsets: UIEdgeInsets { get }
    var keyboardObservers: [NSObjectProtocol] { get set }
}

extension KeyboardFriendlyScrolling where Self: UIViewController {
    public var defaultContentInsets: UIEdgeInsets { return .zero }

    public func addKeyboardFriendlyScrollingObserver() {
        removeKeyboardFriendlyScrollingObserver()
        let keyboardWasShownObserver = NotificationCenter.default.addObserver(forName: .UIKeyboardDidShow, object: nil, queue: .main) { [weak self] notification in
            self?.keyboardWasShown(notification)
        }
        let keyboardWillBeHiddenObserver = NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: .main) { [weak self] notification in
            self?.keyboardWillBeHidden(notification)
        }
        keyboardObservers = [keyboardWasShownObserver, keyboardWillBeHiddenObserver]
    }

    public func removeKeyboardFriendlyScrollingObserver() {
        keyboardObservers.forEach { NotificationCenter.default.removeObserver($0) }
    }

    private func keyboardWasShown(_ notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let window = view.window
            else { return }
        let scrollViewAbsoluteFrame = view.convert(keyboardFriendlyScrollView.frame, to: nil)
        let overlapHeight =  scrollViewAbsoluteFrame.maxY - (window.bounds.height - keyboardFrame.height)
        if overlapHeight > 0 {
            var contentInsets = defaultContentInsets
            contentInsets.bottom += overlapHeight
            keyboardFriendlyScrollView.contentInset = contentInsets
            keyboardFriendlyScrollView.scrollIndicatorInsets = contentInsets
        }
    }

    private func keyboardWillBeHidden(_ notification: Notification) {
        keyboardFriendlyScrollView.contentInset = defaultContentInsets
        keyboardFriendlyScrollView.scrollIndicatorInsets = defaultContentInsets
    }
}
