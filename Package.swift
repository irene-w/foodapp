import PackageDescription

let package = Package(
    name: "Project",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2),
        .Package(url: "https://github.com/vapor-community/postgresql-provider.git", majorVersion: 2)
    ]
)
