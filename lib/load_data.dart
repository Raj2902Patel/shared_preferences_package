import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_demo/outline_button.dart';
import 'package:shared_preferences_demo/save_data.dart';
import 'package:shared_preferences_demo/update_data.dart';

class LoadData extends StatefulWidget {
  const LoadData({super.key});

  @override
  State<LoadData> createState() => _LoadDataState();
}

class _LoadDataState extends State<LoadData>
    with SingleTickerProviderStateMixin {
  String? name;
  int? icon1;
  int? icon2;

  final List<IconData> _icons = [
    Icons.add,
    Icons.home,
    Icons.access_time,
    Icons.flight,
  ];

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      icon1 = prefs.getInt('icon1');
      icon2 = prefs.getInt('icon2');
    });
  }

  Future<void> clearAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    setState(() {
      loadData();
    }); // Deletes all saved data
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Text("Load Data!"),
        ),
      ),
      body: Column(
        children: [
          name != null && icon1 != null && icon2 != null
              ? Column(
                  children: [
                    Text(name!),
                    const SizedBox(
                      height: 15,
                    ),
                    Icon(_icons[icon1!]),
                    const SizedBox(
                      height: 15,
                    ),
                    Icon(_icons[icon2!]),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                )
              : const Text(""),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (name != null && icon1 != null && icon2 != null) ...[
                AnimatedOutlineButton(
                  title: 'UPDATE',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UpdateData(),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 15),
                AnimatedOutlineButton(
                  onPressed: () {
                    clearAllData();
                    setState(() {});
                  },
                  title: "CLEAR DATA",
                ),
                const SizedBox(width: 15),
              ],
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          AnimatedOutlineButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SaveData(),
                  ));
            },
            title: "SET DATA",
          ),
        ],
      ),
    );
  }
}
