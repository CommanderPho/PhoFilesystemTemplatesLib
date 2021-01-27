import Foundation
import XCTest
@testable import PhoFilesystemTemplatesLib
import SwiftPackageTestingHelpersLib

final class PhoFilesystemTemplatesLibTests: XCTestCase, OutputFileProducingProtocol {

	static var folderMode: TestFilesMode = .UniqueFolderPerTestClass

	static var rootTestingParentFolder: URL { return URL(fileURLWithPath: "/Users/pho/Desktop/PhoFilesystemTemplatesLib Testing", isDirectory: true); }


//	func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct
//        // results.
//
//		// Example of an NSCS 344 Assignment Folder
//		let Handouts = FilesystemNode("Handouts", children: [])
//
//
//		let figureEPSFolder = FilesystemNode("eps", children: [])
//		let figureFolder = FilesystemNode("Figures", children: [figureEPSFolder])
//		let codeHelpersFolder = FilesystemNode("Helpers", children: [])
//		let codeFolder = FilesystemNode("Code", children: [codeHelpersFolder, figureFolder])
//
//		let submissionFolder = FilesystemNode("Submission", children: [figureFolder, codeFolder])
//
//
//		let photexFigureSymlink = SymlinkNode("Figures", target: figureFolder)
//		let photexFolder = FilesystemNode("photex", children: [photexFigureSymlink])
//
//
//		let exampleRootNode = FilesystemNode("Week_07", children: [Handouts, photexFolder, submissionFolder])
//
//		//New Template Example
//		//let examplePath = URL(fileURLWithPath: "/Users/pho/Dropbox/Classes/NSCS 344/Assignments/")
//		let examplePath = URL(fileURLWithPath: "/Users/pho/Desktop/Classes/NSCS 344/Assignments/")
//
//
//		let newTemplate = FilesystemTemplate(rootNode: exampleRootNode, defaultDeployPath: examplePath)
//
//		//TODO: Write the test
//		do {
//			let extantContents = try FileManager.default.contentsOfDirectory(at: examplePath, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
//			XCTAssertNoThrow(try newTemplate.deploy())
//		}
//		catch let error {
//			XCTAssertNil(error, "Failed with error \(error).")
//		}
//    }

	func testXCodeExample() {
		let root = FilesystemNode("root", children: [
			FilesystemNode("Model"),
			FilesystemNode("Protocols"),
			FilesystemNode("UI", children: [
				FilesystemNode("Storyboards"),
				FilesystemNode("ViewControllers"),
				FilesystemNode("Views"),
				FilesystemNode("WindowControllers")
			])
		])

		let newTemplate = FilesystemTemplate(rootNode: root, templateName: "XCode Hierarchy Template", templateDescription: "Creates the default hierarchy for my custom packages in XCode.")
		XCTAssertThrowsError(try newTemplate.deploy(), "Template was not provided with a deploy path, but did not throw an error on deploy")

		guard let validTestDir = self.getCurrentTestSubdirectory() else {
			fatalError()
		}
//		newTemplate.updateDeployPath(validTestDir)

		// Deploy
		XCTAssertNoThrow(try newTemplate.deploy(specifyingDeployPath: validTestDir))
	}


	func testXCodeDeployToExistingFolderExample() {

		let outFolder = URL(fileURLWithPath: "/Users/pho/repo/PhoQuickLogNote/PhoQuickLogNote", isDirectory: true)
		ExampleTemplates.deployStandardXCodeProjectHierarchyToExtantFolder(to: outFolder)
//		XCTAssertNoThrow(try newTemplate.deploy(specifyingDeployPath: validTestDir))

	}

    static var allTests = [
		("testXCodeDeployToExistingFolderExample", testXCodeDeployToExistingFolderExample),
        ("testXCodeExample", testXCodeExample),
    ]
}
