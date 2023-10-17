import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: const Text('Transação'),
              onTap: () {
                // Redireciona para a tela de transação
                Navigator.pushNamed(context, '/transacao');
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Contatos'),
              onTap: () {
                // Redireciona para a tela de contatos
                Navigator.pushNamed(context, '/contatos');
              },
            ),
          ),
        ],
      ),
    );
  }
}
