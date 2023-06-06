// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../domain/entities/person_entity.dart';
import '../../../domain/usecases/get_all_persons.dart';

part 'get_all_persons_event.dart';
part 'get_all_persons_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class GetAllPersonsBloc extends Bloc<GetAllPersonsEvent, GetAllPersonsState> {
  final GetAllPersons getAllPersons;
  int page = 1;

  GetAllPersonsBloc({required this.getAllPersons}) : super(PersonEmpty()) {
    on<GetAllPersonsEvent>((event, emit) async {
      final currentState = state;

      var oldPerson = <PersonEntity>[];
      if (currentState is PersonLoaded) {
        oldPerson = currentState.personsList;
      }
      emit(PersonLoading(oldPerson, isFirstFetch: page == 1));

      final failureOrPerson = await getAllPersons(PagePersonParams(page: page));

      failureOrPerson.fold(
        (error) => emit(PersonError(message: _mapFailureToMessage(error))),
        (character) {
          page++;
          final persons = (state as PersonLoading).oldPersonsList;
          persons.addAll(character);
          log('List length: ${persons.length.toString()}');
          emit(PersonLoaded(persons));
        },
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
