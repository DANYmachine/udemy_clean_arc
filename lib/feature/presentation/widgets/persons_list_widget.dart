import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_clean_arc/feature/domain/entities/person_entity.dart';
import 'package:udemy_clean_arc/feature/presentation/bloc/get_all_persons_bloc/get_all_persons_bloc.dart';
import 'package:udemy_clean_arc/feature/presentation/widgets/person_card_widget.dart';

class PersonsList extends StatelessWidget {
  const PersonsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllPersonsBloc, GetAllPersonsState>(
      builder: (context, state) {
        List<PersonEntity> persons = [];

        if (state is PersonLoading && state.isFirstFetch) {
          return _loadingIndicator();
        } else if (state is PersonLoaded) {
          persons = state.personsList;
        }
        return ListView.separated(
          itemBuilder: (context, index) {
            return PersonCard(person: persons[index]);
          },
          separatorBuilder: (context, index) {
            return const Divider(color: Colors.grey);
          },
          itemCount: persons.length,
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: CircularProgressIndicator(),
    );
  }
}
