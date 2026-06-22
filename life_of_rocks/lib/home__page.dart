import 'package:flutter/material.dart';
import 'package:life_of_rocks/creation__page.dart';
import 'package:life_of_rocks/dressup__page.dart';
import 'package:life_of_rocks/food__page.dart';
import 'package:life_of_rocks/sandbox__page.dart';
import 'package:life_of_rocks/watering__page.dart';
import 'package:provider/provider.dart';
import 'package:life_of_rocks/user_data_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Flex(
          direction: orientation == Orientation.portrait
              ? Axis.vertical
              : Axis.horizontal,
          children: [
            
              Expanded(
                child: Column(children: [
                  Consumer<UserDataModel>(
                      builder: (context, state, child) => Text(state.myRock.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center)),
                  
                     Consumer<UserDataModel>(
                            builder: (context, state, child)  {
                          return  Flexible(
                            child: Image(
                              image:  AssetImage(state.rockPictureLocations[
                                        state.myRock.hat + 6 * state.damageLevel()]), 
                              fit: BoxFit.fill),
                          );
                        }
                      )
                ]),
              ),
            
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => 
                Column(children: [
                  Text(
                    "Health",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const HealthBar(),
                  Center(
                    child: Text(
                      "Thirst",
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const ThirstBar(),
                  Consumer<UserDataModel>(builder: (context, state, child) {
                    return state.myRock.isDead
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FilledButton(
                                child: const Text("Adopt a New Rock"),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreationPage()));
                                }),
                          )
                        : const navigator();
                  }),
                  Consumer<UserDataModel>(builder: (context, state, child) {
                    if (state.pastRocks.isNotEmpty) {
                      return FilledButton(
                          child: const Text("Visit the Sandbox"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SandboxPage()));
                          });
                    } else {
                      return Container();
                    }
                  })
                ]),
              ),
            ),
          ]);
    });
  }
}

class navigator extends StatelessWidget {
  const navigator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          GestureDetector(
            child: Container(
              height: constraints.biggest.shortestSide * 0.2,
              width: constraints.maxWidth / 4,
              margin: EdgeInsets.all(constraints.maxWidth / 24),
              color: const Color.fromARGB(255, 99, 13, 13),
              child: Icon(
                Icons.food_bank,
                color: Colors.white,
                size: constraints.maxWidth / 5,
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FoodPage()));
            },
          ),
          GestureDetector(
            child: Container(
              height: constraints.biggest.shortestSide * 0.2,
              width: constraints.maxWidth / 4,
              margin: EdgeInsets.all(constraints.maxWidth / 24),
              color: const Color.fromARGB(255, 207, 57, 57),
              child: Icon(
                Icons.water_drop,
                color: Colors.white,
                size: constraints.maxWidth / 5,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WateringPage()));
            },
          ),
          GestureDetector(
            child: Container(
              height: constraints.biggest.shortestSide * 0.2,
              width: constraints.maxWidth / 4,
              margin: EdgeInsets.all(constraints.maxWidth / 24),
              color: const Color.fromARGB(255, 165, 104, 104),
              child: Icon(
                Icons.headphones,
                color: Colors.white,
                size: constraints.maxWidth / 5,
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const DressupPage()));
            },
          ),
        ],
      );
    });
  }
}

class HealthBar extends StatelessWidget {
  const HealthBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataModel>(
      builder: (context, state, child) => Stack(children: [
        LayoutBuilder(builder: (context, constraints) {
          return Container(
              height: constraints.biggest.shortestSide * 0.05,
              width: constraints.maxWidth,
              color: const Color.fromARGB(255, 99, 13, 13));
        }),
        LayoutBuilder(builder: (context, constraints) {
          return Container(
              height: constraints.biggest.shortestSide * 0.05,
              width: constraints.maxWidth *
                  (state.myRock.currentHealth / state.myRock.totalHealth),
              color: const Color.fromARGB(255, 255, 0, 0));
        }),
      ]),
    );
  }
}

class ThirstBar extends StatelessWidget {
  const ThirstBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataModel>(
      builder: (context, state, child) => Stack(children: [
        LayoutBuilder(builder: (context, constraints) {
          return Container(
              height: constraints.biggest.shortestSide * 0.05,
              width: constraints.maxWidth,
              color: const Color.fromARGB(255, 13, 53, 99));
        }),
        LayoutBuilder(builder: (context, constraints) {
          return Container(
              height: constraints.biggest.shortestSide * 0.05,
              width: constraints.maxWidth *
                  (state.myRock.currentThirst / state.myRock.totalThirst),
              color: const Color.fromARGB(255, 0, 157, 255));
        }),
      ]),
    );
  }
}
