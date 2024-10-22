import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_demo/load_data.dart';
import 'package:shared_preferences_demo/outline_button.dart';

class UpdateData extends StatefulWidget {
  const UpdateData({super.key});

  @override
  _UpdateDataState createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  final TextEditingController _nameController = TextEditingController();
  int? _selectedIcon1;
  int? _selectedIcon2;

  final List<IconData> _icons = [
    Icons.add,
    Icons.home,
    Icons.access_time,
    Icons.flight,
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? "";
      _selectedIcon1 = prefs.getInt('icon1');
      _selectedIcon2 = prefs.getInt('icon2');
    });
  }

  Future<void> updateData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    if (_selectedIcon1 != null) {
      await prefs.setInt('icon1', _selectedIcon1!);
    }
    if (_selectedIcon2 != null) {
      await prefs.setInt('icon2', _selectedIcon2!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _icons.length,
                (index) {
                  return IconButton(
                    color: _selectedIcon1 == index ? Colors.blue : Colors.black,
                    onPressed: () {
                      setState(() {
                        _selectedIcon1 = index;
                      });
                    },
                    icon: Icon(_icons[index]),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _icons.length,
                (index) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedIcon2 = index;
                      });
                    },
                    color: _selectedIcon2 == index ? Colors.blue : Colors.black,
                    icon: Icon(_icons[index]),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            AnimatedOutlineButton(
              onPressed: () {
                updateData().then((_) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoadData(),
                      )); // Go back to LoadData page
                });
              },
              title: "UPDATE",
            ),
          ],
        ),
      ),
    );
  }
}
