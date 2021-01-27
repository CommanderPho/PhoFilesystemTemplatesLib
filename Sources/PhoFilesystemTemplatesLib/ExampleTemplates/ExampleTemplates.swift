//
//  ExampleTemplates.swift
//  
//
//  Created by Pho Hale on 1/26/21.
//

import Foundation

public struct ExampleTemplates {



	public static var xCodeHierarchyTemplate: FilesystemTemplate {
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

		return FilesystemTemplate(rootNode: root, templateName: "XCode Hierarchy Template", templateDescription: "Creates the default hierarchy for my custom packages in XCode.")
	}


	public static var umichSemesterClassFolder: FilesystemTemplate {

		let rootFolderNames = ["Exams", "Assignments", "Notes", "Resources and Handouts"]

		let root = FilesystemNode("root", children: [
			FilesystemNode("Exams"),
			FilesystemNode("Assignments"),
			FilesystemNode("Resources and Handouts"),
			FilesystemNode("Notes", children: [
				FilesystemNode("Handwritten Notes")
			])
		])

		return FilesystemTemplate(rootNode: root, templateName: "UMich Graduate Class Hierarchy Template", templateDescription: "Creates the default hierarchy used for a new class.")
	}







	public static func deployStandardXCodeProjectHierarchyToExtantFolder(to: URL) {
		let template = Self.xCodeHierarchyTemplate
//		guard let destParentPath = to.deletingLastPathComponent() else {
//			fatalError("Base path doesn't exist! \(to)")
//		}

		let destParentPath = to.deletingLastPathComponent()
		let currFolderName = to.lastPathComponent
		template.rootNode.name = currFolderName

		do {
			try template.deploy(specifyingDeployPath: destParentPath)
			print("Template written to \(destParentPath)")
		} catch let error {
			fatalError("Failed to create \(destParentPath) template at \(to)! Error: \(error)")
		}
	}




	public static func deployUMichClassFolder(withName name: String, to: URL) {
		let template = Self.umichSemesterClassFolder
		template.rootNode.name = name

		do {
			try template.deploy(specifyingDeployPath: to)
			print("Template written to \(to)")
		} catch let error {
			fatalError("Failed to create \(name) template at \(to)! Error: \(error)")
		}
	}

}
