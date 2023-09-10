import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredNumber = 1;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  DateTime _selectedBirthDate = DateTime.now();
  final DateFormat formatter = DateFormat.yMd();

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("name", _enteredName);
      prefs.setInt("phone_no", _enteredNumber);
      prefs.setString("birth_date", _selectedBirthDate.toIso8601String());

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Saved Successfully"),
        ),
      );
    }
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String date = prefs.getString("birth_date") ?? '';
    setState(() {
      _enteredName = prefs.getString("name") ?? "";

      _enteredNumber = prefs.getInt("phone_no") ?? 1;
      // _selectedBirthDate = DateTime.parse(date);

      nameController.text = prefs.getString("name") ?? "";
      phoneController.text = prefs.getInt("phone_no").toString() == "null"
          ? ""
          : prefs.getInt("phone_no").toString();
      birthDateController.text = prefs.getString('birth_date') ?? '';
    });
    print(_enteredName);
    print(_enteredNumber);
    print(_selectedBirthDate);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Unicode Tasks",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Profile",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 24,
            ),
            Form(
                key: _formKey,
                child: Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameController,
                        // initialValue: _enteredName,
                        decoration: InputDecoration(
                          labelText: "Name",
                          prefixIcon: Icon(
                            Icons.verified_user,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple.shade300),
                          ),
                          labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().length <= 1 ||
                              value.trim().length > 50) {
                            return 'Must be between 1 and 50 characters.';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          setState(() {
                            _enteredName = newValue!;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple.shade300),
                          ),
                          labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().length < 10 ||
                              value.trim().length > 10) {
                            return 'Must be valid phone number.';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          setState(() {
                            _enteredNumber = int.parse(newValue!);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      DateTimeFormField(
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 22),
                          hintStyle: const TextStyle(color: Colors.black45),
                          errorStyle: const TextStyle(color: Colors.redAccent),
                          border: const OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.event_note,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                          labelText: 'Birth Date',
                          labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        mode: DateTimeFieldPickerMode.date,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (e) => (e?.day ?? 0) == 1
                            ? 'Please not the first day'
                            : null,
                        onDateSelected: (DateTime value) {
                          setState(() {
                            _selectedBirthDate = value;
                          });
                        },
                        onSaved: (newValue) {
                          setState(() {
                            _selectedBirthDate = newValue!;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              _formKey.currentState!.reset();
                            },
                            child: const Text('Reset Profile'),
                          ),
                          ElevatedButton(
                            onPressed: _saveItem,
                            child: const Text('Save Profile'),
                          )
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
