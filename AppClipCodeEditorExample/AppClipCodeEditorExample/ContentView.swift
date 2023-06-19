//
//  ContentView.swift
//  AppClipCodeEditorExample
//
//  Created by Jorge Mattei on 6/19/23.
//

import SwiftUI


struct ContentView: View {

    static var testSVGData: String {
        let url = Bundle.main.url(forResource: "TestSVG", withExtension: "svg")!
        let data = try! Data(contentsOf: url)
        return String(data: data, encoding: .utf8)!
    }

    @StateObject var manager:  ContentManager = .init()

    var body: some View {
        NavigationStack {
            SVGWebView(svgText: .constant(ContentView.testSVGData), currentSVG: manager.currentSVG)
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button("Save Image") {
                            manager.currentSVG.value?.saveToPhotoLibrary()
                        }
                    }
                }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
