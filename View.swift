//
// View.swift
//
// Created by SeanIsNotAConstant on 08.11.24
//
 
import SwiftUI

struct sean16View: View {
	@State private var isRunning: Bool = false
	@State private var isEdit: Bool = false
	@State private var filePath: String = ""

	var body: some View {
		VStack {
			#if debug
			NeoLog()
			#endif
			Spacer().frame(height: 25)
				HStack {
					Button( action: {
						DispatchQueue.main.async {
							isRunning = true
						}
						DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
						if let meow: URL = getDocumentsDirectory() {
							filePath = "\(meow.path)/main.asm"
							createMainASMFile()
							serialQueue.async {
							    kickstart("\(filePath)")
							}
						}
					}
					}) {
						ZStack {
							Rectangle()
								.foregroundColor(.green)
								.cornerRadius(15)
							Text("Run")
								.foregroundColor(.white)
						}
					}
					.frame(width: UIScreen.main.bounds.width / 2.4, height: 50)
					Button( action: {
						if let meow: URL = getDocumentsDirectory() {
							filePath = "\(meow.path)/main.asm"
							createMainASMFile()
							setTheme(0)
							storeTheme()
							isEdit = true
						}
					}) {
						ZStack {
							Rectangle()
								.foregroundColor(.orange)
								.cornerRadius(15)
							Text("Edit")
								.foregroundColor(.white)
						}
					}
					.frame(width: UIScreen.main.bounds.width / 2.4, height: 50)
				}
				.sheet(isPresented: $isEdit) {
					NeoEditorHelper(isPresented: $isEdit, filepath: $filePath)
				}
				.fullScreenCover(isPresented: $isRunning) {
					ScreenEmulator()
						.ignoresSafeArea()
						.contextMenu {
							Button("Exit") {
								isRunning = false
								send_cpu(1);
							}
						}
				}
			}
	}
}