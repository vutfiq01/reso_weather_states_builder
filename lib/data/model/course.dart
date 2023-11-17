import 'package:isar/isar.dart';
import 'package:reso_weather_states_builder/data/model/student.dart';
import 'package:reso_weather_states_builder/data/model/teacher.dart';

part 'course.g.dart';

@Collection()
class Course {
  Id id = Isar.autoIncrement;
  late String title;

  @Backlink(to: 'course')
  final teacher = IsarLink<Teacher>();

  @Backlink(to: 'courses')
  final students = IsarLinks<Student>();
}
