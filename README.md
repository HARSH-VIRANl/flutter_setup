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

| Command | Description | Example |
|---|---|---|
| `bootstrap` | Install dependencies for all packages | `melos run bootstrap` |
| `build:runner` | Run `build_runner` code generation across all packages | `melos run build:runner` |
| `gen:assets` | Generate type-safe assets in `features/core` with `flutter_gen` | `melos run gen:assets` |
| `gen:assets:watch` | Watch and auto-generate assets in `features/core` | `melos run gen:assets:watch` |
| `format` | Format all Dart code | `melos run format` |
| `format:check` | Check formatting for CI without changes | `melos run format:check` |
| `analyze` | Analyze all packages with `--fatal-infos` | `melos run analyze` |
| `fix` | Apply automated Dart fixes | `melos run fix` |
| `test` | Run unit/widget tests across all packages | `melos run test` |
| `test:coverage` | Run tests with coverage reports | `melos run test:coverage` |
| `build:android` | Build release Android APK | `melos run build:android` |
| `build:ios` | Build release iOS app | `melos run build:ios` |
| `gen:page` | Generate BLoC screen in `lib/screens` | `melos run gen:page -- --name profile` |
| `gen:page:dashboard` | Generate BLoC page in `features/dashboard` | `melos run gen:page:dashboard -- --name profile` |
| `gen:page:auth` | Generate BLoC page in `features/auth` | `melos run gen:page:auth -- --name forgot_password` |
| `clean` | Clean build cache across all packages | `melos run clean` |

---

## 🎨 Centralized Image Asset Management (`flutter_gen`)

All images, SVGs, and animations are centralized in `features/core/assets/` and typed via `flutter_gen` with package support enabled out-of-the-box:

1. **Add Images**: Place `.png`, `.jpg`, or `.webp` files in `features/core/assets/images/`.
2. **Generate Dart Classes**:
   ```powershell
   melos run gen:assets
   ```
3. **Use in Any Feature Widget**:
   ```dart
   import 'package:core/core_exports.dart';

   // Render as Image widget:
   Assets.images.back.image(
     width: 24.w,
     height: 24.w,
     fit: BoxFit.cover,
   )

   // Use as ImageProvider:
   CircleAvatar(
     backgroundImage: Assets.images.back.provider(),
   )

   // Access raw asset path:
   final String path = Assets.images.back.path;
   ```

---

## 🧱 Architecture Overview

```
├── lib/                     # Main app entrypoint & root routing
├── features/
│   ├── core/                # Shared UI, assets, themes, networking, DI, localization
│   ├── auth/                # Authentication feature package
│   └── dashboard/           # Dashboard feature package
├── assets/
│   └── fonts/               # ProzaLibre fonts
├── bricks/                  # Mason bricks (cl_bloc, cl_page)
└── pubspec.yaml             # Pub Workspace root + Melos configuration
```

---

## ⚡ Clean Architecture + fpdart API Integration Pattern

The scaffold includes a complete demo feature (`AgencyDashboardPage`) implementing the enterprise `fpdart` pattern:

```
┌──────────────┐     ┌──────────────┐     ┌─────────────────┐     ┌──────────────┐
│  Presentation│ ──> │  AgencyBloc  │ ──> │     UseCase     │ ──> │  Repository  │
│(BaseStateWid)│ <── │   (.fold())  │ <── │Either<Fail,Data>│ <── │(ResponseHand)│
└──────────────┘     └──────────────┘     └─────────────────┘     └──────────────┘
```

1. **Failure Handling**:
   ```dart
   Failure getFailureFromAPI(String message);
   Failure getFailureFromException(dynamic exception);
   ```
2. **UseCase Pattern**:
   ```dart
   class AgencyDashboardUsecase extends UseCase<AgencyDashboardModel, NoParamModelForUseCase> {
     final ProfileRepository profileRepository;
     ...
     @override
     Future<Either<Failure, AgencyDashboardModel>> call(NoParamModelForUseCase params) async {
       final response = await profileRepository.agencyDashboard();
       if (response.isSuccess) {
         return right(AgencyDashboardModel.fromJson(response.result));
       }
       return left(getFailureFromAPI(response.message ?? ""));
     }
   }
   ```
3. **BLoC Event Handler**:
   ```dart
   response.fold(
     (failure) => emit(state.copyWith(status: BaseStateStatus.failure, errorMessage: failure.message)),
     (data) => emit(state.copyWith(status: BaseStateStatus.success, dashboardData: data)),
   );
   ```

---

## 🌐 Internationalization (intl & l10n) Guidelines

All user-facing strings **must** come from ARB files via `S.of(context)` (or `S.current` outside widget trees):

1. **Add keys to ARB files**:
   - `lib/l10n/intl_en.arb` (English)
   - `lib/l10n/intl_hi.arb` (Hindi)
2. **Access in widgets**:
   ```dart
   Text(S.of(context).home);
   Text(S.of(context).welcomeMessage);
   ```
3. **Form Validations**:
   - Use `ValidationMixin` on `BuildContext` which automatically uses localized validation messages.

---

## 🤝 Contributing & Team Guidelines
1. Always use localized strings via `S.of(context)` instead of hardcoded strings.
2. Always run `melos run format` and `melos run analyze` before committing.
3. Pre-commit git hooks are configured to ensure code quality automatically.

