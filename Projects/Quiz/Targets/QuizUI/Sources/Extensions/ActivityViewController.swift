//
//  ActivityViewController.swift
//  QuizUI
//
//  Created by 박소현 on 2023/07/01.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit


public struct ActivityView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    @Environment(\.presentationMode) var presentationMode
    
    public func makeUIViewController(context: Context) -> some UIViewController {
        UIViewController()
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        
        if isPresented && uiViewController.presentedViewController == nil {
            uiViewController.present(activityViewController, animated: true)
        }
        activityViewController.completionWithItemsHandler = { (_, _, _, _) in
            isPresented = false
        }
    }
}
