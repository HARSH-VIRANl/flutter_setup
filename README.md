# 🚀 Flutter BLoC Project Scaffold & Monorepo Setup

A production-ready Flutter BLoC project scaffold powered by [Mason](https://github.com/felangel/mason), [Dart Workspaces](https://dart.dev/tools/pub/workspaces), and [Melos](https://melos.invertase.dev/).

---

## 📌 Why Modern Pub Workspaces + Melos 8+?

In modern Flutter & Dart (Dart 3.5+) and Melos 7.0+ / 8.0+:
- **Pub Workspaces Migration**: Dart introduced native monorepo workspace support via the `workspace:` property in `pubspec.yaml`.
- **melos.yaml Deprecation**: When using Pub Workspaces, Melos 7+ & 8+ migrated its configuration directly into the root `pubspec.yaml` under the `melos:` key and requires `melos` in `dev_dependencies`.
- **Zero Manual Configuration**: Because the workspace and Melos configurations are committed directly into `pubspec.yaml`, new developers can clone and run without encountering:
  - `Your current directory does not appear to be within a Melos workspace`
  - `NoScriptException: This workspace has no scripts defined in its 'pubspec.yaml' file.`

---

## 🛠️ Quick Start Guide

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (latest stable)
- [Dart SDK](https://dart.dev/get-dart) (Dart 3.6+)
- [Melos CLI](https://pub.dev/packages/melos) (v8+)

---

### One-Click Automated Setup

#### On Windows:
Double-click `setup.bat` or run in CMD / PowerShell:
```cmd
setup.bat
```

#### On macOS / Linux:
Run in your terminal:
```bash
bash setup.sh
```

---

### Manual Step-by-Step Setup

#### Step 1: Install Melos & Mason CLI Globally
```powershell
dart pub global activate melos
dart pub global activate mason_cli
```

#### Step 2: Install Workspace Dependencies
From the project root:
```powershell
flutter pub get
```
> **Note**: Because this project uses Dart Workspaces, `flutter pub get` at the root automatically resolves and links all feature packages (`core`, `auth`, `dashboard`).

#### Step 3: Run Melos Commands
To view and run all available tasks interactively:
```powershell
melos run
```

Or execute commands directly:
| Command | Description |
|---|---|
| `melos run build:runner` | Run `build_runner` code generation across all packages |
| `melos run format` | Format all Dart code |
| `melos run analyze` | Analyze all packages with `--fatal-infos` |
| `melos run test` | Run tests across all workspace packages |
| `melos run test:coverage` | Run tests with code coverage |
| `melos run fix` | Apply automated Dart fixes |
| `melos run gen:page` | Generate a new BLoC screen/feature via `cl_page` brick |

---

## 🧱 Architecture Overview

```
├── lib/                     # Main app entrypoint & root routing
├── features/
│   ├── core/                # Shared UI, themes, networking, DI, localization
│   ├── auth/                # Authentication feature package
│   └── dashboard/           # Dashboard feature package
├── assets/
│   └── fonts/               # ProzaLibre & OpenSans fonts
├── bricks/                  # Mason bricks (cl_bloc, cl_page)
└── pubspec.yaml             # Pub Workspace root + Melos configuration
```

---

## 🤝 Contributing & Team Guidelines
1. Always run `melos run format` and `melos run analyze` before committing.
2. Pre-commit git hooks are configured to ensure code quality automatically.
