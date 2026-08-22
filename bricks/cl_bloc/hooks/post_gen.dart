import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  await _writePubspecConfig(context);
  await _installDependencies(context);
  await _runDartFormat(context);
  await _runDartFix(context);
  await _runGitScript(context);
}

/// Rewrites pubspec.yaml in one pass:
///   1. Injects `workspace:` configuration for multi-package architecture
///   2. Injects workspace feature dependencies (`core`, `auth`, `dashboard`) under `dependencies:`
///   3. Injects font + asset declarations after `uses-material-design`
///   4. Normalizes `flutter_lints` constraint to caret range (^5.0.0) to prevent resolution conflicts
///   5. Appends `flutter_intl:` config block at the end
Future<void> _writePubspecConfig(HookContext context) async {
  final progress = context.logger.progress('Configuring pubspec.yaml with Pub Workspaces...');
  try {
    final pubSpecFile = File('./pubspec.yaml');

    if (!pubSpecFile.existsSync()) {
      progress.fail('pubspec.yaml not found — are you in a Flutter project root?');
      return;
    }

    final lines = await pubSpecFile.readAsLines();
    final buffer = StringBuffer();
    bool workspaceAdded = false;
    bool dependenciesAdded = false;

    for (final line in lines) {
      // ── Inject workspace block before environment or name ────────────
      if (!workspaceAdded && (line.trim().startsWith('environment:') || line.trim().startsWith('name:'))) {
        if (line.trim().startsWith('name:')) {
          buffer.writeln(line);
          buffer.writeln();
          buffer.writeln('workspace:');
          buffer.writeln('  - features/core');
          buffer.writeln('  - features/auth');
          buffer.writeln('  - features/dashboard');
          workspaceAdded = true;
          continue;
        }
      }

      // ── Normalize flutter_lints and inject melos dev_dependency ──────
      if (line.trim().startsWith('flutter_lints:')) {
        buffer.writeln('  flutter_lints: ^6.0.0');
        buffer.writeln('  melos: ^8.0.0');
        continue;
      }

      buffer.writeln(line);

      // ── Inject feature dependencies after `dependencies:` ─────────────
      if (!dependenciesAdded && line.trim() == 'dependencies:') {
        buffer.writeln('  flutter_localizations:');
        buffer.writeln('    sdk: flutter');
        buffer.writeln('  core:');
        buffer.writeln('    path: ./features/core');
        buffer.writeln('  auth:');
        buffer.writeln('    path: ./features/auth');
        buffer.writeln('  dashboard:');
        buffer.writeln('    path: ./features/dashboard');
        dependenciesAdded = true;
      }

      // ── Inject font + asset declarations after `uses-material-design` ───
      if (line.trim().contains('uses-material-design')) {
        buffer.writeln();
        buffer.writeln('  assets:');
        buffer.writeln('    - assets/fonts/');
        buffer.writeln('  fonts:');
        buffer.writeln('    - family: ProzaLibre');
        buffer.writeln('      fonts:');
        buffer.writeln('        - asset: assets/fonts/ProzaLibre_Regular.ttf');
        buffer.writeln('        - asset: assets/fonts/ProzaLibre_Bold.ttf');
        buffer.writeln('        - asset: assets/fonts/ProzaLibre_SemiBold.ttf');
        buffer.writeln('          weight: 600');
      }
    }

    // Backup check if workspace wasn't added above
    if (!workspaceAdded) {
      final content = buffer.toString();
      buffer.clear();
      buffer.writeln('workspace:');
      buffer.writeln('  - features/core');
      buffer.writeln('  - features/auth');
      buffer.writeln('  - features/dashboard');
      buffer.writeln();
      buffer.write(content);
    }

    // ── Append flutter_intl block ─────────────────────────────────────────
    buffer.writeln();
    buffer.writeln('flutter_intl:');
    buffer.writeln('  enabled: true');
    buffer.writeln('  class_name: S');
    buffer.writeln('  main_locale: en');
    buffer.writeln('  arb_dir: lib/l10n');
    buffer.writeln('  output_dir: features/core/lib/src/gen');

    // ── Append melos configuration block ──────────────────────────────────
    buffer.writeln();
    buffer.writeln('melos:');
    buffer.writeln('  command:');
    buffer.writeln('    bootstrap:');
    buffer.writeln('      usePubWorkspaces: true');
    buffer.writeln('  scripts:');
    buffer.writeln('    bootstrap:');
    buffer.writeln('      run: melos exec -- flutter pub get');
    buffer.writeln('      description: Install dependencies for all packages (e.g. melos run bootstrap)');
    buffer.writeln('    analyze:');
    buffer.writeln('      run: melos exec -- flutter analyze --fatal-infos');
    buffer.writeln('      description: Run dart analyze across all packages (e.g. melos run analyze)');
    buffer.writeln('    format:');
    buffer.writeln('      run: melos exec -- dart format .');
    buffer.writeln('      description: Format all Dart code (e.g. melos run format)');
    buffer.writeln('    format:check:');
    buffer.writeln('      run: melos exec -- dart format --output=none --set-exit-if-changed .');
    buffer.writeln('      description: Check formatting without changes for CI (e.g. melos run format:check)');
    buffer.writeln('    fix:');
    buffer.writeln('      run: melos exec -- dart fix --apply');
    buffer.writeln('      description: Apply dart fixes across all packages (e.g. melos run fix)');
    buffer.writeln('    test:');
    buffer.writeln('      run: melos exec --fail-fast -- flutter test');
    buffer.writeln('      description: Run tests across all packages (e.g. melos run test)');
    buffer.writeln('    test:coverage:');
    buffer.writeln('      run: melos exec -- flutter test --coverage');
    buffer.writeln('      description: Run tests with coverage (e.g. melos run test:coverage)');
    buffer.writeln('    build:android:');
    buffer.writeln('      run: flutter build apk --release');
    buffer.writeln('      description: Build Android release APK (e.g. melos run build:android)');
    buffer.writeln('    build:ios:');
    buffer.writeln('      run: flutter build ios --release --no-codesign');
    buffer.writeln('      description: Build iOS release (e.g. melos run build:ios)');
    buffer.writeln('    build:runner:');
    buffer.writeln('      run: melos exec --depends-on="build_runner" -- flutter pub run build_runner build --delete-conflicting-outputs');
    buffer.writeln('      description: Run build_runner for code generation (e.g. melos run build:runner)');
    buffer.writeln('    gen:page:');
    buffer.writeln('      run: mason make cl_page -o lib/screens');
    buffer.writeln('      description: Generate a new BLoC page in lib/screens (e.g. melos run gen:page -- --name profile)');
    buffer.writeln('    gen:page:dashboard:');
    buffer.writeln('      run: mason make cl_page -o features/dashboard/lib/src');
    buffer.writeln('      description: Generate a new BLoC page in features/dashboard (e.g. melos run gen:page:dashboard -- --name profile)');
    buffer.writeln('    gen:page:auth:');
    buffer.writeln('      run: mason make cl_page -o features/auth/lib/src');
    buffer.writeln('      description: Generate a new BLoC page in features/auth (e.g. melos run gen:page:auth -- --name forgot_password)');
    buffer.writeln('    clean:');
    buffer.writeln('      run: melos exec -- flutter clean');
    buffer.writeln('      description: Clean all packages (e.g. melos run clean)');

    // ── Single atomic write ───────────────────────────────────────────────
    await pubSpecFile.writeAsString(buffer.toString());

    progress.complete('pubspec.yaml configured with Pub Workspaces ✅');
  } catch (e) {
    progress.fail('Failed to configure pubspec.yaml: ${e.toString()}');
  }
}

Future<void> _installDependencies(HookContext context) async {
  final progress = context.logger.progress('Running flutter pub get across workspace...');
  try {
    final result = await Process.run(
      'flutter',
      ['pub', 'get'],
      workingDirectory: Directory.current.path,
      runInShell: true,
    );

    if (result.exitCode == 0) {
      progress.complete('Workspace dependencies installed ✅');
    } else {
      progress.fail('flutter pub get failed:\n${result.stderr}');
    }

    // Resolve mason bricks locally
    await Process.run(
      'mason',
      ['get'],
      workingDirectory: Directory.current.path,
      runInShell: true,
    );
  } catch (e) {
    progress.fail('Unable to run flutter pub get: ${e.toString()}');
  }
}

Future<void> _runDartFormat(HookContext context) async {
  final progress = context.logger.progress('Running dart format...');
  try {
    await Process.run('dart', ['format', '.'], runInShell: true);
    progress.complete('dart format done ✅');
  } catch (e) {
    progress.fail('dart format failed: ${e.toString()}');
  }
}

Future<void> _runDartFix(HookContext context) async {
  final progress = context.logger.progress('Running dart fix --apply...');
  try {
    await Process.run('dart', ['fix', '--apply'], runInShell: true);
    progress.complete('dart fix done ✅');
  } catch (e) {
    progress.fail('dart fix failed: ${e.toString()}');
  }
}

Future<void> _runGitScript(HookContext context) async {
  final progress = context.logger.progress('Installing git hooks...');
  try {
    final result = await Process.run('sh', ['scripts/install-hooks.bash'], runInShell: true);
    if (result.exitCode == 0) {
      progress.complete('Git hooks installed ✅');
    } else {
      progress.fail('Git hook install failed:\n${result.stderr}');
    }
  } catch (e) {
    progress.fail('Unable to install git hooks: ${e.toString()}');
  }
}
