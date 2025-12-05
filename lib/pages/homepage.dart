import 'package:capstone_layout/pages/user_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final username = auth.user?.username ?? "Guest";

    final List<String> chatHistory = [
      "Math Basics",
      "Physics Notes",
      "AI Discussion",
      "Flutter Help",
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF252525),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4D0005),
        title: const Text(
          "AmbaLearn",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),

      // ------------------------------
      // DRAWER
      // ------------------------------
      drawer: Drawer(
        backgroundColor: const Color(0xFF252525),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF4D0005)),
              child: Center(
                child: Text(
                  "AmbaLearn Menu",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // New Chat
            ListTile(
              leading: const Icon(Icons.add, color: Colors.white),
              title: const Text(
                "New Chat",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // TODO: implement new chat
              },
            ),

            // Courses
            ListTile(
              leading: const Icon(Icons.school, color: Colors.white),
              title: const Text(
                "Courses",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/courses');
              },
            ),

            const Padding(
              padding: EdgeInsets.only(left: 16, top: 10, bottom: 5),
              child: Text(
                "Chats",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Chat history list
            Expanded(
              child: ListView.builder(
                itemCount: chatHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.white,
                    ),
                    title: Text(
                      chatHistory[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // TODO: open chat
                    },
                  );
                },
              ),
            ),

            const Divider(color: Colors.white24),

            // Profile / Logout
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4D0005),
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const UserSettingPage()),
                  );
                },
                icon: const Icon(Icons.person),
                label: const Text(
                  "Profile",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),

      // ------------------------------
      // BODY
      // ------------------------------
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "Hello, $username!\nMau belajar apa hari ini?",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Input Field + Send Button
          Container(
            padding: const EdgeInsets.all(10),
            color: const Color(0xFF4D0005),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Tulis disini",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {
                      // TODO: Mic input
                    },
                    icon: const Icon(Icons.mic, color: Color(0xFF870005)),
                  ),
                ),
                const SizedBox(width: 5),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {
                      // TODO: send message
                    },
                    icon: const Icon(Icons.send, color: Color(0xFF870005)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
