//
//  SVGWebView.swift
//  AppClipCodeEditorExample
//
//  Created by Jorge Mattei on 6/19/23.
//

import SwiftUI
import WebKit
import AppClipCodeEditor
import UIKit
import Combine

struct SVGWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView

    var svgText: String
    @Binding var type: AppClipCodeTheme
    var currentSVG: CurrentValueSubject<UIImage?,Never>

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero)
        let newSVG = type.replace(svg: svgText)
        webView.loadHTMLString(newSVG, baseURL: nil)
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.scrollView.backgroundColor = .clear
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.scrollView.isScrollEnabled = false
        context.coordinator.webView  = webView
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let newSVG = type.replace(svg: svgText)
        context.coordinator.webView.loadHTMLString(newSVG, baseURL: nil)
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(svgText: self.svgText, type: self.type, currentSVG: self.currentSVG)
    }

    class Coordinator: NSObject, WKNavigationDelegate {

        var webView: WKWebView! {
            didSet {
            }
        }
        lazy var screenshotWebView : WKWebView = {
            let webView = createWebView()
            webView.navigationDelegate = self
            return webView
        }()

        var svgText: String
        var type: AppClipCodeTheme

        var currentSVG: CurrentValueSubject<UIImage?,Never>


        init(svgText: String,
             type: AppClipCodeTheme,
             currentSVG: CurrentValueSubject<UIImage?,Never>) {
            self.currentSVG = currentSVG
            self.svgText = svgText
            self.type = type
            super.init()
            _ = screenshotWebView
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.generateImage()
            }
        }

        @MainActor
        func generateImage() {
            Task {
                let configuration = WKSnapshotConfiguration()
                configuration.afterScreenUpdates = true
                let image =  try await
                screenshotWebView.takeSnapshot(configuration: nil)
                currentSVG.send(image)

            }
        }

        func createWebView() -> WKWebView {
            let scale = UIScreen.main.scale
            let webView = WKWebView(frame: .init(origin: .zero, size: .init(width: 2048/scale, height: 2048/scale)))
            let newSVG = type.replace(svg: svgText)
            webView.loadHTMLString(newSVG, baseURL: nil)
            webView.isOpaque = false
            webView.backgroundColor = UIColor.clear
            webView.scrollView.backgroundColor = .clear
            webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            webView.scrollView.isScrollEnabled = false
            return webView
        }
    }
}


extension UIImage {
    @MainActor
    func saveToPhotoLibrary() {
        let imageData = self.pngData()!
        let pngImage = UIImage(data: imageData)!
        UIImageWriteToSavedPhotosAlbum(pngImage, nil, nil, nil);
    }
}



struct WebView_Previews: PreviewProvider {

    static var testSVGData: String {
        let url = Bundle.main.url(forResource: "TestSVG", withExtension: "svg")!
        let data = try! Data(contentsOf: url)
        return String(data: data, encoding: .utf8)!
    }
    static var previews: some View {
        SVGWebView(svgText: testSVGData, type: .constant(.index0), currentSVG: .init(nil))
            .frame(width: 250, height: 250, alignment: .center)
    }
}
