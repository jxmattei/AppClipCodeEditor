//
//  SVGWebView.swift
//  AppClipCodeEditorExample
//
//  Created by Jorge Mattei on 6/19/23.
//

import SwiftUI
import WebKit
import AppClipCodeEditor

struct SVGWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView

    @Binding var svgText: String
    let type: AppClipCodeTheme = .index3


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

    func updateUIView(_ uiView: WKWebView, context: Context) { }

    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator()
        return coordinator
    }

    class Coordinator: NSObject, WKNavigationDelegate {

        var webView: WKWebView! {
            didSet {
                webView.navigationDelegate = self
            }
        }

        override init() {
            super.init()
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("finished Navigating")
        }

        func generateImage() async throws -> UIImage {
            return try await webView.takeSnapshot(configuration: nil)
        }
    }
}




struct WebView_Previews: PreviewProvider {


    static var testSVGData: String {
        let url = Bundle.main.url(forResource: "TestSVG", withExtension: "svg")!
        let data = try! Data(contentsOf: url)
        return String(data: data, encoding: .utf8)!
    }
    static var previews: some View {
        SVGWebView(svgText: .constant(testSVGData))
            .frame(width: 250, height: 250, alignment: .center)
    }
}
