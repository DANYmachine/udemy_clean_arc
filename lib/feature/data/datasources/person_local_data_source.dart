import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_clean_arc/core/error/exception.dart';

import '../models/person_model.dart';

abstract class PersonLocalDataSource {
  Future<List<PersonModel>> getLastPersonFromCache();
  Future<void> personsToCache(List<PersonModel> persons);
}

const CACHED_PERSONS_LIST = 'CACHED_PERSONS_LIST';

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonFromCache() {
    final jsonPersonsList = sharedPreferences.getStringList(
      CACHED_PERSONS_LIST,
    );
    if (jsonPersonsList!.isNotEmpty) {
      return Future.value(
        jsonPersonsList
            .map(
              (person) => PersonModel.fromJson(
                json.decode(person),
              ),
            )
            .toList(),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonsList = persons
        .map(
          (person) => json.encode(
            person.toJson(),
          ),
        )
        .toList();
    sharedPreferences.setStringList(CACHED_PERSONS_LIST, jsonPersonsList);
    log('Persons to cache: ${jsonPersonsList.length}');
    return Future.value(jsonPersonsList);
  }
}
