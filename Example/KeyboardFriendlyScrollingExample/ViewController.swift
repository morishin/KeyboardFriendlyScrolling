import UIKit
import KeyboardFriendlyScrolling

class ViewController: UIViewController, KeyboardFriendlyScrolling {
    @IBOutlet private weak var scrollView: UIScrollView!

    // MARK: KeyboardFriendlyScrolling

    var keyboardObservers: [NSObjectProtocol] = []
    var keyboardFriendlyScrollView: UIScrollView { return scrollView }

    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardFriendlyScrollingObserver()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardFriendlyScrollingObserver()
    }
}

