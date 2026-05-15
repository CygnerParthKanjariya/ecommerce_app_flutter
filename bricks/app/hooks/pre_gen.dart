import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  final logger = context.logger;
  final dependenciesToAdd = [
    'http',
    'equatable',
    'dartz',
    'internet_connection_checker',
    'get_it',
    'flutter_bloc',
    'flutter_secure_storage',
    'flutter_svg',
  ];

  for (final dependency in dependenciesToAdd) {
    try {
      final process = await Process.start(
        'flutter',
        ['pub', 'add', dependency],
        workingDirectory: Directory.current.path,
        runInShell: true,
      );

      await stdout.addStream(process.stdout);
      await stderr.addStream(process.stderr);

      final exitCode = await process.exitCode;

      if (exitCode == 0) {
        logger.info('Successfully added $dependency.');
      } else {
        logger.err('Failed to add $dependency with exit code: $exitCode');
      }
    } catch (e) {
      logger.err('Error starting process for $dependency: $e');
    }
  }
}
