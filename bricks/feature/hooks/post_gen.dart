import 'package:mason/mason.dart';
import 'dart:io';
void run(HookContext context) {
  // TODO: add post-generation logic.
  final featureName = context.vars['name'];
  final pageName = context.vars['page'];
  addInjection(featureName);
  updateBlocProviders(featureName,pageName);
  addRoute(pageName);
  addRouteView(pageName,featureName);
}


void addInjection(String featureName){
  // Path to main injection file
  final injectionFilePath = 'lib/di/injection_container.dart';

  // Read current content
  final injectionFile = File(injectionFilePath);
  final content = injectionFile.readAsStringSync();

  // Add import
  final newImport = "import '${featureName.snakeCase}_injection.dart';";
  var updatedContent = content;

  // Find where to insert the import (before the final sl line)
  final importInsertPosition = content.indexOf('final sl = GetIt.instance;');
  if (importInsertPosition != -1) {
    updatedContent = content.substring(0, importInsertPosition) +
        newImport + '\n' +
        content.substring(importInsertPosition);
  }

  // Add to feature initializers map
  final mapInsertPosition = updatedContent.indexOf('final featureInitializers = {');
  if (mapInsertPosition != -1) {
    // Find the closing brace of the map
    final mapEndPosition = updatedContent.indexOf('};', mapInsertPosition);
    if (mapEndPosition != -1) {
      updatedContent = updatedContent.substring(0, mapEndPosition) +
          "  '${featureName.snakeCase}': ${featureName.camelCase}Injection,\n" +
          updatedContent.substring(mapEndPosition);
    }
  }

  // Write updated content back to file
  injectionFile.writeAsStringSync(updatedContent);

  print('✅ Updated injection.dart with $featureName feature');
}

void updateBlocProviders(String featureName, String pageName) {
  final mainFilePath = 'lib/main.dart';
  try {
    final mainFile = File(mainFilePath);
    if (!mainFile.existsSync()) {
      print('Error: Main file not found at $mainFilePath');
      return;
    }

    final content = mainFile.readAsStringSync();
    final pageInPascal = _toPascalCase(pageName);
    final blocProviderEntry = '''
        BlocProvider<${pageInPascal}Bloc>(create: (context) => di.sl<${pageInPascal}Bloc>(),),''';

    if (content.contains('${pageInPascal}Bloc')) {
      print('✅ BlocProvider for ${pageInPascal}Bloc already exists');
      return;
    }

    const providersPattern = 'providers: [';
    final providersIndex = content.indexOf(providersPattern);

    if (providersIndex == -1) {
      print('⚠️ Warning: MultiBlocProvider providers list not found in $mainFilePath. Ensure your main.dart file has a `MultiBlocProvider` with a `providers` list.');
      return;
    }

    final startPos = providersIndex + providersPattern.length;
    final endBracketPos = content.indexOf('],', startPos);

    if (endBracketPos == -1) {
      print('⚠️ Warning: Couldn\'t find the closing bracket of the `providers` list in $mainFilePath. Ensure the list is correctly formatted.');
      return;
    }

    final updatedContent = content.substring(0, startPos) +
        '\n' + blocProviderEntry + '\n' +
        content.substring(startPos);

    const importSection = "import 'package:flutter/material.dart';";
    final newImport = "import 'features/${featureName.snakeCase}/presentation/${pageName.snakeCase}/bloc/${pageName.snakeCase}_bloc.dart';";

    final finalContent = updatedContent.contains(newImport)
        ? updatedContent
        : updatedContent.replaceFirst(
      importSection,
      '$importSection\n$newImport',
    );

    mainFile.writeAsStringSync(finalContent);
    print('✅ Successfully updated MultiBlocProvider with ${pageInPascal}Bloc');

  } on FileSystemException catch (e) {
    print('❌ Error accessing or modifying $mainFilePath: $e');
  } catch (e) {
    print('❌ An unexpected error occurred while updating BlocProvider: $e');
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