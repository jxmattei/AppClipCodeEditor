//
//  File.swift
//  
//
//  Created by Jorge Mattei on 6/19/23.
//

import Foundation

public enum AppClipCodeTheme: String, CaseIterable {
    case index0
    case index1
    case index2
    case index3
    case index4
    case index5
    case index6
    case index7
    case index8
    case index9
    case index10
    case index11
    case index12
    case index13
    case index14
    case index15
    case index16
    case index17

    public func replace(svg: String) -> String {
        var newSVG = svg

        //Circle
        newSVG = { () -> String in
            let regex = "<circle(.*)fill:#\\w+"
            let toRegex = "<circle$1fill:\(circleColorHex)"
            return newSVG.replacingOccurrences(of: regex, with: toRegex, options: [.regularExpression])
        }()

        //Primary
        newSVG = { () -> String in
            let regex = "<path(.*)data-color=\"0\"(.*)stroke:#\\w+"
            let toRegex = "<path$1data-color=\"0\"$2stroke:\(primaryColorHex)"
            return newSVG.replacingOccurrences(of: regex, with: toRegex, options: [.regularExpression])
        }()

        //Secondary
        newSVG = { () -> String in
            let regex = "<path(.*)data-color=\"1\"(.*)stroke:#\\w+"
            let toRegex = "<path$1data-color=\"1\"$2stroke:\(secondaryColorHex)"
            return newSVG.replacingOccurrences(of: regex, with: toRegex, options: [.regularExpression])
        }()

        //Camera
        newSVG = { () -> String in
            let regex = "<path(.*)fill:#\\w+"
            let toRegex = "<path$1fill:\(cameraColorHex)"
            return newSVG.replacingOccurrences(of: regex, with: toRegex, options: [.regularExpression])
        }()

        return newSVG
    }

    var primaryColorHex:String {
        return CodeElement.primary.hexColor(for: self)
    }

    var secondaryColorHex: String {
        return CodeElement.secondary.hexColor(for: self)
    }

    var circleColorHex: String {
        return CodeElement.circle.hexColor(for: self)
    }

    var cameraColorHex: String {
        return CodeElement.camera.hexColor(for: self)
    }

    public enum CodeElement {
        case circle
        case primary
        case secondary
        case camera

        public func hexColor(for theme: AppClipCodeTheme) -> String {
            switch self {
            case .circle:
                switch theme {
                    case .index0:  return "#000000"
                    case .index1:  return "#ffffff"
                    case .index2:  return "#777777"
                    case .index3:  return "#ffffff"
                    case .index4:  return "#ff3b30"
                    case .index5:  return "#ffffff"
                    case .index6:  return "#ee7733"
                    case .index7:  return "#ffffff"
                    case .index8:  return "#33aa22"
                    case .index9:  return "#ffffff"
                    case .index10: return "#00a6a1"
                    case .index11: return "#ffffff"
                    case .index12: return "#007aff"
                    case .index13: return "#ffffff"
                    case .index14: return "#5856d6"
                    case .index15: return "#ffffff"
                    case .index16: return "#cc73e1"
                    case .index17: return "#ffffff"
                }
            case .primary:
                switch theme {

                    case .index0:  return "#ffffff"
                    case .index1:  return "#000000"
                    case .index2:  return "#ffffff"
                    case .index3:  return "#777777"
                    case .index4:  return "#ffffff"
                    case .index5:  return "#ff3b30"
                    case .index6:  return "#ffffff"
                    case .index7:  return "#ee7733"
                    case .index8:  return "#ffffff"
                    case .index9:  return "#33aa22"
                    case .index10: return "#ffffff"
                    case .index11: return "#00a6a1"
                    case .index12: return "#ffffff"
                    case .index13: return "#007aff"
                    case .index14: return "#ffffff"
                    case .index15: return "#5856d6"
                    case .index16: return "#ffffff"
                    case .index17: return "#cc73e1"
                }
            case .secondary:
                switch theme {
                    case .index0:  return "#888888"
                    case .index1:  return "#888888"
                    case .index2:  return "#aaaaaa"
                    case .index3:  return "#aaaaaa"
                    case .index4:  return "#ff9999"
                    case .index5:  return "#ff9999"
                    case .index6:  return "#eebb88"
                    case .index7:  return "#eebb88"
                    case .index8:  return "#99dd99"
                    case .index9:  return "#99dd99"
                    case .index10: return "#88ddcc"
                    case .index11: return "#88ddcc"
                    case .index12: return "#77bbff"
                    case .index13: return "#77bbff"
                    case .index14: return "#bbbbee"
                    case .index15: return "#bbbbee"
                    case .index16: return "#eebbee"
                    case .index17: return "#eebbee"
                }

            case .camera:
                switch theme {
                    case .index0:  return "#ffffff"
                    case .index1:  return "#000000"
                    case .index2:  return "#ffffff"
                    case .index3:  return "#777777"
                    case .index4:  return "#ffffff"
                    case .index5:  return "#ff3b30"
                    case .index6:  return "#ffffff"
                    case .index7:  return "#ee7733"
                    case .index8:  return "#ffffff"
                    case .index9:  return "#33aa22"
                    case .index10: return "#ffffff"
                    case .index11: return "#00a6a1"
                    case .index12: return "#ffffff"
                    case .index13: return "#007aff"
                    case .index14: return "#ffffff"
                    case .index15: return "#5856d6"
                    case .index16: return "#ffffff"
                    case .index17: return "#cc73e1"
                }
            }
        }
    }
}
