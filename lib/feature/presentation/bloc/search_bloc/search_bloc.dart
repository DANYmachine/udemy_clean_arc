// ignore_for_file: constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:udemy_clean_arc/feature/domain/entities/person_entity.dart';
import 'package:udemy_clean_arc/feature/domain/usecases/search_person.dart';

import '../../../../core/error/failure.dart';

part 'search_event.dart';
part 'search_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;
  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty()) {
    on<SearchPersons>((event, emit) async {
      emit(PersonSearchLoading());
      final failureOrPerson = await searchPerson(
        SearchPersonParams(query: event.personQuery),
      );
      emit(
        failureOrPerson.fold(
          (failure) => PersonSearchError(
            message: _mapFailureToMessage(failure),
          ),
          (person) => PersonSearchLoaded(persons: person),
        ),
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
