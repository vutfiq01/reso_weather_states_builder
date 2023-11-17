import 'package:isar/isar.dart';
import 'package:reso_weather_states_builder/data/model/course.dart';

part 'student.g.dart';

@Collection()
class Student {
  Id id = Isar.autoIncrement;
  late String name;
  final courses = IsarLinks<Course>();
}
