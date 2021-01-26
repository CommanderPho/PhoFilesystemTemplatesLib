import Cocoa
import PhoFilesystemTemplatesLib


func example1() -> FilesystemTemplate {
	// Example of an NSCS 344 Assignment Folder
	let Handouts = FilesystemNode("Handouts", children: [])


	let figureEPSFolder = FilesystemNode("eps", children: [])
	let figureFolder = FilesystemNode("Figures", children: [figureEPSFolder])
	let codeHelpersFolder = FilesystemNode("Helpers", children: [])
	let codeFolder = FilesystemNode("Code", children: [codeHelpersFolder, figureFolder])

	let submissionFolder = FilesystemNode("Submission", children: [figureFolder, codeFolder])


	let photexFigureSymlink = SymlinkNode("Figures", target: figureFolder)
	let photexFolder = FilesystemNode("photex", children: [photexFigureSymlink])


	let exampleRootNode = FilesystemNode("Week_07", children: [Handouts, photexFolder, submissionFolder])

	//New Template Example
	//let examplePath = URL(fileURLWithPath: "/Users/pho/Dropbox/Classes/NSCS 344/Assignments/")
	let examplePath = URL(fileURLWithPath: "/Users/pho/Desktop/Classes/NSCS 344/Assignments/")


	let newTemplate = FilesystemTemplate(rootNode: exampleRootNode, defaultDeployPath: examplePath)

	return newTemplate
}


//func xcodeFolderHierarchyTemplate() -> FilesystemTemplate {
//
//	let exampleRootNode = FilesystemNode("root", children: [])
//	let newTemplate = FilesystemTemplate(rootNode: exampleRootNode, defaultPath: examplePath)
//
//	return newTemplate
//}


func deployNsciFolders() {
	let outFolder = URL(fileURLWithPath: "/Users/pho/Dropbox/Classes/Spring 2020", isDirectory: true)

	ExampleTemplates.deployUMichClassFolder(withName: "NSCI 700 - Seminar", to: outFolder)
	ExampleTemplates.deployUMichClassFolder(withName: "NSCI 614 - Sensory Systems NSCI", to: outFolder)
}

//
//let template = example1()
//
//template
//
////let extantContents = try FileManager.default.contentsOfDirectory(at: examplePath, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
////newTemplate.deploy()
//
//try template.validate()


deployNsciFolders()


