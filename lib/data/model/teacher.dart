import 'package:isar/isar.dart';
import 'package:reso_weather_states_builder/data/model/course.dart';

part 'teacher.g.dart';

@Collection()
class Teacher {
  Id id = Isar.autoIncrement;
  late String name;
  final course = IsarLink<Course>();
}
