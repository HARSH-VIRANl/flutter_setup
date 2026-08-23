# Core Package (`features/core`)

The **Core Package** contains shared foundations, centralized image asset management, network services, design systems, base widgets, and utilities used across all feature modules in the monorepo.

---

## 🎨 Centralized Image Asset Management (`flutter_gen`)

All static images, SVGs, and Lottie animations are managed centrally in `features/core/assets/` and generated into type-safe Dart classes using `flutter_gen`.

### 1. Asset Folder Structure
```text
features/core/assets/
├── anim/            # Lottie animations (.json)
├── images/          # Raster images (.png, .jpg, .webp, 2.0x, 3.0x)
│   ├── 2.0x/
│   ├── 3.0x/
│   └── back.png
└── svg/             # Vector icons (.svg)
```

### 2. Generating Assets
When adding new images to `features/core/assets/images/`, generate the type-safe classes with Melos:

```bash
# Generate assets once
melos run gen:assets

# Or run in watch mode during development
melos run gen:assets:watch
```

### 3. Using Generated Assets Anywhere Across the Monorepo

All assets are configured with `package = 'core'` by default in `AssetGenImage`, so they work out-of-the-box in any feature module without needing manual package prefixes.

```dart
import 'package:core/core_exports.dart';

// 1. Render as Image widget:
Assets.images.back.image(
  width: 24.w,
  height: 24.w,
  fit: BoxFit.cover,
);

// 2. Use as ImageProvider (e.g. CircleAvatar or BoxDecoration):
CircleAvatar(
  backgroundImage: Assets.images.back.provider(),
);

Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: Assets.images.back.provider(),
      fit: BoxFit.cover,
    ),
  ),
);

// 3. Access raw asset path:
final String imagePath = Assets.images.back.path;
```

---

## 🌐 Networking Layer

### `BaseApiProvider` & `ResponseHandler`
- Provides typed HTTP methods (`getMethod`, `postMethod`, `putMethod`, `deleteMethod`, `multipartPost`)
- **`tryParseList<T>`**: Safely parses a dynamic JSON list into a strongly typed `List<T>` without failing the entire request if one item fails.

---

## 📦 How to Use in Features
Add `core` dependency in your feature's `pubspec.yaml`:
```yaml
dependencies:
  core:
    path: ../core
```
Then import everything with a single import:
```dart
import 'package:core/core_exports.dart';
```
