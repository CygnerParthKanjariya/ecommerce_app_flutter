
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/{{page.snakeCase()}}.dart';
import '../../../domain/usecases/{{page.snakeCase()}}_usecase.dart';
import '../../../../../core/usecases/usecase.dart';

part '{{page.snakeCase()}}_event.dart';
part '{{page.snakeCase()}}_state.dart';

class {{page.pascalCase()}}Bloc extends Bloc<{{page.pascalCase()}}Event, {{page.pascalCase()}}State> {
      final {{page.pascalCase()}}UseCase usecase;

      {{page.pascalCase()}}Bloc({required this.usecase}) : super({{page.pascalCase()}}Initial()){}
}
