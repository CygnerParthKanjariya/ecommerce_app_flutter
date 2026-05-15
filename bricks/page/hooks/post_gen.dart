import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async{
  // Get feature name and page name from vars
  final feature = context.vars['feature'] as String;
  final page = context.vars['page'] as String;
  final createRoute = context.vars['route'] as bool;


  await updateInjection(feature,page,context);

  updateBlocProviders(feature,page);

  if(createRoute){
    addRoute(page);
    addRouteView(page,feature);

  }

}

Future<void> updateInjection(String feature, String page, HookContext context) async {
  final progress = context.logger.progress('Updating dependency injection file');

  try {
    // Generate the injection code
    final featureInCamel = _toCamelCase(feature);
    final featureInPascal = _toPascalCase(feature);
    final pageInPascal = _toPascalCase(page);

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
      "import '../features/${feature.snakeCase}/presentation/${page.snakeCase}/bloc/${page.snakeCase}_bloc.dart';",
      "import '../features/${feature.snakeCase}/domain/usecases/${page.snakeCase}_usecase.dart';",
      // Add more imports as needed
    ];

    final injectionCode = '''


    // Page - $pageInPascal
    // Bloc
    sl.registerFactory(() => ${pageInPascal}Bloc(usecase: sl()));
    // Use cases
    sl.registerLazySingleton(() => ${pageInPascal}UseCase(sl()));
    ''';

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

    final lastBraceIndex = fileContent.lastIndexOf('}');

    if (lastBraceIndex != -1) {
      // Insert your content before the last brace
      final newContent = fileContent.substring(0, lastBraceIndex) +
          injectionCode +
          fileContent.substring(lastBraceIndex);

      // Write back to the file
      await diFile.writeAsString(newContent);
      progress.complete('Successfully updated ${feature.snakeCase}_injection.dart');
    } else {
      progress.fail('Could not find the closing brace \'}\' in ${feature.snakeCase}_injection.dart.');
      context.logger.err('Ensure your ${feature.snakeCase}_injection.dart file has a properly formed structure with a closing brace.');
      return;
    }
  } catch (e) {
    progress.fail('Error updating dependency injection file: $e');
    context.logger.err('$e'); // Log the full error for debugging
  }
}

void updateBlocProviders(String featureName, String pageName) {
  // Path to main.dart file
  final mainFilePath = 'lib/main.dart';
  try {
    // Read current content
    final mainFile = File(mainFilePath);
    if (!mainFile.existsSync()) {
      print('Error: Main file not found at $mainFilePath');
      return;
    }

    final content = mainFile.readAsStringSync();
    final pageInPascal = _toPascalCase(pageName);
    final blocProviderEntry = '''
        BlocProvider<${pageInPascal}Bloc>(create: (context) => di.sl<${pageInPascal}Bloc>(),),''';
    // Check if the BlocProvider is already added
    if (content.contains('${pageInPascal}Bloc')) {
      print('BlocProvider for ${pageInPascal}Bloc already exists');
      return;
    }

    // Find the MultiBlocProvider providers list
    final providersPattern = 'providers: [';
    final providersIndex = content.indexOf(providersPattern);

    if (providersIndex == -1) {
      print('Warning: MultiBlocProvider providers list not found in main.dart');
      return;
    }


    // Find the position to insert the new provider
    // We'll look for the end of the providers list or the last provider
    int startPos = providersIndex + providersPattern.length;
    int endBracketPos = content.indexOf('],', startPos);

    if (endBracketPos == -1) {
      print('Warning: Couldn\'t find the end of providers list');
      return;
    }

    // Create updated content with the new BlocProvider
    final updatedContent = content.substring(0, startPos) +
        '\n' + blocProviderEntry + '\n' +
        content.substring(startPos);

    // Add import for the feature's bloc
    final importSection = "import 'package:flutter/material.dart';";
    final newImport = "import 'features/${featureName
        .snakeCase}/presentation/${pageName.snakeCase}/bloc/${pageName
        .snakeCase}_bloc.dart';";

    final finalContent = updatedContent.contains(newImport)
        ? updatedContent
        : updatedContent.replaceFirst(
        importSection,
        '$importSection\n$newImport'
    );

    // Write updated content back to file
    mainFile.writeAsStringSync(finalContent);
    print('✅ Successfully updated MultiBlocProvider with ${pageInPascal}Bloc');
  } catch (e) {
    print('Error updating BlocProvider: $e');
  }
}


void addRoute(String page){
  final routeFilePath = 'lib/core/navigation/routes.dart';

  try{
    // Read current content
    final file = File(routeFilePath);
    if (!file.existsSync()) {
      print('Error: Route file not found at $routeFilePath');
      return;
    }

    final content = file.readAsStringSync();

    final providersIndex = content.indexOf("{");

    if (providersIndex == -1) {
      print('Warning: routes not found in routes.dart');
      return;
    }

    int startPos = providersIndex + 1;

    // Create updated content with the new BlocProvider
    final updatedContent = content.substring(0, startPos) +
        '\n' + '''${page.camelCase}("/${page.camelCase}"),''' + '\n' +
        content.substring(startPos);

    file.writeAsStringSync(updatedContent);
    print('✅ Successfully added route ${page.camelCase}(${page.camelCase})');
  } catch (e) {
    print('Error creating route: $e');
  }
}

void addRouteView(String page,String feature){
  final routeFilePath = 'lib/core/navigation/route_view.dart';

  try{
    // Read current content
    final file = File(routeFilePath);
    if (!file.existsSync()) {
      print('Error: RouteView file not found at $routeFilePath');
      return;
    }

    final content = file.readAsStringSync();

    final startPos = content.indexOf("}");

    if (startPos == -1) {
      print('Warning: RoutView not found in route_view.dart');
      return;
    }


    // Create updated content with the new BlocProvider
    final updatedContent = content.substring(0, startPos) +
        '\n' + '''
        case Routes.${page.camelCase}:
            page = const ${page.pascalCase}Page();
            break;
        ''' + '\n' +
        content.substring(startPos);

    final newImport = "import '../../features/${feature
        .snakeCase}/presentation/${page.snakeCase}/screen/${page
        .snakeCase}_page.dart';";

    final finalContent = updatedContent.contains(newImport)
        ? updatedContent
        : '$newImport\n$updatedContent';


    file.writeAsStringSync(finalContent);
    print('✅ Successfully added routeView  ${page.camelCase} = ${page.pascalCase}Page()');
  } catch (e) {
    print('Error creating route: $e');
  }
}

// Helper functions for string case conversion
String _toCamelCase(String input) {
  if (input.isEmpty) return '';
  if (input.length == 1) return input.toLowerCase();

  // Split by non-alphanumeric characters
  final parts = input.split(RegExp(r'[^a-zA-Z0-9]'));
  final firstPart = parts.first.toLowerCase();
  final remainingParts = parts.skip(1).map((part) {
    if (part.isEmpty) return '';
    return part[0].toUpperCase() + part.substring(1).toLowerCase();
  });

  return firstPart + remainingParts.join('');
}

String _toPascalCase(String input) {
  if (input.isEmpty) return '';

  // Split by non-alphanumeric characters
  final parts = input.split(RegExp(r'[^a-zA-Z0-9]'));
  final capitalizedParts = parts.map((part) {
    if (part.isEmpty) return '';
    return part[0].toUpperCase() + part.substring(1).toLowerCase();
  });

  return capitalizedParts.join('');
}