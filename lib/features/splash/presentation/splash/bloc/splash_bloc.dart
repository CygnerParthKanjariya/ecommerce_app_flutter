
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failures.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/splash.dart';
import '../../../domain/usecases/splash_usecase.dart';
import '../../../../../core/usecases/usecase.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
      final SplashUseCase usecase;

      SplashBloc({required this.usecase}) : super(SplashInitial()){}
}
