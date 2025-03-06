//
//  ViewController.swift
//  MHAheroRandomizer
//
//  Created by Дина Абитова on 06.03.2025.
//
import UIKit
import SwiftUI

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let heroView = HeroRandomizer() // Создаем SwiftUI View
        let hostingController = UIHostingController(rootView: heroView) // Встраиваем SwiftUI в UIKit

        addChild(hostingController) // Добавляем в UIKit-контроллер
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
}
