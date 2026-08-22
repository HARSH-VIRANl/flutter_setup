#!/usr/bin/env bash
set -euo pipefail

# ─────────────────────────────────────────────────────────────────────────────
#  Flutter BLoC Project Setup — by Harsh 🚀
#  Run this from your Flutter project root:
#    bash setup.sh
# ─────────────────────────────────────────────────────────────────────────────

REPO_URL="https://github.com/HARSH-VIRANl/flutter_setup.git"
REPO_DIR="flutter_setup"
BRANCH="main"
BRICK_PATH="$REPO_DIR/bricks/cl_bloc"
PAGE_BRICK_PATH="$REPO_DIR/bricks/cl_page"

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║   Hello, this is Harsh calling 🚀        ║"
echo "║   Flutter BLoC Project Setup             ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# ── 1. Prerequisites Check ───────────────────────────────────────────────────

if ! command -v dart &> /dev/null; then
  echo "❌ Dart SDK not found in PATH."
  echo "   Install Flutter → https://flutter.dev/docs/get-started/install"
  exit 1
fi

if ! command -v flutter &> /dev/null; then
  echo "❌ Flutter SDK not found in PATH."
  echo "   Install Flutter → https://flutter.dev/docs/get-started/install"
  exit 1
fi

echo "✅ $(dart --version 2>&1 | head -n1)"
echo "✅ $(flutter --version 2>&1 | head -n1)"
echo ""

# ── 2. Flutter project guard ──────────────────────────────────────────────────

if [ ! -f "./pubspec.yaml" ]; then
  echo "❌ No pubspec.yaml found."
  echo "   Run this script from your Flutter project root."
  echo "   Example:  cd my_app  then  bash setup.sh"
  exit 1
fi

PROJECT_NAME=$(grep '^name:' ./pubspec.yaml | awk '{print $2}')
echo "✅ Flutter project detected: '$PROJECT_NAME'"
echo ""

# ── 3. Cleanup trap ───────────────────────────────────────────────────────────

cleanup() {
  if [ -d "$REPO_DIR" ]; then
    echo ""
    echo "🧹 Cleaning up..."
    rm -rf "$REPO_DIR"
  fi
}
trap cleanup EXIT

# ── 4. Install Mason CLI ──────────────────────────────────────────────────────

echo "📦 Installing Mason CLI..."
dart pub global activate mason_cli

# Make sure pub global bin is in PATH
export PATH="$PATH:$HOME/.pub-cache/bin"
export PATH="$PATH:$LOCALAPPDATA/Pub/Cache/bin"
MASON_CMD="dart pub global run mason_cli:mason"

echo "✅ Mason CLI ready."
echo ""

# ── 5. Clone the brick repository ────────────────────────────────────────────

echo "📥 Cloning brick repository..."
if ! git clone --depth=1 -b "$BRANCH" "$REPO_URL" "$REPO_DIR" 2>&1; then
  echo "❌ Failed to clone repository."
  echo "   Check your internet connection."
  echo "   Repo: $REPO_URL  Branch: $BRANCH"
  exit 1
fi
echo "✅ Repository ready."
echo ""

# ── 6. Register bricks globally (safe for re-runs) ───────────────────────────

echo "🧱 Registering 'cl_bloc' and 'cl_page' bricks..."
$MASON_CMD remove -g cl_bloc 2>/dev/null || true
$MASON_CMD add -g cl_bloc --path "$BRICK_PATH"
$MASON_CMD remove -g cl_page 2>/dev/null || true
$MASON_CMD add -g cl_page --path "$PAGE_BRICK_PATH"
echo "✅ Bricks registered."
echo ""

# ── 7. Generate project (overwrite conflicts automatically) ───────────────────

echo "⚙️  Generating project structure..."
echo "   (This installs dependencies — may take 1–2 minutes)"
echo ""
$MASON_CMD make cl_bloc --on-conflict overwrite

echo ""
echo "╔═══════════════════════════════════════════════════════╗"
echo "║  ✅ Setup complete! Your Flutter project is ready.    ║"
echo "║                                                        ║"
echo "║  What was installed:                                   ║"
echo "║    ✦ BLoC state management                             ║"
echo "║    ✦ Built-in Light & Dark theme                       ║"
echo "║    ✦ English ↔ हिंदी language switch                   ║"
echo "║    ✦ App Drawer (dark mode + language toggle)          ║"
echo "║    ✦ Home page + Settings page                         ║"
echo "║    ✦ Dependency injection (GetIt)                      ║"
echo "║    ✦ Network layer (Dio)                               ║"
echo "║    ✦ Localization (flutter_intl)                       ║"
echo "║    ✦ Custom fonts (ProzaLibre, OpenSans)               ║"
echo "║    ✦ Git pre-commit hooks                              ║"
echo "║    ✦ CI/CD (GitHub Actions)                            ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo ""
echo "  Next steps:"
echo "  1. Open project in VS Code / Android Studio"
echo "  2. Run:  flutter pub get"
echo "  3. Run:  flutter run"
echo ""
