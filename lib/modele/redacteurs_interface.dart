import 'package:flutter/material.dart';
import '../Services/database_manager.dart';
import '../modele/Redacteur.dart';

class RedacteursInterface extends StatefulWidget {
  const RedacteursInterface({super.key});

  @override
  State<RedacteursInterface> createState() => _RedacteursInterfaceState();
}

class _RedacteursInterfaceState extends State<RedacteursInterface> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Liste locale des rédacteurs
  List<Redacteur> _redacteurs = [];

  @override
  void initState() {
    super.initState();
    _loadRedacteurs();
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  /// Charger tous les rédacteurs depuis la base
  void _loadRedacteurs() async {
    final redacteurs = await DatabaseManager.getAllRedacteurs();
    setState(() {
      _redacteurs = redacteurs;
    });
  }

  /// Ajouter un rédacteur
  void _ajouterRedacteur() async {
    if (_nomController.text.isNotEmpty &&
        _prenomController.text.isNotEmpty &&
        _emailController.text.isNotEmpty) {
      final redacteur = Redacteur.withoutId(
        nom: _nomController.text.trim(),
        prenom: _prenomController.text.trim(),
        email: _emailController.text.trim(),
      );

      await DatabaseManager.insertRedacteur(redacteur);

      // Réinitialiser les champs
      _nomController.clear();
      _prenomController.clear();
      _emailController.clear();

      _loadRedacteurs();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Supprimer avec confirmation
  void _supprimerRedacteurAvecConfirmation(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text(
          'Êtes-vous sûr de vouloir supprimer ce rédacteur ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () async {
              await DatabaseManager.deleteRedacteur(id);
              Navigator.of(context).pop();
              _loadRedacteurs();
            },
            child: const Text(
              'Supprimer',
              style: TextStyle(color: Colors.pink),
            ),
          ),
        ],
      ),
    );
  }

  /// Modifier un rédacteur
  void _modifierRedacteur(Redacteur redacteur) {
    _nomController.text = redacteur.nom;
    _prenomController.text = redacteur.prenom;
    _emailController.text = redacteur.email;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifier le rédacteur'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nomController,
              decoration: const InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: _prenomController,
              decoration: const InputDecoration(labelText: 'Prénom'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (_nomController.text.trim().isEmpty ||
                  _prenomController.text.trim().isEmpty ||
                  _emailController.text.trim().isEmpty) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Veuillez remplir tous les champs.'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              final updatedRedacteur = Redacteur(
                id: redacteur.id,
                nom: _nomController.text.trim(),
                prenom: _prenomController.text.trim(),
                email: _emailController.text.trim(),
              );

              await DatabaseManager.updateRedacteur(updatedRedacteur);
              Navigator.of(context).pop();
              _loadRedacteurs();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Rédacteur mis à jour avec succès.'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Enregistrer'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Rédacteurs'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomController,
              decoration: const InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: _prenomController,
              decoration: const InputDecoration(labelText: 'Prénom'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _ajouterRedacteur,
              icon: const Icon(Icons.add),
              label: const Text('Ajouter un rédacteur'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _redacteurs.length,
                itemBuilder: (context, index) {
                  final r = _redacteurs[index];
                  return ListTile(
                    title: Text("${r.nom} ${r.prenom}"),
                    subtitle: Text(r.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.pink),
                          onPressed: () => _modifierRedacteur(r),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.pink),
                          onPressed: () =>
                              _supprimerRedacteurAvecConfirmation(r.id!),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
