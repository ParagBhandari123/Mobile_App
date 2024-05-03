import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class EmpData {
  final String name;
  final int age;
  final int salary;
  EmpData({
    required this.name,
    required this.age,
    required this.salary,
  });
}

class _MapScreenState extends State<MapScreen> {
  List<EmpData> empDataList = [];

  @override
  void initState() {
    super.initState();
    loadEmpData();
  }


  Future<void> loadEmpData() async {
    try {
      String csvData = await rootBundle.loadString('assets/emp.csv');
      List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);
      // Skip the header row
      rows.removeAt(0);
      setState(() {
        empDataList = rows.map(
              (row) {
            return EmpData(
              name: row[0].toString(),
              age: int.parse(row[1].toString()),
              salary: int.parse(row[2].toString()),
            );
          },
        ).toList();
      });
    } catch (e) {
      print('Error loading CSV data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'EmployeeDummy',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          children: empDataList.map((empData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${empData.name}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '${empData.age}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '${empData.salary}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                SizedBox(height: 16),
                Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
