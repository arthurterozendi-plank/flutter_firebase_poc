import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../app_router.dart';
import '../../models/user.dart';
import '../../services/auth_services.dart';
import '../../services/user_firestore_services.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    if (FirebaseAuth.instance.currentUser == null ||
        FirebaseAuth.instance.currentUser?.uid == null) {
      return;
    }
    final userData =
        await UserFirestoreService.getUser(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      _user = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    void signOut() async {
      await AuthService.signOut();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: () {
              signOut();
              AppRouter.navigateToAndReplace(context, Routes.login);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome to the Home Page ${_user?.name}'),
              Text('Email: ${_user?.email}'),
              Text('Created At: ${_user?.createdAt}'),
            ],
          ),
        ),
      ),
    );
  }
}
