import 'dart:io';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path; // Import the path package

void run(HookContext context) async {
  final progress = context.logger.progress('Scanning lib directory');

  try {
    // Get the current working directory (likely the root of the Flutter project)
    final projectDir = Directory.current;

    // Look for the lib directory
    final libDir = Directory(path.join(projectDir.path, 'lib', 'features'));

    if (!await libDir.exists()) {
      progress.fail('Could not find the lib directory');
      context.logger.err('Please run this brick from the root of your Flutter project');
      exit(1);
    }

    // List all directories inside lib
    final featureFolders = await libDir
        .list()
        .where((entity) => entity is Directory)
        .map((entity) => path.basename(entity.path)) // Use path.basename
        .toList();

    if (featureFolders.isEmpty) {
      progress.complete('No feature folders found in lib directory');
      // If no folders exist, we'll just use the default value from brick.yaml
      return;
    }

    // Show a selection prompt to the user
    progress.complete('Found ${featureFolders.length} feature folders');
    final selectedFeature = await context.logger.chooseOne(
      'Select feature folder:',
      choices: featureFolders,
      defaultValue: featureFolders.contains(context.vars['feature'])
          ? context.vars['feature']
          : featureFolders.first,
    );

    // Update the feature variable with the selected option
    context.vars['feature'] = selectedFeature;
  } catch (e) {
    progress.fail('Error scanning lib directory: $e');
    // Use the default value from brick.yaml on error
  }
}