import 'package:flutter/material.dart';
import 'package:life_of_rocks/user_data_model.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Food")),
      body: Consumer<UserDataModel>(
        builder: (context, state, child) => ListView.builder(
            itemCount: state.foods.length,
            prototypeItem: ListTile(
              title: Text(state.foods.first),
            ),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.foods[index]),
                onTap: () {
                  state.feedRock(20);
                  Navigator.pop(context);
                  if (state.myRock.currentHealth == 0) {
                    state.killRock();
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Your Rock Just Died!'),
                        content: const Text(
                            'Please do not feed rocks. They do not need food. Food just erodes them.'),
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
