import 'package:flutter/material.dart';
import 'package:life_of_rocks/user_data_model.dart';
import 'package:provider/provider.dart';

class SandboxPage extends StatelessWidget {
  const SandboxPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataModel>(
      builder: (context, state, child) => Scaffold(
        appBar: AppBar(title: const Text("The Sandbox")),
        body: ListView.builder(
            itemCount: state.getRocksKilled(),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.getPastRocks()[index],
                    style: Theme.of(context).textTheme.headlineMedium),
                subtitle: const Image(
                    image: AssetImage('image_assets/Rock_dust_none.png')),
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Congrats!'),
                      content: Text(
                          'This rock is dead. You have successfully killed ${state.getRocksKilled()} rock(s)!'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
      ),
    );

    /*return Consumer<UserDataModel>(
        builder: (context, state, child) =>
    Center(
      child: SafeArea(child: OrientationBuilder(builder: (context, orientation) {
        return Scaffold(
        appBar: AppBar(
          title: const Text('The Sandbox'), ),
          body: Flex(
            direction: orientation == Orientation.portrait
                ? Axis.vertical
                : Axis.horizontal,
            children: [
              Text('Congratulations, you have successfully killed ${state.getRocksKilled()} rock(s)!',
                  style: Theme.of(context).textTheme.headlineMedium),
                   SingleChildScrollView(
                    child: Column( 
                      children: [
                        ListView.builder(
            itemCount: state.getRocksKilled(),
            prototypeItem: ListTile(
              title: Text(state.getPastRocks().first),
            ),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.getPastRocks()[index]),
                onTap: () {
                  state.waterRock(5);
                  Navigator.pop(context);
                  if(state.my_rock.current_thirst == 0) {
                    state.killRock();
                    showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Your Rock Just Died!'),
                      content: const Text('Please do not water rocks. They do not need water. Water just erodes them.'),
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
            }
            )
                  ],
      
                  )),
      
            ]));
      })),
    )); */
  }
}
