// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Escargot",
	dependencies: [
		.package(url: "https://github.com/scinfu/SwiftSoup.git", from: "1.7.4"),
	],
	targets: [
		.target( name: "Escargot", dependencies: ["SwiftSoup"], path: "Escargot"),
	]
)
