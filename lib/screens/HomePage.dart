import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestion_taches/screens/ajoutTaches.dart';
import 'package:gestion_taches/screens/controle.page.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Une fois authentifié, redirigez vers la page d'ajout de tâches
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ControlePage(),
      ));
    } catch (e) {
      // En cas d'échec de l'authentification, affichez un message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur d\'authentification : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page d\'Accueil'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _signInWithEmailAndPassword(context),
              child: Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}
