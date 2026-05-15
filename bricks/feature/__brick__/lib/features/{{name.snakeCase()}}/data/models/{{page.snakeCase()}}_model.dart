import '../../domain/entities/{{page.snakeCase()}}.dart';

class {{page.pascalCase()}}Model extends {{page.pascalCase()}} {
    const {{page.pascalCase()}}Model() : super();

    factory {{page.pascalCase()}}Model.fromJson(Map<String, dynamic> json) {
      return {{page.pascalCase()}}Model();
    }

    Map<String, dynamic> toJson() {
      return {};
    }
}