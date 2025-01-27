// Copyright 2018 The Outline Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  static let kAppGroup = "36S5Q8S4V5.com.binary.outline.macos.client"

  func applicationDidFinishLaunching(_ aNotification: Notification) {
   defer {
     NSApp.terminate(self)
   }
    let connectionStore = OutlineConnectionStore(appGroup: AppDelegate.kAppGroup)
    if connectionStore.status != OutlineConnection.ConnectionStatus.connected {
      return NSLog("Not lauching, Binary.com VPN not connected at shutdown")
    }
    // Retrieve the main app's bundle ID programmatically from the embedded launcher bundle ID.
    guard let launcherBundleId = Bundle.main.bundleIdentifier else {
      return NSLog("Failed to retrieve the bundle ID for the main app.")
    }
    let mainAppBundleId = (launcherBundleId as NSString).deletingPathExtension
    NSLog("Launching app: \(mainAppBundleId) from \(launcherBundleId)")
    let descriptor = NSAppleEventDescriptor(string: launcherBundleId)
    NSWorkspace.shared.launchApplication(withBundleIdentifier: mainAppBundleId,
                                         options: [.withoutActivation, .andHide],
                                         additionalEventParamDescriptor: descriptor,
                                         launchIdentifier: nil)
  }
}
