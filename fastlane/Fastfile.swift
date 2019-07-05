// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile {
	func customLane() {
	desc("Description of what the lane does")
		syncCodeSigning(appIdentifier: ["com.lhp3851.project"], username: "lhp3851@163.com", gitUrl: "https://github.com/lhp3851/Swift_Demo.git")
        buildIosApp()
        uploadToTestflight(username: "lhp3851@icloud.com")
	}
}
