import 'package:flutter/material.dart';

class Newtest extends StatefulWidget {
  const Newtest({Key? key}) : super(key: key);

  @override
  State<Newtest> createState() => _NewtestState();
}

class _NewtestState extends State<Newtest> {
  int number = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                number++;
              });
            },
            child: Text(number.toString()),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                number--;
              });
            },
            child: Text(number.toString()),
          ),
        ],
      ),
    );
  }
}

class TestProvider with ChangeNotifier {
  int number = 0;
  void incremntnumber() {
    number++;
    notifyListeners();
  }
}
