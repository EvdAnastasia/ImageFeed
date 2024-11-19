//
//  ProfileViewTests.swift
//  ImageFeedTests
//
//  Created by Anastasiia on 19.11.2024.
//

@testable import ImageFeed
import XCTest

final class ProfileViewTests: XCTestCase {
    func testViewControllerCallsViewDidLoad() {
        //given
        let viewController = ProfileViewController()
        let presenter = ProfileViewPresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController
        
        //when
        _ = viewController.view
        
        //then
        XCTAssertTrue(presenter.viewDidLoadCalled) //behaviour verification
    }
    
    func testUpdateProfileDetails() {
        //given
        let viewController = ProfileViewControllerSpy()
        let presenter = ProfileViewPresenter()
        let profile = Profile(username: "username", firstName: "firstName", lastName: nil, bio: nil)
        viewController.presenter = presenter
        presenter.view = viewController
        
        //when
        viewController.updateProfileDetails(profile: profile)
        
        //then
        XCTAssertTrue(viewController.updateProfileDetailsCalled)
    }
    
    func testUpdateAvatar() {
        //given
        let viewController = ProfileViewControllerSpy()
        let presenter = ProfileViewPresenter()
        let url = URL(string: "https://practicum.yandex.ru/")
        viewController.presenter = presenter
        presenter.view = viewController
        
        //when
        guard let url else { return }
        viewController.updateAvatar(with: url)
        
        //then
        XCTAssertTrue(viewController.updateAvatarCalled)
    }
    
    func testShowExitAlert() {
        //given
        let viewController = ProfileViewControllerSpy()
        let presenter = ProfileViewPresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        
        //when
        presenter.didTapExitButton()
        
        //then
        XCTAssertTrue(viewController.showExitAlertCalled)
    }
}
