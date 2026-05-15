import 'package:mason/mason.dart';
import 'dart:io';

void run(HookContext context) async{
  final logger = context.logger;
  final type = context.vars['type'];
  final mode = context.vars['mode'];
  final flavor = context.vars['flavor'];


  try{
    logger.info('Building $type($flavor)...');
    final process = await Process.start(
      'flutter',
      ['build', type, '--dart-define=app.flavor=$flavor'],
      workingDirectory: Directory.current.path,
      runInShell: true,
    );

    await stdout.addStream(process.stdout);
    await stderr.addStream(process.stderr);

    final exitCode = await process.exitCode;

    if (exitCode == 0) {
      logger.info('Successfully build $type.');
    } else {
      logger.err('Failed to build $type with exit code: $exitCode');
    }
  }catch (e) {
    logger.err('Error starting process for build $type: $e');
  }
}
