import 'package:udemy_clean_arc/feature/domain/entities/person_entity.dart';

abstract class PersonRepository {
  Future<List<PersonEntity>> getAllPersons(int page);
  Future<List<PersonEntity>> searchPerson(String query);
}
