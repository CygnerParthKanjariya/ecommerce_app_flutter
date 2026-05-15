part of '{{page.snakeCase()}}_bloc.dart';

abstract
class {{page.pascalCase()}}State extends Equatable {
const {{page.pascalCase()}}State();

@override
List<Object> get props => [];
}

class {{page.pascalCase()}}Initial extends {{page.pascalCase()}}State {}

class {{page.pascalCase()}}Loading extends {{page.pascalCase()}}State {}

class {{page.pascalCase()}}Loaded extends {{page.pascalCase()}}State {


const {{page.pascalCase()}}Loaded();

@override
List<Object> get props => [];
}

class {{page.pascalCase()}}Error extends {{page.pascalCase()}}State {
final Failure failure;

const {{page.pascalCase()}}Error({required this.failure});

@override
List<Object> get props => [failure];
}
