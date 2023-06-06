part of 'get_all_persons_bloc.dart';

abstract class GetAllPersonsState extends Equatable {
  const GetAllPersonsState();

  @override
  List<Object> get props => [];
}

class PersonEmpty extends GetAllPersonsState {
  @override
  List<Object> get props => [];
}

class PersonLoading extends GetAllPersonsState {
  final List<PersonEntity> oldPersonsList;
  final bool isFirstFetch;

  const PersonLoading(this.oldPersonsList, {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldPersonsList];
}

class PersonLoaded extends GetAllPersonsState {
  final List<PersonEntity> personsList;

  const PersonLoaded(this.personsList);

  @override
  List<Object> get props => [personsList];
}

class PersonError extends GetAllPersonsState {
  final String message;

  const PersonError({required this.message});

  @override
  List<Object> get props => [message];
}
