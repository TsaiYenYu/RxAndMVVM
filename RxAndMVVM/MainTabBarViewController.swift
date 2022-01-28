import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    fileprivate func setupViewController() {

        let mvvmVC = MVVMViewController()
        let navMVVMVC = templateNavController(image: UIImage(systemName: "xmark"), rootViewController: mvvmVC, selectImage: UIImage(systemName: "pencil"))
        navMVVMVC.title = "MVVM"
        let rxVC = RxViewController()
        let navRX = templateNavController(image: UIImage(systemName: "xmark"), rootViewController: rxVC, selectImage: UIImage(systemName: "pencil"))
        navRX.title = "Rx"
        tabBar.unselectedItemTintColor = .blue
        tabBar.tintColor = .red
        tabBar.barTintColor = .orange
        viewControllers = [
            navMVVMVC,
            navRX,
        ]
        
    }
    
    fileprivate func templateNavController(image: UIImage?, rootViewController: UIViewController = UIViewController(), selectImage: UIImage? = nil) -> UINavigationController {
        let viewNavController = UINavigationController(rootViewController: rootViewController)
        if let image = image {
            viewNavController.tabBarItem.image = image
        }
        if let selectImage = selectImage {
            viewNavController.tabBarItem.selectedImage = selectImage
        }
        
        return viewNavController
    }
}
