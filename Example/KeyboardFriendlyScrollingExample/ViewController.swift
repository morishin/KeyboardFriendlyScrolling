import UIKit
import KeyboardFriendlyScrolling

class ViewController: UIViewController {
    private var keyboardFriendlyScrollController: KeyboardFriendlyScrollController?

    @IBOutlet private weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardFriendlyScrollController = KeyboardFriendlyScrollController(viewController: self, scrollView: scrollView).start()
    }
}

