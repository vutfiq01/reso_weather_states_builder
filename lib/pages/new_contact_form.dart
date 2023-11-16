import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:reso_weather_states_builder/data/model/contact.dart';

class NewContactForm extends StatefulWidget {
  const NewContactForm({super.key});

  @override
  State<NewContactForm> createState() => _NewContactFormState();
}

class _NewContactFormState extends State<NewContactForm> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _age;

  late final TextEditingController nameTextController;
  late final TextEditingController ageTextController;

  void addContact(Contact contact) {
    final contactBox = Hive.box('contacts');
    contactBox.add(contact);
  }

  @override
  void initState() {
    nameTextController = TextEditingController();
    ageTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameTextController.dispose();
    ageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: nameTextController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  onSaved: (value) {
                    _name = value!;
                    nameTextController.clear();
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: ageTextController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    _age = value!;
                    ageTextController.clear();
                  },
                ),
              ),
            ],
          ),
          ElevatedButton(
            child: const Text('Add New Contact'),
            onPressed: () {
              _formKey.currentState!.save();
              final newContact = Contact(_name, int.parse(_age));
              addContact(newContact);
            },
          ),
        ],
      ),
    );
  }
}
