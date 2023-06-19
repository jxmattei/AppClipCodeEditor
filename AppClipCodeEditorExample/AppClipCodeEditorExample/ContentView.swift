//
//  ContentView.swift
//  AppClipCodeEditorExample
//
//  Created by Jorge Mattei on 6/19/23.
//

import SwiftUI
import AppClipCodeEditor


struct ContentView: View {

    static var testSVGData: String {
        let url = Bundle.main.url(forResource: "TestSVG", withExtension: "svg")!
        let data = try! Data(contentsOf: url)
        return String(data: data, encoding: .utf8)!
    }

    @StateObject var manager: ContentManager = .init()
    @State var type: AppClipCodeTheme = .index0


    let columns = [
        GridItem(.fixed(10))
    ]


    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: columns) {
                        ForEach(AppClipCodeTheme.allCases) {  theme in

                            Button {
                                type = theme
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color(uiColor: theme.circleColor))
                                        .shadow(radius: 5)
                                    Circle()
                                        .foregroundColor(Color(uiColor: theme.primaryColor))
                                        .scaleEffect(0.5)

                                }
                            }
                            .frame(width: 20, height: 20, alignment: .center)

                        }
                    }
                }
                .frame(height: 100)
                SVGWebView(svgText: ContentView.testSVGData, type: $type, currentSVG: manager.currentSVG)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
