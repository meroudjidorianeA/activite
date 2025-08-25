import 'package:flutter/material.dart';

void main() {
  runApp(const MonAppli());
}

class MonAppli extends StatelessWidget {
  const MonAppli({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Magazine',
      debugShowCheckedModeBanner: false,
      home: PageAccueil(),
    );
  }
}

class PageAccueil extends StatelessWidget {
  const PageAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Magazine infos",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Image(image: AssetImage("assets/images/magazine.JPG")),
            PartieTitre(),
            PartieTexte(),
            PartieIcone(),
            PartieRubrique(),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          print("Tu as cliqué dessus");
        },
        child: Text(
          "Click",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}

class PartieTitre extends StatelessWidget {
  const PartieTitre({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bienvenue au Magazine Infos',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
          ),
          Text(
            'Votre magazine numérique, votre source d inspiration',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class PartieTexte extends StatelessWidget {
  const PartieTexte({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "Magazine Infos est bien plus qu'un simple magazine numériqued'information. C'est votre passerelle vers le monde, une source inestimable de connaissances et d'actualité soigneusement sélectionnés pour vous éclairer sur les enjeux mondiaux, la culture, la science et voire les divertissements (les jeux). ",
      ),
    );
  }
}

class PartieIcone extends StatelessWidget {
  const PartieIcone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                const Icon(Icons.phone, color: Colors.pink),
                const SizedBox(height: 5),
                Text('Tel'.toUpperCase(), style: TextStyle(color: Colors.pink)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                const Icon(Icons.phone, color: Colors.pink),
                const SizedBox(height: 5),
                Text(
                  'Mail'.toUpperCase(),
                  style: TextStyle(color: Colors.pink),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                const Icon(Icons.phone, color: Colors.pink),
                const SizedBox(height: 5),
                Text(
                  'Partage'.toUpperCase(),
                  style: TextStyle(color: Colors.pink, letterSpacing: 1.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PartieRubrique extends StatelessWidget {
  const PartieRubrique({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.asset(
                  'assets/images/journal_one.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.asset(
                  'assets/images/journal_two.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
