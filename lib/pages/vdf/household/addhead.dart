import 'package:dalmia/apis/commonobject.dart';
import 'package:dalmia/pages/vdf/household/addfamily.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/apis/form_logic.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class AddHead extends StatefulWidget {
  const AddHead({super.key});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<AddHead> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  String? _selectedGender;
  List<dynamic> genderOptions = [];
  String? _selectedEducation;
  String? _selectedCaste;
  List<dynamic> casteOptions = [];
  String? _selectedPrimaryEmployment;
  String? _selectedSecondaryEmployment;
  bool _validateFields = false;
  // List<String> genderOptions = ['Male', 'Female'];
  List<String> educationOptions = [
    'Option 1',
    'Option 2',
    'Option 3'
  ]; // Replace with actual options
  // List<String> casteOptions = [
  //   'Option 1',
  //   'Option 2',
  //   'Option 3'
  // ]; // Replace with actual options
  List<String> employmentOptions = ['Option 1', 'Option 2', 'Option 3'];
  // Replace with actual options
  Future<void> fetchGenderOptions() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.71:8080/dropdown?titleId=101'),
      );
      if (response.statusCode == 200) {
        CommonObject commonObject =
            CommonObject.fromJson(json.decode(response.body));
        List<dynamic> options = commonObject.respBody['options'];

        setState(() {
          genderOptions = options;
        });
      } else {
        throw Exception(
            'Failed to load gender options: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchGenderOptions();
  }

  void saveFormDataToJson() {
    final name = _nameController.text;
    final mobile = _mobileController.text;
    final dob = _dobController.text;

    Map<String, dynamic> headData = {
      'name': name,
      'mobile': mobile,
      'dob': dob,
      'gender': {'value': _selectedGender},
      'education': {'value': _selectedEducation},
      'caste': {'value': _selectedCaste},
      'primaryEmployment': {'value': _selectedPrimaryEmployment},
      'secondaryEmployment': {'value': _selectedSecondaryEmployment},
    };

    Map<String, dynamic> householdData = {
      'head': headData,
    };

    String jsonData = json.encode({'household': householdData});

    File('form_data.json').writeAsStringSync(jsonData);
  }

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dobController.text) {
      setState(() {
        selectedDate = picked;
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  int calculateAge(DateTime? selectedDate) {
    if (selectedDate == null) return 0;
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - selectedDate.year;
    if (currentDate.month < selectedDate.month ||
        (currentDate.month == selectedDate.month &&
            currentDate.day < selectedDate.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Add Household',
            style: TextStyle(color: Colors.black),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Row(
              children: [
                Icon(
                  Icons.keyboard_arrow_left_outlined,
                  color: Colors.black,
                ),
                Text(
                  'Back',
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
          backgroundColor: Colors.grey[50],
          actions: <Widget>[
            IconButton(
              iconSize: 30,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const VdfHome(),
                  ),
                );
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Head of Family',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Head Name *',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Head Name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(10),
                    ],
                    controller: _mobileController,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Mobile Number *',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Mobile Number is required';
                      } else if (value!.length != 10) {
                        return 'Mobile Number should be 10 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 240,
                          child: TextFormField(
                            controller: _dobController,
                            readOnly: true, // Set the field to be read-only
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              labelText: 'Date of Birth *',
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20.0),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _selectDate(context);
                                },
                                icon: const Icon(
                                  Icons.calendar_month_outlined,
                                  color: CustomColorTheme.iconColor,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Date of Birth is required';
                              }
                              return null;
                            },
                          )),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: selectedDate != null
                                ? '${calculateAge(selectedDate)} yrs'
                                : 'Age(yrs)',
                            border: OutlineInputBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedGender,
                    items: genderOptions
                        .map<DropdownMenuItem<String>>((dynamic gender) {
                      return DropdownMenuItem<String>(
                        value: gender['titleData'].toString(),
                        child: Text(gender['titleData'].toString()),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedGender = newValue;
                      });
                    },
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Gender *',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: CustomColorTheme.iconColor,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Gender is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedCaste,
                    items: casteOptions
                        .map<DropdownMenuItem<String>>((dynamic caste) {
                      return DropdownMenuItem<String>(
                        value: caste['titleData'].toString(),
                        child: Text(caste['titleData'].toString()),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCaste = newValue;
                      });
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: CustomColorTheme.iconColor,
                    ),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Caste *',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Caste is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField(
                    value: _selectedPrimaryEmployment,
                    items: employmentOptions.map((String employment) {
                      return DropdownMenuItem(
                        value: employment,
                        child: Text(employment),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedPrimaryEmployment = newValue;
                      });
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: CustomColorTheme.iconColor,
                    ),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Primary Employment *',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Primary Employment is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField(
                    value: _selectedSecondaryEmployment,
                    items: employmentOptions.map((String employment) {
                      return DropdownMenuItem(
                        value: employment,
                        child: Text(employment),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedSecondaryEmployment = newValue;
                      });
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: CustomColorTheme.iconColor,
                    ),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Secondary Employment',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_validateFields &&
                      !(_formKey.currentState?.validate() ?? false))
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Please fill all the mandatory fields',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AddFamily(),
                            ),
                          );
                          setState(() {
                            _validateFields = true;
                          });
                          if (_formKey.currentState?.validate() ?? false) {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => const AddFamily(),
                            //   ),
                            // );
                            final name = _nameController.text;
                            final mobile = _mobileController.text;
                            final dob = _dobController.text;
                            saveFormDataToJson();
                          }
                        },
                        child: const Text('Next'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // All fields are valid, you can process the data
                            final name = _nameController.text;
                            final mobile = _mobileController.text;
                            final dob = _dobController.text;

                            // Perform actions with the field values

                            // Save as draft
                          }
                        },
                        child: Text(
                          'Save as Draft',
                          style: TextStyle(color: Colors.blue[900]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
