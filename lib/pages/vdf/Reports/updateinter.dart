import 'package:dalmia/common/bottombar.dart';
import 'package:dalmia/components/reportappbar.dart';

import 'package:dalmia/pages/vdf/Draft/draft.dart';

import 'package:dalmia/pages/vdf/household/addhouse.dart';

import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

import 'dart:math';

class UpdateIntervention extends StatefulWidget {
  const UpdateIntervention({Key? key}) : super(key: key);

  @override
  State<UpdateIntervention> createState() => _UpdateInterventionState();
}

class _UpdateInterventionState extends State<UpdateIntervention> {
  int? selectedRadio;
  void _onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    if (selectedIndex == 0) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const VdfHome(),
        ),
      );
    } else if (selectedIndex == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MyForm(),
        ),
      );
    } else if (selectedIndex == 2) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddStreet(),
        ),
      );
    } else if (selectedIndex == 3) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Draft(),
        ),
      );
    }
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    // final List<int> householdList =
    //     List.generate(10, (index) => random.nextInt(100));
    // final List<int> populationList =
    //     List.generate(10, (index) => random.nextInt(100));

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: ReportAppBar(
              heading: 'Update Intervention',
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'AROSKMTS001',
                        style: TextStyle(
                            fontSize: CustomFontTheme.textSize,
                            fontWeight: CustomFontTheme.headingwt),
                      ),
                      const Text(
                        'Vermicompost-Permanent \n structure New 10ft x 2ft',
                        style: TextStyle(
                            fontSize: CustomFontTheme.textSize,
                            fontWeight: CustomFontTheme.labelwt),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Details',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Selected',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Names',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Intervention planned',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Intervention completed',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Expected additional income p/a',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Actual annual income',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Row(
                                children: [
                                  Text(
                                    'Follow ups for income update',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Row(
                                    children: [
                                      Text('int.1',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      Text('int.2',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      Text('int.3',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      Text('int.4',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      Text('int.5',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => CustomColorTheme.secondaryColor),
                          rows: const <DataRow>[
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('Follow up 1')),
                                DataCell(Text('Yes')),
                                DataCell(Text('John Doe')),
                                DataCell(Text('Intervention 1')),
                                DataCell(Text('Yes')),
                                DataCell(Text('500')),
                                DataCell(Text('600')),
                                DataCell(Text('')),
                              ],
                            ),
                            DataRow(
                              cells: <DataCell>[
                                DataCell(
                                  Text(
                                    'Follow up 2',
                                  ),
                                ),
                                DataCell(Text('No')),
                                DataCell(Text('Jane Smith')),
                                DataCell(Text('Intervention 2')),
                                DataCell(Text('No')),
                                DataCell(Text('300')),
                                DataCell(Text('400')),
                                DataCell(Text('')),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(350, 50),
                      backgroundColor: CustomColorTheme.primaryColor),
                  onPressed: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => const AddHead(),
                    //   ),
                    // );
                  },
                  child: const Text(
                    'Save Update',
                    style: TextStyle(fontSize: CustomFontTheme.textSize),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        side: BorderSide(
                            color: CustomColorTheme.primaryColor, width: 1),
                        minimumSize: const Size(350, 50),
                        backgroundColor: CustomColorTheme.backgroundColor),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Call Beneficiary',
                        style: TextStyle(color: CustomColorTheme.primaryColor),
                      ),
                    )),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 10,
          child: SizedBox(
            height: 67,
            child: SizedBox(
              height: 67,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTabItem(
                    imagePath: 'images/Dashboard_Outline.svg',
                    label: "Dashboard",
                    index: 0,
                    selectedIndex: 5,
                    onTabTapped: _onTabTapped,
                  ),
                  CustomTabItem(
                    imagePath: 'images/Household_Outline.svg',
                    label: "Add Household",
                    index: 1,
                    selectedIndex: 5,
                    onTabTapped: _onTabTapped,
                  ),
                  CustomTabItem(
                    imagePath: 'images/Street_Outline.svg',
                    label: "Add Street",
                    index: 2,
                    selectedIndex: 5,
                    onTabTapped: _onTabTapped,
                  ),
                  CustomTabItem(
                    imagePath: 'images/Drafts_Outline.svg',
                    label: "Drafts",
                    index: 3,
                    selectedIndex: 5,
                    onTabTapped: _onTabTapped,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
