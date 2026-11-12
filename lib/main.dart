import 'package:flutter/material.dart';

void main() {
  runApp(const HecmDatingApp());
}

class HecmDatingApp extends StatelessWidget {
  const HecmDatingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HECM Rencard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF006B3F), // Vert HECM
          primary: const Color(0xFF006B3F),
          secondary: const Color(0xFF8BC34A),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    DiscoveryPage(),
    ChatListPage(),
    MeetupPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      // IndexedStack conserve l'état de chaque onglet (ex: la carte courante
      // dans "Découvrir") quand on navigue entre les pages.
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Découvrir',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Rencard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// --- MODÈLES ---
class Student {
  final String name;
  final String bio;
  final String department;
  final String imagePath;
  final String level;

  const Student(
    this.name,
    this.bio,
    this.department,
    this.imagePath,
    this.level,
  );
}

// --- PAGES ---

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({super.key});

  @override
  State<DiscoveryPage> createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  static const List<Student> students = [
    Student(
      'Ablavi',
      'Future DG. Je gère mes cours comme je gère mon coeur : avec rigueur ! 🥐',
      'Gestion',
      'https://i.pravatar.cc/300?u=1',
      'Master 1',
    ),
    Student(
      'Kofi',
      'Expert en informatique. Je peux hacker ton coeur ou ton ordi après '
          'l\'amphi. 💻',
      'Informatique',
      'https://i.pravatar.cc/300?u=2',
      'Licence 3',
    ),
    Student(
      'Sena',
      'Recherche partenaire de révision pour ne pas pleurer devant la '
          'microéco. 📚',
      'Économie',
      'https://i.pravatar.cc/300?u=3',
      'Licence 2',
    ),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (currentIndex >= students.length) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              'Plus personne sur le campus pour le moment !',
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: () => setState(() => currentIndex = 0),
              child: const Text('Recommencer le tour'),
            ),
          ],
        ),
      );
    }

    final student = students[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HECM Campus Match',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      student.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.person,
                          size: 100,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black87],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${student.name}, ${student.level}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            student.department,
                            style: const TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            student.bio,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: 'no',
                  backgroundColor: Colors.white,
                  onPressed: () => setState(() => currentIndex++),
                  child: const Icon(Icons.close, color: Colors.red, size: 30),
                ),
                FloatingActionButton(
                  heroTag: 'yes',
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Match avec ${student.name} ! '
                          'Prépare ton Atassi ! 😋',
                        ),
                      ),
                    );
                    setState(() => currentIndex++);
                  },
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mes Causeries'), centerTitle: true),
      body: ListView.separated(
        itemCount: 2,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final name = index == 0 ? 'Ablavi' : 'Sena';
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/150?u=${index + 10}',
              ),
            ),
            title: Text(name),
            subtitle: Text(
              index == 0
                  ? 'On se voit à la cafète après ?'
                  : 'Tu as fini l\'exercice de compta ?',
            ),
            trailing: const Text('14:30'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => ChatDetailPage(name: name),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChatDetailPage extends StatelessWidget {
  final String name;

  const ChatDetailPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildBubble(
                  context,
                  'Salut ! Alors, tu as survécu au cours de ce matin ?',
                  false,
                ),
                _buildBubble(
                  context,
                  'Franchement, j\'ai failli dormir. Mais ton message m\'a '
                  'réveillé ! 😉',
                  true,
                ),
                _buildBubble(
                  context,
                  'Ahah ! On se retrouve pour manger un bout ?',
                  false,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Écris ton message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF006B3F)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBubble(BuildContext context, String text, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe
              ? Theme.of(context).colorScheme.primary
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(15).copyWith(
            bottomRight: isMe
                ? const Radius.circular(0)
                : const Radius.circular(15),
            bottomLeft: !isMe
                ? const Radius.circular(0)
                : const Radius.circular(15),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: isMe ? Colors.white : Colors.black87),
        ),
      ),
    );
  }
}

class Venue {
  final String name;
  final String description;
  final IconData icon;

  const Venue(this.name, this.description, this.icon);
}

class MeetupPage extends StatelessWidget {
  const MeetupPage({super.key});

  static const List<Venue> _venues = [
    Venue(
      'La Cafétéria Centrale',
      'Idéal pour un Atassi ou un croissant.',
      Icons.restaurant,
    ),
    Venue(
      'Devant l\'Amphi A',
      'Pour une causerie rapide entre deux cours.',
      Icons.school,
    ),
    Venue(
      'Sous les Arbres',
      'Le coin calme pour les secrets de campus.',
      Icons.park,
    ),
    Venue(
      'La Bibliothèque',
      'Pour les "révisions" studieuses.',
      Icons.menu_book,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Proposer un Rencard'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Où veux-tu donner rendez-vous ?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _venues.length,
                itemBuilder: (context, index) {
                  final venue = _venues[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Icon(
                        venue.icon,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(venue.name),
                      subtitle: Text(venue.description),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Demande envoyée ! Croise les doigts pour '
                              'qu\'elle accepte ! 🤞',
                            ),
                          ),
                        );
                      },
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

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mon Profil'), centerTitle: true),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/300?u=myprofile',
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Étudiant HECM',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Génie Logiciel - Licence 3',
            style: TextStyle(color: Colors.grey),
          ),
          const Divider(indent: 50, endIndent: 50, height: 40),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Paramètres du compte'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Aide & Support'),
            onTap: () {},
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Version 1.0.0 - Fait avec ❤️ pour HECM',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
