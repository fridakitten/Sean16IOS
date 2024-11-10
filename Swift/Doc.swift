//
// Doc.swift
//
// Created by SeanIsNotAConstant on 08.11.24
//
 
import Foundation

// Function to get the Documents directory path
func getDocumentsDirectory() -> URL? {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths.first
}

// Function to create "main.asm" in the Documents directory if it doesn't exist
func createMainASMFile() {
    guard let documentsDirectory = getDocumentsDirectory() else {
        print("Could not find the Documents directory.")
        return
    }
    
    let filePath = documentsDirectory.appendingPathComponent("main.asm")
    
    // Check if file already exists
    if !FileManager.default.fileExists(atPath: filePath.path) {
        // Create an empty file
        FileManager.default.createFile(atPath: filePath.path, contents: nil, attributes: nil)
        print("File created at \(filePath.path)")
    } else {
        print("File already exists at \(filePath.path)")
    }
}