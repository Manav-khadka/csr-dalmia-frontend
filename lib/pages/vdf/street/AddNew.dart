import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Addnew extends StatefulWidget {
  final String? village;
  final String? panchayat;
  final String? villagId;

  const Addnew({
    super.key,
    this.village,
    this.panchayat,
    this.villagId,
  });
  @override
  _AddnewState createState() => _AddnewState();
}

class _AddnewState extends State<Addnew> {
  String? streetName;
  String? streetCode;
  int? numberOfHouseholds;
  bool streetpresent = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: true,
            title: const Text(
              'Add a Street',
              style: TextStyle(color: Colors.black),
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
            child: Center(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    height: 100,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 232, 253, 233)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Panchayat:  '),
                        Text('Village   ${widget.village} ')
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          streetName = value;
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Enter Street Name')),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          streetCode = value;
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Enter Street Code')),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      //  keyboardType: TextInputType.streetAddress,
                      onChanged: (value) {
                        setState(() {
                          numberOfHouseholds = int.tryParse(value) ?? 0;
                        });
                      },

                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Enter Number of Households')),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(350, 50),
                        backgroundColor: streetName != null &&
                                streetCode != null
                            ? CustomColorTheme.primaryColor
                            : CustomColorTheme.primaryColor.withOpacity(0.7)),
                    onPressed: () {
                      if (streetName != null && streetCode != null) {
                        _addStreetAPI(
                            streetName!, numberOfHouseholds!, streetCode!);
                        _confirmbox(context, streetName!);
                      }
                    },
                    child: const Text(
                      'Add Street',
                      style: TextStyle(fontSize: CustomFontTheme.textSize),
                    ),
                  ),
                  if (streetpresent) ...[
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'This street name and street code are already added to the village.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          color: Color(0xFFEC2828),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Text(
                        'Check all streets added to the village here',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: CustomFontTheme.textSize,
                          color: Color(0xFFEC2828),
                        ),
                      ),
                    )
                  ]
                ],
              ),
            ),
          )),
    );
  }
}

void _confirmbox(BuildContext context, String streetName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 40,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                  '"$streetName" is added successfully. What do you wish to do next?'),
            ],
          ),
        ),
        content: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                side: const BorderSide(width: 1, color: Colors.blue),
              ),
              onPressed: () {
                // Perform actions with the field values

                // Save as draft
              },
              child: const Text(
                'Add another street in same village',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                side: const BorderSide(width: 1, color: Colors.blue),
              ),
              onPressed: () {
                // Perform actions with the field values

                // Save as draft
              },
              child: const Text(
                'Add household details for this street',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                minimumSize: const Size(250, 50),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Save and Close'),
            ),
          ],
        ),
      );
    },
  );
}

Future<void> _addStreetAPI(
    String streetName, int householdCount, String streetCode) async {
  final apiUrl =
      'https://s82wf372-8080.inc1.devtunnels.ms:443/add-streets?villageId=10001&streetName=$streetName&householdCount=$householdCount&streetCode=$streetCode';
  try {
    final response = await http.put(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Handle successful response
      print('Street added successfully');
    } else {
      // Handle error response
      print('Failed to add street. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (error) {
    // Handle network or other errors
    print('Error: $error');
  }
}
