import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instakilo/screens/addPost_screen.dart';
import 'package:instakilo/screens/home_screen.dart';
import 'package:instakilo/screens/search_screen.dart';
import 'package:instakilo/screens/profile_screen.dart';

const webScreenSize = 600;

var homeScreenItems = [
  const HomeScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('activity'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
