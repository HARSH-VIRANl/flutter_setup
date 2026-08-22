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

      // ── Normalize flutter_lints to flexible caret range ───────────────
      if (line.trim().startsWith('flutter_lints:')) {
        buffer.writeln('  flutter_lints: ^6.0.0');
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
        buffer.writeln('    - family: OpenSans');
        buffer.writeln('      fonts:');
        buffer.writeln('        - asset: assets/fonts/OpenSans_Regular.ttf');
        buffer.writeln('        - asset: assets/fonts/OpenSans_SemiBold.ttf');
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
