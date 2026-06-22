import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Rock {
  String name;
  int totalHealth;
  int currentHealth;
  int totalThirst;
  int currentThirst;
  int hat;
  bool isDead;

  Rock(this.name, this.totalHealth, this.currentHealth, this.totalThirst,
      this.currentThirst, this.hat, this.isDead);
}

class UserDataModel extends ChangeNotifier {
  int rocksOwned = 1;
  bool firstLaunch = true;

  Rock myRock = Rock('Rocky Road', 100, 50, 20, 15, 0, false);

  final List<String> hats = [
    "none",
    "straw hat",
    "party hat",
    "baseball hat",
    "cowboy hat",
    "fedora",
  ];

  final List<Image> rockPictures = [
    const Image(image: AssetImage('image_assets/Rock_normal_none.png')),
    const Image(image: AssetImage('image_assets/Rock_normal_straw.png')),
    const Image(image: AssetImage('image_assets/Rock_normal_party.png')),
    const Image(image: AssetImage('image_assets/Rock_normal_baseball.png')),
    const Image(image: AssetImage('image_assets/Rock_normal_cowboy.png')),
    const Image(image: AssetImage('image_assets/Rock_normal_fedora.png')),
    const Image(image: AssetImage('image_assets/Rock_damage_none.png')),
    const Image(image: AssetImage('image_assets/Rock_damage_straw.png')),
    const Image(image: AssetImage('image_assets/Rock_damage_party.png')),
    const Image(image: AssetImage('image_assets/Rock_damage_baseball.png')),
    const Image(image: AssetImage('image_assets/Rock_damage_cowboy.png')),
    const Image(image: AssetImage('image_assets/Rock_damage_fedora.png')),
    const Image(image: AssetImage('image_assets/Rock_dust_none.png')),
    const Image(image: AssetImage('image_assets/Rock_dust_straw.png')),
    const Image(image: AssetImage('image_assets/Rock_dust_party.png')),
    const Image(image: AssetImage('image_assets/Rock_dust_baseball.png')),
    const Image(image: AssetImage('image_assets/Rock_dust_cowboy.png')),
    const Image(image: AssetImage('image_assets/Rock_dust_fedora.png')),
  ];

  final List<String> rockPictureLocations = [
     'image_assets/Rock_normal_none.png',
     'image_assets/Rock_normal_straw.png',
     'image_assets/Rock_normal_party.png',
     'image_assets/Rock_normal_baseball.png',
     'image_assets/Rock_normal_cowboy.png',
     'image_assets/Rock_normal_fedora.png',
     'image_assets/Rock_damage_none.png',
     'image_assets/Rock_damage_straw.png',
     'image_assets/Rock_damage_party.png',
     'image_assets/Rock_damage_baseball.png',
     'image_assets/Rock_damage_cowboy.png',
     'image_assets/Rock_damage_fedora.png',
     'image_assets/Rock_dust_none.png',
     'image_assets/Rock_dust_straw.png',
     'image_assets/Rock_dust_party.png',
     'image_assets/Rock_dust_baseball.png',
     'image_assets/Rock_dust_cowboy.png',
     'image_assets/Rock_dust_fedora.png',
  ];

  final List<String> foods = [
    "pasta",
    "cookies",
    "lettuce",
    "cheetos",
    "cake",
    "pancakes",
  ];

  final List<String> water = [
    "tap water",
    "bottled water",
    "lake water",
    "ocean water",
  ];

  List<String> pastRocks = [];

  Future<void> killRock() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    pastRocks.add(myRock.name);

    prefs.setStringList('pastRocks', pastRocks);

    notifyListeners();
  }

  Future<void> initFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    firstLaunch = prefs.getBool('fLaunch') ?? true;

    myRock.name = prefs.getString('name') ?? 'Rocky Road';

    myRock.hat = prefs.getInt('hat') ?? 100;

    myRock.totalHealth = prefs.getInt('totalHealth') ?? 100;

    myRock.currentHealth = prefs.getInt('currentHealth') ?? 50;

    myRock.totalThirst = prefs.getInt('totalThirst') ?? 20;

    myRock.currentThirst = prefs.getInt('currentThirst') ?? 15;

    myRock.isDead = prefs.getBool('isDead') ?? true;

    pastRocks = prefs.getStringList('pastRocks') ?? <String>[];

    notifyListeners();
  }

  Future<void> updateRockInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', myRock.name);
    prefs.setInt('totalHealth', myRock.totalHealth);
    prefs.setInt('currentHealth', myRock.currentHealth);
    prefs.setInt('totalThirst', myRock.totalThirst);
    prefs.setInt('currentThirst', myRock.currentThirst);
    prefs.setInt('hat', myRock.hat);
    prefs.setBool('isDead', myRock.isDead);
  }



  void incRocksOwned() {
    ++rocksOwned;

    notifyListeners();
  }

  void feedRock(int damage) {
    if (myRock.currentHealth - damage > 0) {
      myRock.currentHealth -= damage;
    } else {
      myRock.currentHealth = 0;
      myRock.isDead = true;
    }
    updateRockInfo();

    notifyListeners();
  }

  int damageLevel() {
    if (myRock.currentHealth / myRock.totalHealth < 0.2 ||
        myRock.currentThirst / myRock.totalThirst < 0.2) {
      return 2;
    } else if (myRock.currentHealth / myRock.totalHealth < 0.5 ||
        myRock.currentThirst / myRock.totalThirst < 0.5) {
      return 1;
    } else {
      return 0;
    }
  }

  void waterRock(int damage) {
    if (myRock.currentThirst - damage > 0) {
      myRock.currentThirst -= damage;
    } else {
      myRock.currentThirst = 0;
      myRock.isDead = true;
    }
    updateRockInfo();
    notifyListeners();
  }

  void changeHat(int newHat) {
    myRock.hat = newHat;
    updateRockInfo();
    notifyListeners();
  }

  int getRocksKilled() {
    return pastRocks.length;
  }

  List<String> getPastRocks() {
    return pastRocks;
  }

  void createNewRock(String name) {
    myRock = Rock(name, 100, 100, 100, 100, 0, false);
    updateRockInfo();
    notifyListeners();
  }
}
