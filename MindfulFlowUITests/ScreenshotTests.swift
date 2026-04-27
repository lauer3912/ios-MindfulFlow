import XCTest

final class ScreenshotTests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["--uitesting"]
        app.launch()
        usleep(1000000)
    }

    override func tearDownWithError() throws {
        app.terminate()
    }

    // MARK: - Helper

    private func capture(_ name: String) {
        let path = "/tmp/\(name).png"
        let data = app.windows.firstMatch.screenshot().pngRepresentation
        try? data.write(to: URL(fileURLWithPath: path))
        print("Captured: \(path)")
    }

    // MARK: - iPhone 6.9" (iPhone 16 Pro Max)

    func testiPhone_69_01_Home() {
        capture("iPhone_69_portrait_01_Home")
    }

    func testiPhone_69_02_Library() {
        if app.tabBars.buttons.count > 1 {
            app.tabBars.buttons.element(boundBy: 1).tap()
            usleep(1500000)
        }
        capture("iPhone_69_portrait_02_Library")
    }

    func testiPhone_69_03_Stats() {
        if app.tabBars.buttons.count > 2 {
            app.tabBars.buttons.element(boundBy: 2).tap()
            usleep(1500000)
        }
        capture("iPhone_69_portrait_03_Stats")
    }

    func testiPhone_69_04_Profile() {
        if app.tabBars.buttons.count > 3 {
            app.tabBars.buttons.element(boundBy: 3).tap()
            usleep(1500000)
        }
        capture("iPhone_69_portrait_04_Profile")
    }

    // MARK: - iPhone 6.5" (iPhone 14 Plus)

    func testiPhone_65_01_Home() {
        capture("iPhone_65_portrait_01_Home")
    }

    func testiPhone_65_02_Library() {
        if app.tabBars.buttons.count > 1 {
            app.tabBars.buttons.element(boundBy: 1).tap()
            usleep(1500000)
        }
        capture("iPhone_65_portrait_02_Library")
    }

    func testiPhone_65_03_Stats() {
        if app.tabBars.buttons.count > 2 {
            app.tabBars.buttons.element(boundBy: 2).tap()
            usleep(1500000)
        }
        capture("iPhone_65_portrait_03_Stats")
    }

    func testiPhone_65_04_Profile() {
        if app.tabBars.buttons.count > 3 {
            app.tabBars.buttons.element(boundBy: 3).tap()
            usleep(1500000)
        }
        capture("iPhone_65_portrait_04_Profile")
    }

    // MARK: - iPhone 6.3" (iPhone 16 Pro)

    func testiPhone_63_01_Home() {
        capture("iPhone_63_portrait_01_Home")
    }

    func testiPhone_63_02_Library() {
        if app.tabBars.buttons.count > 1 {
            app.tabBars.buttons.element(boundBy: 1).tap()
            usleep(1500000)
        }
        capture("iPhone_63_portrait_02_Library")
    }

    func testiPhone_63_03_Stats() {
        if app.tabBars.buttons.count > 2 {
            app.tabBars.buttons.element(boundBy: 2).tap()
            usleep(1500000)
        }
        capture("iPhone_63_portrait_03_Stats")
    }

    func testiPhone_63_04_Profile() {
        if app.tabBars.buttons.count > 3 {
            app.tabBars.buttons.element(boundBy: 3).tap()
            usleep(1500000)
        }
        capture("iPhone_63_portrait_04_Profile")
    }

    // MARK: - iPad 13" (iPad Pro 13-inch M4)

    func testiPad_13_01_Home() {
        if app.buttons["Home"].exists {
            app.buttons["Home"].firstMatch.tap()
            usleep(1500000)
        }
        capture("iPad_13_portrait_01_Home")
    }

    func testiPad_13_02_Library() {
        if app.buttons["Library"].exists {
            app.buttons["Library"].firstMatch.tap()
            usleep(1500000)
        }
        capture("iPad_13_portrait_02_Library")
    }

    func testiPad_13_03_Stats() {
        if app.buttons["Stats"].exists {
            app.buttons["Stats"].firstMatch.tap()
            usleep(1500000)
        }
        capture("iPad_13_portrait_03_Stats")
    }

    func testiPad_13_04_Profile() {
        if app.buttons["Profile"].exists {
            app.buttons["Profile"].firstMatch.tap()
            usleep(1500000)
        }
        capture("iPad_13_portrait_04_Profile")
    }

    // MARK: - iPad 11" (iPad Pro 11-inch M4)

    func testiPad_11_01_Home() {
        if app.buttons["Home"].exists {
            app.buttons["Home"].firstMatch.tap()
            usleep(1500000)
        }
        capture("iPad_11_portrait_01_Home")
    }

    func testiPad_11_02_Library() {
        if app.buttons["Library"].exists {
            app.buttons["Library"].firstMatch.tap()
            usleep(1500000)
        }
        capture("iPad_11_portrait_02_Library")
    }

    func testiPad_11_03_Stats() {
        if app.buttons["Stats"].exists {
            app.buttons["Stats"].firstMatch.tap()
            usleep(1500000)
        }
        capture("iPad_11_portrait_03_Stats")
    }

    func testiPad_11_04_Profile() {
        if app.buttons["Profile"].exists {
            app.buttons["Profile"].firstMatch.tap()
            usleep(1500000)
        }
        capture("iPad_11_portrait_04_Profile")
    }
}