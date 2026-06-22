import 'package:flutter/material.dart';
import 'package:life_of_rocks/user_data_model.dart';
import 'package:provider/provider.dart';

class WateringPage extends StatelessWidget {
  const WateringPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drinks")),
      body: Consumer<UserDataModel>(
        builder: (context, state, child) => ListView.builder(
            itemCount: state.water.length,
            prototypeItem: ListTile(
              title: Text(state.water.first),
            ),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.water[index]),
                onTap: () {
                  state.waterRock(5);
                  Navigator.pop(context);
                  if (state.myRock.currentThirst == 0) {
                    state.killRock();
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Your Rock Just Died!'),
                        content: const Text(
                            'Please do not water rocks. They do not need water. Water just erodes them.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            }),
      ),
    );
  }
}
