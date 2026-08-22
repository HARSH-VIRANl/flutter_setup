import 'dart:io';

import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';

Future<void> run(HookContext context) async {
  final pubSpecFile = File('./pubspec.yaml');

  if (!pubSpecFile.existsSync()) {
    context.logger.err(
      'No pubspec.yaml found in the current directory.\n'
      'Please run this command from your Flutter project root.',
    );
    exit(1);
  }

  final content = await pubSpecFile.readAsString();
  final yamlMap = loadYaml(content);
  final packageName = yamlMap['name'] as String?;

  if (packageName == null || packageName.isEmpty) {
    context.logger.err('Could not read package name from pubspec.yaml.');
    exit(1);
  }

  context.vars['fullPath'] = packageName;
  context.logger.info('Package name detected: $packageName');
}
