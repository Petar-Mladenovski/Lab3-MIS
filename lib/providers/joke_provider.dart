import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/joke.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_services.dart';
import 'package:path/path.dart' as path;

class JokeProvider extends ChangeNotifier {
  final List<Joke> jokes = [];
  bool _isObscure = true;
  File? _img = null;

  JokeProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    await initJokeTypesFromAPI();
  }

  Future<void> initJokeTypesFromAPI() async {
    try {
      List<String> jokeTypes = await ApiServices.getJokeTypes();
      for (var jokeType in jokeTypes) {
        List<Joke> jokesByType = await ApiServices.getJokesByType(jokeType);
        jokes.addAll(jokesByType);
      }

      notifyListeners();
    } catch (e, stackTrace) {
      print(stackTrace);
    }
  }

  bool get isObscure => _isObscure;
  File? get image => _img;

  void toggleFavorite(Joke joke) {
    joke.isFavorite = !joke.isFavorite;
    notifyListeners();
  }

  void toggleVisibility() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    try{
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _img = File(pickedFile.path);
        print(_img!.path);
        notifyListeners();
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadImage() async {
    if (_img == null) return;
    notifyListeners();
    try {
      String fileName = path.basename(_img!.path);
      Reference storageRef = FirebaseStorage.instance.ref().child('profile_pictures/$fileName');
      await storageRef.putFile(_img!);
      String downloadUrl = await storageRef.getDownloadURL();
      await FirebaseAuth.instance.currentUser?.updatePhotoURL(downloadUrl);
    } catch (e) {
      print('Error uploading image: $e');
    } finally {
      notifyListeners();
    }
  }
}
