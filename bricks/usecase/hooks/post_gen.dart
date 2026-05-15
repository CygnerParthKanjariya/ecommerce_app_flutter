import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) {
  final feature = context.vars['feature'] as String;
  final page = context.vars['page'] as String;
  final name = context.vars['name'] as String;
  addNewUsecaseToPageBloc(context, feature, page, name);
  updateInjection(context, feature, page, name);
}

void addNewUsecaseToPageBloc(HookContext context, String feature, String page,
    String name) {
  // Path to the bloc file
  final blocFilePath =
      'lib/features/$feature/presentation/$page/bloc/${page}_bloc.dart';

  try {
    // Read current content
    final blocFile = File(blocFilePath);
    if (!blocFile.existsSync()) {
      context.logger.err('Error: Bloc file not found at $blocFilePath');
      return;
    }

    final newUseCaseFile = File(
        'lib/features/$feature/domain/usecases/${name
            .snakeCase}_usecase.dart'); // Adjust path if needed
    if (!newUseCaseFile.existsSync()) {
      context.logger.err('Error: ${name.snakeCase}_usecase.dart not found.');
      return;
    }

    var blocContent = blocFile.readAsStringSync();

    final importsToAdd = [
      "import '../../../domain/usecases/${name.snakeCase}_usecase.dart';",
    ];

    // Add imports
    final lastImportIndex = blocContent.lastIndexOf('import ');
    if (lastImportIndex != -1) {
      final endOfImportLine = blocContent.indexOf(';', lastImportIndex) + 1;
      String newImports = '';
      for (final importStatement in importsToAdd) {
        if (!blocContent.contains(importStatement)) {
          newImports += '\n$importStatement';
        }
      }
      blocContent = blocContent.substring(0, endOfImportLine) +
          newImports +
          blocContent.substring(endOfImportLine);
    } else {
      String newImports = '';
      for (final importStatement in importsToAdd) {
        newImports += '$importStatement\n';
      }
      blocContent = '$newImports\n$blocContent';
    }

    // Inject usecase variable
    final classOpeningIndex = blocContent.indexOf(
        '{', blocContent.indexOf('class ${_toPascalCase(page)}Bloc'));
    final injectionUsecaseVariable = '''
  
   final ${_toPascalCase(name)}UseCase ${name.camelCase}UseCase;
  ''';
    if (classOpeningIndex != -1) {
      final firstBraceIndex = classOpeningIndex + 1;
      blocContent = blocContent.substring(0, firstBraceIndex) +
          injectionUsecaseVariable +
          blocContent.substring(firstBraceIndex);
      context.logger.info(
          'Successfully added variable in ${_toPascalCase(page)}Bloc.dart');
    } else {
      context.logger.err(
          'Could not find class opening brace in ${_toPascalCase(
              page)}Bloc.dart');
      return;
    }

    // Inject usecase into constructor
    final constructorStartIndex =
    blocContent.indexOf('${_toPascalCase(page)}Bloc({');
    final injectionConstructorVariable = 'required this.${name
        .camelCase}UseCase, ';
    if (constructorStartIndex != -1) {
      final constructorEndIndex = constructorStartIndex +
          '${_toPascalCase(page)}Bloc({'.length;
      blocContent = blocContent.substring(0, constructorEndIndex) +
          injectionConstructorVariable +
          blocContent.substring(constructorEndIndex);
      context.logger.info(
          'Successfully updated constructor in ${_toPascalCase(
              page)}Bloc.dart');
    } else {
      context.logger.err(
          'Could not find constructor definition in ${_toPascalCase(
              page)}Bloc.dart');
    }

    // Write the updated content back to the file
    blocFile.writeAsStringSync(blocContent);
  } catch (e) {
    context.logger
        .err('Error updating ${_toPascalCase(page)}Bloc.dart: $e');
  }
}

Future<void> updateInjection(HookContext context, String feature, String page,
    String name) async {
  final progress = context.logger.progress(
      'Updating dependency injection file');

  try {
    // Define the path to your dependency injection file
    final diFilePath = 'lib/di/${feature.snakeCase}_injection.dart';
    final diFile = File(diFilePath);

    if (!await diFile.exists()) {
      progress.fail('Could not find the dependency injection file');
      context.logger.err('Please ensure $diFilePath exists in your project');
      return;
    }

    // Define multiple imports to add
    final importsToAdd = [
      "import '../features/${feature.snakeCase}/domain/usecases/${name
          .snakeCase}_usecase.dart';",
      // Add more imports as needed
    ];

    final injectionConstructorVariable = '''${name.camelCase}UseCase : sl(),''';

    // Read the existing file content
    String fileContent = await diFile.readAsString();
    final lastImportIndex = fileContent.lastIndexOf('import ');
    if (lastImportIndex != -1) {
      // Find the end of the last import line
      final endOfImportLine = fileContent.indexOf(';', lastImportIndex) + 1;

      // Add all imports after the last existing import
      String newImports = '';
      for (final importStatement in importsToAdd) {
        if (!fileContent.contains(importStatement)) {
          newImports += '\n$importStatement';
        }
      }

      fileContent = fileContent.substring(0, endOfImportLine) +
          newImports +
          fileContent.substring(endOfImportLine);
    } else {
      progress.fail('Could not find any import statements in ${feature.snakeCase}_injection.dart.');
      context.logger.err('Ensure your ${feature.snakeCase}_injection.dart file contains at least one import statement.');
      return;
    }

    final constructorStartIndex =
    fileContent.indexOf('${_toPascalCase(page)}Bloc(');

    if (constructorStartIndex != -1) {
      final constructorEndIndex = constructorStartIndex +
          '${_toPascalCase(page)}Bloc('.length;
      fileContent = fileContent.substring(0, constructorEndIndex) +
          injectionConstructorVariable +
          fileContent.substring(constructorEndIndex);
      context.logger.info(
          'Successfully updated constructor in ${_toPascalCase(
              page)}Bloc.dart');
    } else {
      context.logger.err(
          'Could not find constructor definition in ${_toPascalCase(
              page)}Bloc.dart');
    }

    final lastBraceIndex = fileContent.lastIndexOf('}');

    final injectionCode = '''
    sl.registerLazySingleton(() => ${_toPascalCase(name)}UseCase(sl()));
    ''';
    if (lastBraceIndex != -1) {
      // Insert your content before the last brace
      final newContent = fileContent.substring(0, lastBraceIndex) +
          injectionCode +
          fileContent.substring(lastBraceIndex);

      // Write back to the file
      await diFile.writeAsString(newContent);
      progress.complete(
          'Successfully updated ${feature.snakeCase}_injection.dart');
    } else {
      progress.fail('Could not find closing brace in ${feature
          .snakeCase}_injection.dart');
      context.logger.err('Ensure your ${feature.snakeCase}_injection.dart file has a properly formed structure with a closing brace.');
      return;
    }
  } catch (e) {
    progress.fail('Error updating dependency injection file: $e');
    context.logger.err('$e'); // Log the full error
  }
}

String _toPascalCase(String input) {
  if (input.isEmpty) return '';
  final parts = input.split(RegExp(r'[^a-zA-Z0-9]'));
  final capitalizedParts = parts.map((part) {
    if (part.isEmpty) return '';
    return part[0].toUpperCase() + part.substring(1).toLowerCase();
  });
  return capitalizedParts.join('');
}