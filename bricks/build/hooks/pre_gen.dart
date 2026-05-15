import 'package:mason/mason.dart';
import 'dart:io';
void run(HookContext context) async{
  // TODO: add pre-generation logic.

  final logger = context.logger;

  const flavorFilePath =  'lib/core/util/flavor.dart';



  try {
    // Read the flavor file
    final file = File(flavorFilePath);
    if (!file.existsSync()) {
      logger.err('Flavor file not found at: $flavorFilePath');
      return;
    }

    final content = file.readAsStringSync();
    final flavors = extractFlavorsFromEnum(content);

    if (flavors.isEmpty) {
      logger.err('No flavors found in the enum file');
      return;
    }

    logger.info('Found flavors: ${flavors.join(', ')}');



    // If no specific flavor was chosen, let user select
    final selectedFeature = await context.logger.chooseOne(
      'Select feature folder:',
      choices: flavors,
      defaultValue: flavors.contains(context.vars['flavor'])
          ? context.vars['flavor']
          : flavors.first,
    );

    // Update the feature variable with the selected option
    context.vars['flavor'] = selectedFeature;

  } catch (e) {
    logger.err('Error reading flavor file: $e');
  }

}
List<String> extractFlavorsFromEnum(String content) {
  final flavors = <String>[];

  // Regular expression to match enum values
  final enumPattern = RegExp(r'enum\s+Flavor\s*{([^}]+)}', multiLine: true);
  final enumMatch = enumPattern.firstMatch(content);

  if (enumMatch != null) {
    final enumBody = enumMatch.group(1)!;

    // Extract individual flavor names
    final flavorPattern = RegExp(r'(\w+)\s*\([^)]*\)', multiLine: true);
    final matches = flavorPattern.allMatches(enumBody);

    for (final match in matches) {
      final flavorName = match.group(1);
      if (flavorName != null && flavorName.isNotEmpty) {
        flavors.add(flavorName);
      }
    }
  }

  return flavors;
}

extension on String {
  String get pascalCase {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
