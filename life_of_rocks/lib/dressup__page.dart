import 'package:flutter/material.dart';
import 'package:life_of_rocks/user_data_model.dart';

import 'package:provider/provider.dart';

class DressupPage extends StatelessWidget {
  const DressupPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hats'),
      ),
      body: Consumer<UserDataModel>(
          builder: (context, state, child) => ListView.builder(
              itemCount: state.hats.length,
              prototypeItem: ListTile(
                title: Text(state.hats.first),
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.hats[index]),
                  onTap: () {
                    state.changeHat(index);
                    Navigator.pop(context);
                  },
                );
              })),

      /*GridView.count(
          crossAxisCount: 2,
          children: List.generate(7, (index) {
            return Center(
              child: Text(
                'Hat $index',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            );
            
          }),
          
        ),*/
    );
  }
}
