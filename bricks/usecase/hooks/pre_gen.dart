import 'package:mason/mason.dart';
import 'dart:io';
import 'package:path/path.dart' as path; // Import the path package

Future<void> setListOfFolder(HookContext context, String key, String relativePath) async {
  final progress = context.logger.progress('Scanning $relativePath directory');

  try {
    // Get the current working directory (likely the root of the Flutter project)
    final projectDir = Directory.current;

    // Construct the full path
    final libDir = Directory(path.join(projectDir.path, relativePath));

    if (!await libDir.exists()) {
      progress.fail('Could not find the $relativePath');
      context.logger.err(
          'Please run this brick from the root of your Flutter project');
      exit(1);
    }

    // List all directories inside lib
    final selectedFolders = await libDir
        .list()
        .where((entity) => entity is Directory)
        .map((entity) => path.basename(entity.path)) // Use path.basename
        .toList();

    if (selectedFolders.isEmpty) {
      progress.complete('No folders found in $relativePath');
      // If no folders exist, we'll just use the default value from brick.yaml
      return;
    }

    // Show a selection prompt to the user
    progress.complete('Found ${selectedFolders.length} folders');
    final selected = await context.logger.chooseOne(
      'Select $key folder:',
      choices: selectedFolders,
      defaultValue: selectedFolders.contains(context.vars[key])
          ? context.vars[key]
          : selectedFolders.first,
    );

    // Update the feature variable with the selected option
    context.vars[key] = selected;
  } catch (e) {
    progress.fail('Error scanning $relativePath: $e');
    // Use the default value from brick.yaml on error
  }
}

void run(HookContext context) async {
  await setListOfFolder(context, "feature", path.join("lib", "features"));
  await setListOfFolder(
      context,
      "page",
      path.join("lib", "features", context.vars['feature'], "presentation"));
}