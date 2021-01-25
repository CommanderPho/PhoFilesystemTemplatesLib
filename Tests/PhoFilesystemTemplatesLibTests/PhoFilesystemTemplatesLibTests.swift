import XCTest
@testable import PhoFilesystemTemplatesLib

final class PhoFilesystemTemplatesLibTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

		// Example of an NSCS 344 Assignment Folder
		let Handouts = FilesystemNode(name: "Handouts", children: [])


		let figureEPSFolder = FilesystemNode(name: "eps", children: [])
		let figureFolder = FilesystemNode(name: "Figures", children: [figureEPSFolder])
		let codeHelpersFolder = FilesystemNode(name: "Helpers", children: [])
		let codeFolder = FilesystemNode(name: "Code", children: [codeHelpersFolder, figureFolder])

		let submissionFolder = FilesystemNode(name: "Submission", children: [figureFolder, codeFolder])


		let photexFigureSymlink = SymlinkNode(name: "Figures", target: figureFolder)
		let photexFolder = FilesystemNode(name: "photex", children: [photexFigureSymlink])


		let exampleRootNode = FilesystemNode(name: "Week_07", children: [Handouts, photexFolder, submissionFolder])

		//New Template Example
		//let examplePath = URL(fileURLWithPath: "/Users/pho/Dropbox/Classes/NSCS 344/Assignments/")
		let examplePath = URL(fileURLWithPath: "/Users/pho/Desktop/Classes/NSCS 344/Assignments/")


		let newTemplate = FilesystemTemplate(rootNode: exampleRootNode, defaultPath: examplePath)


		//TODO: Write the test
		do {
		let extantContents = try FileManager.default.contentsOfDirectory(at: examplePath, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
		newTemplate.deploy()
		}
		catch let error {
			XCTAssertNil(error, "Failed with error \(error).")
		}
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
