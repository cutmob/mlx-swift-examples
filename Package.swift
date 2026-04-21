// swift-tools-version: 5.9
// NIMBUS FORK — upstream mlx-swift-examples ships a `StableDiffusion`
// target/product that collides with apple/ml-stable-diffusion in the
// SwiftPM graph. This fork strips it.

import PackageDescription

let package = Package(
    name: "mlx-libraries",
    platforms: [.macOS(.v14), .iOS(.v16)],
    products: [
        .library(name: "MLXLLM",       targets: ["MLXLLM"]),
        .library(name: "MLXVLM",       targets: ["MLXVLM"]),
        .library(name: "MLXLMCommon",  targets: ["MLXLMCommon"]),
        .library(name: "MLXMNIST",     targets: ["MLXMNIST"]),
        .library(name: "MLXEmbedders", targets: ["MLXEmbedders"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ml-explore/mlx-swift", .upToNextMinor(from: "0.29.1")),
        .package(url: "https://github.com/huggingface/swift-transformers", .upToNextMinor(from: "1.0.0")),
        .package(url: "https://github.com/1024jp/GzipSwift", "6.0.1" ... "6.0.1"),
    ],
    targets: [
        .target(
            name: "MLXLLM",
            dependencies: [
                "MLXLMCommon",
                .product(name: "MLX",           package: "mlx-swift"),
                .product(name: "MLXFast",       package: "mlx-swift"),
                .product(name: "MLXNN",         package: "mlx-swift"),
                .product(name: "MLXOptimizers", package: "mlx-swift"),
                .product(name: "MLXRandom",     package: "mlx-swift"),
                .product(name: "Transformers",  package: "swift-transformers"),
            ],
            path: "Libraries/MLXLLM",
            exclude: ["README.md"],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency")]
        ),
        .target(
            name: "MLXVLM",
            dependencies: [
                "MLXLMCommon",
                .product(name: "MLX",           package: "mlx-swift"),
                .product(name: "MLXFast",       package: "mlx-swift"),
                .product(name: "MLXNN",         package: "mlx-swift"),
                .product(name: "MLXOptimizers", package: "mlx-swift"),
                .product(name: "MLXRandom",     package: "mlx-swift"),
                .product(name: "Transformers",  package: "swift-transformers"),
            ],
            path: "Libraries/MLXVLM",
            exclude: ["README.md"],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency")]
        ),
        .target(
            name: "MLXLMCommon",
            dependencies: [
                .product(name: "MLX",           package: "mlx-swift"),
                .product(name: "MLXNN",         package: "mlx-swift"),
                .product(name: "MLXOptimizers", package: "mlx-swift"),
                .product(name: "MLXRandom",     package: "mlx-swift"),
                .product(name: "MLXLinalg",     package: "mlx-swift"),
                .product(name: "Transformers",  package: "swift-transformers"),
            ],
            path: "Libraries/MLXLMCommon",
            exclude: ["README.md"],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency")]
        ),
        .testTarget(
            name: "MLXLMTests",
            dependencies: [
                .product(name: "MLX",           package: "mlx-swift"),
                .product(name: "MLXNN",         package: "mlx-swift"),
                .product(name: "MLXOptimizers", package: "mlx-swift"),
                .product(name: "MLXRandom",     package: "mlx-swift"),
                .product(name: "Transformers",  package: "swift-transformers"),
                "MLXLMCommon", "MLXLLM", "MLXVLM",
            ],
            path: "Tests/MLXLMTests",
            exclude: ["README.md"],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency")]
        ),
        .target(
            name: "MLXEmbedders",
            dependencies: [
                .product(name: "MLX",          package: "mlx-swift"),
                .product(name: "MLXFast",      package: "mlx-swift"),
                .product(name: "MLXNN",        package: "mlx-swift"),
                .product(name: "Transformers", package: "swift-transformers"),
                .product(name: "MLXLinalg",    package: "mlx-swift"),
                .target(name: "MLXLMCommon"),
            ],
            path: "Libraries/Embedders",
            exclude: ["README.md"]
        ),
        .target(
            name: "MLXMNIST",
            dependencies: [
                .product(name: "MLX",           package: "mlx-swift"),
                .product(name: "MLXFast",       package: "mlx-swift"),
                .product(name: "MLXNN",         package: "mlx-swift"),
                .product(name: "MLXOptimizers", package: "mlx-swift"),
                .product(name: "MLXRandom",     package: "mlx-swift"),
                .product(name: "Transformers",  package: "swift-transformers"),
                .product(name: "Gzip",          package: "GzipSwift"),
            ],
            path: "Libraries/MLXMNIST",
            exclude: ["README.md"],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency")]
        ),
    ]
)
