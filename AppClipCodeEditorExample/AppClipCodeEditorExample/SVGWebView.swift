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
    @Binding var screenshotSize: CGFloat
    var currentSVG: CurrentValueSubject<UIImage?,Never>

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero)
        let newSVG = type.replace(svg: svgText)
        webView.loadHTMLString(newSVG, baseURL: nil)
        context.coordinator.screenshotWebView = context.coordinator.createScreenshotWebView()
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.scrollView.backgroundColor = .clear
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.scrollView.isScrollEnabled = false
        context.coordinator.webView  = webView
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        context.coordinator.type = type
        context.coordinator.screenshotSize = screenshotSize
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(svgText: self.svgText, type: self.type, screenshotSize: screenshotSize, currentSVG: self.currentSVG)
    }

    class Coordinator: NSObject, WKNavigationDelegate {

        var webView: WKWebView!
        var screenshotWebView : WKWebView!

        var svgText: String
        var screenshotSize: CGFloat
        var type: AppClipCodeTheme {
            didSet {
                let newSVG = type.replace(svg: svgText)
                webView.loadHTMLString(newSVG, baseURL: nil)
                screenshotWebView = createScreenshotWebView()
            }
        }

        var currentSVG: CurrentValueSubject<UIImage?,Never>


        init(svgText: String,
             type: AppClipCodeTheme,
             screenshotSize: CGFloat,
             currentSVG: CurrentValueSubject<UIImage?,Never>) {
            self.currentSVG = currentSVG
            self.svgText = svgText
            self.type = type
            self.screenshotSize = screenshotSize
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

        func createScreenshotWebView() -> WKWebView {
            let scale = UIScreen.main.scale
            let webView = WKWebView(frame: .init(origin: .zero, size: .init(width: screenshotSize/scale, height: screenshotSize/scale)))
            let newSVG = type.replace(svg: svgText)
            webView.loadHTMLString(newSVG, baseURL: nil)
            webView.isOpaque = false
            webView.backgroundColor = UIColor.clear
            webView.scrollView.backgroundColor = .clear
            webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            webView.scrollView.isScrollEnabled = false
            webView.navigationDelegate = self
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
        SVGWebView(svgText: testSVGData, type: .constant(.index0), screenshotSize: .constant(1024.0), currentSVG: .init(nil))
            .frame(width: 250, height: 250, alignment: .center)
    }
}
