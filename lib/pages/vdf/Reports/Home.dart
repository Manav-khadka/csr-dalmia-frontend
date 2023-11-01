import 'package:dalmia/pages/vdf/Reports/Business.dart';
import 'package:dalmia/pages/vdf/Reports/Cumulative.dart';
import 'package:dalmia/pages/vdf/Reports/Form1.dart';
import 'package:dalmia/pages/vdf/Reports/Leverwise.dart';
import 'package:dalmia/pages/vdf/Reports/Livehood.dart';
import 'package:dalmia/pages/vdf/Reports/Top20.dart';
import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeReport extends StatefulWidget {
  const HomeReport({Key? key}) : super(key: key);

  @override
  State<HomeReport> createState() => _HomeReportState();
}

class _HomeReportState extends State<HomeReport> {
  int? selectedRadio;
  int _selectedIndex = 0; // Track the currently selected tab index

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: reportappbar(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton.icon(
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF008CD3),
                        foregroundColor: Colors.white),
                    onPressed: () {
                      _reportpopup(context);
                    },
                    icon: Icon(Icons.folder_outlined),
                    label: Text(
                      'View other Reports',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                const SizedBox(height: 00),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,

                      // decoration: BoxDecoration(

                      //     borderRadius: BorderRadius.circular(20),
                      //     color: Colors.white60),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: const Text(
                              'Report of Balamurugan',
                              style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt),
                            ),
                          ),
                          TextButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                Icons.calendar_month_outlined,
                                color: CustomColorTheme.iconColor,
                              ),
                              label: Text(
                                '01 Jan 2021 - 01 Jan 2023',
                                style: TextStyle(
                                    color: CustomColorTheme.primaryColor),
                              )),
                          Divider(
                            color: Colors
                                .grey, // Add your desired color for the line
                            thickness:
                                1, // Add the desired thickness for the line
                          ),
                          DataTable(
                            dividerThickness: 0.0,
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Data 1',
                                    // style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Data',
                                    // style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                            rows: <DataRow>[
                              celldata(
                                  'Total Households in working area', '2473'),
                              celldata('Total Households mapped', '2473'),
                              celldata(
                                  'Total Households selected for Intervention',
                                  '2473'),
                              celldata('Total Interventions planned', '2473'),
                              celldata('Total Interventions completed', '2473'),
                              celldata('Households earning additional income',
                                  '2473'),
                              celldata('Rs.25K - Rs.50K addl. income', '2473'),
                              celldata('Rs.50K - Rs.75K addl. income', '2473'),
                              celldata('Rs.75K - Rs.1L addl. income', '2473'),
                              celldata('More than Rs.1L addl. income', '2473'),
                              celldata('Aggregated additional income', '2473'),

                              // Add more rows as needed
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildTabItem('images/Dashboard_Outline.svg', "Dashboard", 0),
              buildTabItem('images/Household_Outline.svg', "Add Household", 1),
              buildTabItem('images/Street_Outline.svg', "Add Street", 2),
              buildTabItem('images/Drafts_Outline.svg', "Drafts", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabItem(String imagePath, String label, int index) {
    final isSelected = index == 0;
    final color = isSelected ? Colors.blue : Colors.black;

    return InkWell(
      onTap: () {
        _onTabTapped(index);
        if (index == 1) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MyForm(),
            ),
          );
        }
        if (index == 2) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddStreet(),
            ),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            imagePath,
            // width: 24, // Adjust the width as needed
            // height: 24, // Adjust the height as needed
          ),
          Text(
            label,
            style: TextStyle(
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _reportpopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('View other Reports'),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.close),
                      ),
                    ],
                  ),
                  RadioListTile<int>(
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'Form 1 Gram Parivartan',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt,
                          color: selectedRadio == 1
                              ? CustomColorTheme.iconColor
                              : CustomColorTheme.textColor),
                    ),
                    value: 1,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'Cumulative Household data',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt,
                          color: selectedRadio == 2
                              ? CustomColorTheme.iconColor
                              : CustomColorTheme.textColor),
                    ),
                    value: 2,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'Leverwise number of interventions',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt,
                          color: selectedRadio == 3
                              ? CustomColorTheme.iconColor
                              : CustomColorTheme.textColor),
                    ),
                    value: 3,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'Top 20 additional income HH',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt,
                          color: selectedRadio == 4
                              ? CustomColorTheme.iconColor
                              : CustomColorTheme.textColor),
                    ),
                    value: 4,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'List of Business Plans engaged',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt,
                          color: selectedRadio == 5
                              ? CustomColorTheme.iconColor
                              : CustomColorTheme.textColor),
                    ),
                    value: 5,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'Livelihood Funds Utilization',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt,
                          color: selectedRadio == 6
                              ? CustomColorTheme.iconColor
                              : CustomColorTheme.textColor),
                    ),
                    value: 6,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                ],
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColorTheme.primaryColor),
                    onPressed: () {
                      if (selectedRadio == 1) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Form1(),
                          ),
                        );
                      } else if (selectedRadio == 2) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Cumulative(),
                          ),
                        ); // Navigate to the corresponding tab
                      } else if (selectedRadio == 3) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Leverwise(),
                          ),
                        ); // Navigate to the corresponding tab
                      } else if (selectedRadio == 4) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Top20(),
                          ),
                        );
                        // Navigate to the corresponding tab
                      } else if (selectedRadio == 5) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BusinessPlan(),
                          ),
                        );
                        // Navigate to the corresponding tab
                      } else if (selectedRadio == 6) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LivehoodPlan(),
                          ),
                        ); // Navigate to the corresponding tab
                      }
                    },
                    child: const Text('View Reports'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

DataRow celldata(String left, String right) {
  return DataRow(
    cells: <DataCell>[
      DataCell(
        Expanded(
          child: Text(
            left,
            style: TextStyle(
                fontSize: CustomFontTheme.textSize,
                fontWeight: CustomFontTheme.textwt),
          ),
        ),
      ),
      DataCell(
        Expanded(
          child: Text(
            right,
            style: TextStyle(
                fontSize: CustomFontTheme.textSize,
                fontWeight: CustomFontTheme.headingwt),
          ),
        ),
      ),
    ],
  );
}

class reportappbar extends StatelessWidget {
  const reportappbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 20,
      backgroundColor: Colors.white,
      title: const Image(image: AssetImage('images/icon.jpg')),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        CircleAvatar(
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_outlined,
              // color: Colors.blue,
            ),
          ),
        ),
        const SizedBox(width: 20),
        IconButton(
          iconSize: 30,
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          padding: const EdgeInsets.only(left: 30, bottom: 10),
          alignment: Alignment.topCenter,
          color: Colors.white,
          child: const Text(
            'Reports',
            style: TextStyle(
                fontSize: CustomFontTheme.textSize,
                fontWeight: CustomFontTheme.headingwt),
          ),
        ),
      ),
    );
  }
}
