part of 'get_all_persons_bloc.dart';

abstract class GetAllPersonsEvent extends Equatable {
  const GetAllPersonsEvent();

  @override
  List<Object> get props => [];
}

class GetPersonsEvent extends GetAllPersonsEvent {}
