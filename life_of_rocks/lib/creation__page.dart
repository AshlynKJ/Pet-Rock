import 'package:flutter/material.dart';
import 'package:life_of_rocks/user_data_model.dart';
import 'package:provider/provider.dart';

class CreationPage extends StatelessWidget {
  const CreationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Choose Your Rock'),
        ),
        body: 
                Stack(
                  fit: StackFit.expand,
                  children: [LayoutBuilder(builder: (context, constraints) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Select()),
                          );
                        },
                        //'image_assets/rocks.jpg'
                        child:  Container(
                          child: Image(
                              alignment: Alignment.center,
                              image: AssetImage('image_assets/rocks.jpg'), fit: BoxFit.cover),
                        )
                    );})])
                            
                  
                                
                          
                ),
      );
    
  }
}


class Select extends StatefulWidget {
  const Select({super.key});

  @override
  State<Select> createState() => _SelectState();
}

class _SelectState extends State<Select> {
  TextEditingController text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Name your rock'),
      ),
      body: Consumer<UserDataModel>(
        builder: (context, state, child) => Center(
          child: SafeArea(
            child: OrientationBuilder(builder: (context, orientation) {
              return Flex(
                  direction: orientation == Orientation.portrait
                      ? Axis.vertical
                      : Axis.horizontal,
                  children: [
                    const Image(
                        image: AssetImage('image_assets/Rock_normal_none.png')),
                    TextFormField(
                      controller: text,
                    ),
                    ElevatedButton(
                        child: const Text("Name"),
                        onPressed: () {
                          state.createNewRock(text.text);
                          Future.delayed(const Duration(seconds: 1), () {
                            text.clear();
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            
                          });
                        }),
                  ]);
            }),
          ),
        ),
      ),
    );
  }
}
