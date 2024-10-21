import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_demo/load_data.dart';
import 'package:shared_preferences_demo/outline_button.dart';

class SaveData extends StatefulWidget {
  const SaveData({super.key});

  @override
  State<SaveData> createState() => _SaveDataState();
}

class _SaveDataState extends State<SaveData> {
  final TextEditingController nameController = TextEditingController();
  int? setIcon1;
  int? setIcon2;

  final List<IconData> _icons = [
    Icons.add,
    Icons.home,
    Icons.access_time,
    Icons.flight,
  ];

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', nameController.text);
    prefs.setInt('icon1', setIcon1!);
    prefs.setInt('icon2', setIcon2!);

    setState(() {
      nameController.clear();
      setIcon1 = 0 - 1;
      setIcon2 = 0 - 1;
    });

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoadData()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Text("Save Data!"),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Enter Name",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _icons.length,
                  (index) {
                    return IconButton(
                      color: setIcon1 == index ? Colors.blue : Colors.black,
                      onPressed: () {
                        setState(() {
                          setIcon1 = index;
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
                          setIcon2 = index;
                        });
                      },
                      color: setIcon2 == index ? Colors.blue : Colors.black,
                      icon: Icon(_icons[index]),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AnimatedOutlineButton(
                onPressed: saveData,
                title: "SAVE",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
