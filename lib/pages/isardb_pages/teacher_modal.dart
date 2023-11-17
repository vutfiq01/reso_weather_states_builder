import 'package:flutter/material.dart';
import 'package:reso_weather_states_builder/data/model/course.dart';
import 'package:reso_weather_states_builder/data/model/teacher.dart';
import 'package:reso_weather_states_builder/pages/isardb_pages/isar_service.dart';

class TeacherModal extends StatefulWidget {
  final IsarService service;

  const TeacherModal(this.service, {super.key});

  @override
  State<TeacherModal> createState() => _TeacherModalState();
}

class _TeacherModalState extends State<TeacherModal> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  Course? selectedCourse;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Give your new teacher a name"),
            TextFormField(
              controller: _textController,
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Teacher Name is not allowed to be empty";
                }

                return null;
              },
            ),
            FutureBuilder<List<Course>>(
              future: widget.service.getAllCourses(),
              builder: (context, AsyncSnapshot<List<Course>> snapshot) {
                if (snapshot.hasData) {
                  List<Course> data = snapshot.data!;
                  selectedCourse = data.first;
                  final courses = data.map((course) {
                    return DropdownMenuItem<Course>(
                        value: course, child: Text(course.title));
                  }).toList();

                  return DropdownButtonFormField<Course>(
                      items: courses,
                      value: selectedCourse,
                      onChanged: (course) => selectedCourse = course);
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // ignore: avoid_print
                    print(selectedCourse!.id);
                    widget.service.saveTeacher(
                      Teacher()
                        ..name = _textController.text
                        ..course.value = selectedCourse,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "New teacher '${_textController.text}' saved in DB")));

                    Navigator.pop(context);
                  }
                },
                child: const Text("Add new teacher"))
          ],
        ),
      ),
    );
  }
}
