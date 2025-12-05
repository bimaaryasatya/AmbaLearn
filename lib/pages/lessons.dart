import 'package:capstone_layout/pages/exampage.dart';
import 'package:capstone_layout/pages/homepage.dart';
import 'package:flutter/material.dart';

class LessonsPage extends StatefulWidget {
  const LessonsPage({super.key});

  @override
  State<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  bool hasStarted = false; // controls if lesson has started
  final TextEditingController _messageController = TextEditingController();

  String currentLesson = "Ready to start your lesson?";

  // Example lesson list
  final List<String> lessons = [
    "Lesson 1: Introduction",
    "Lesson 2: Concepts",
    "Lesson 3: Practice",
    "Lesson 4: Summary",
  ];
  // Example hint questions for each lesson
  final Map<String, List<String>> hintQuestions = {
    "Lesson 1: Introduction": [
      "Apa tujuan dari materi ini?",
      "Kenapa topik ini penting?",
      "Bisakah jelaskan konsepnya secara sederhana?",
    ],
    "Lesson 2: Concepts": [
      "Apa istilah penting di lesson ini?",
      "Bagaimana konsep ini bekerja?",
      "Apa perbedaan konsep A dan B?",
    ],
    "Lesson 3: Practice": [
      "Bisa beri saya soal latihan?",
      "Bagaimana langkah-langkah penyelesaiannya?",
      "Apa kesalahan umum yang harus dihindari?",
    ],
    "Lesson 4: Summary": [
      "Apa poin penting yang harus diingat?",
      "Bisa rangkum materi ini?",
      "Bagaimana saya menerapkan konsep ini?",
    ],
  };

  @override
  Widget build(BuildContext context) {
    // Receive course name from navigation argument
    final String courseTitle =
        ModalRoute.of(context)?.settings.arguments as String? ?? "Course";

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 37, 37),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 77, 0, 5),
        title: Text(
          courseTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),

      // Sidebar Drawer for Lessons
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 37, 37, 37),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 77, 0, 5)),
              child: Center(
                child: Text(
                  "AmbaLearn Lessons",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Back to main menu
            ListTile(
              leading: const Icon(Icons.arrow_back, color: Colors.white),
              title: const Text(
                "Back to Home",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),

            // Lessons list
            Expanded(
              child: ListView(
                children: [
                  // LESSONS HEADER
                  const Padding(
                    padding: EdgeInsets.only(left: 16, top: 10, bottom: 5),
                    child: Text(
                      "Lessons",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // LESSONS LIST
                  ...lessons.map((lesson) {
                    return ListTile(
                      leading: const Icon(
                        Icons.menu_book_outlined,
                        color: Colors.white,
                      ),
                      title: Text(
                        lesson,
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        setState(() {
                          currentLesson = lesson;
                        });
                        Navigator.pop(context);
                      },
                    );
                  }),

                  // EXAM HEADER
                  const Padding(
                    padding: EdgeInsets.only(left: 16, top: 15, bottom: 5),
                    child: Text(
                      "Exam",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // EXAM MENU
                  ListTile(
                    leading: const Icon(
                      Icons.quiz_outlined,
                      color: Colors.white,
                    ),
                    title: const Text(
                      "Final Exam",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ExamPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentLesson,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // HINT BUBBLE OTOMATIS
                if (hasStarted)
                  Column(
                    children: [
                      const Text(
                        "Contoh pertanyaan:",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 10),

                      ...((hintQuestions[currentLesson] ??
                              ["Tidak ada contoh pertanyaan"]))
                          .map(
                            (q) => Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.13),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.white24),
                              ),
                              child: Text(
                                "💬 $q",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                    ],
                  ),
              ],
            ),
          ),

          // Input section
          Container(
            padding: const EdgeInsets.all(10),
            color: const Color.fromARGB(255, 77, 0, 5),
            child: hasStarted
                ? Row(
                    children: [
                      // TEXTFIELD
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: "Type your answer...",
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

                      // MIC BUTTON
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: () {
                            // TODO: handle mic input
                          },
                          icon: const Icon(
                            Icons.mic,
                            color: Color.fromARGB(255, 135, 0, 5),
                          ),
                        ),
                      ),

                      const SizedBox(width: 5),

                      // SEND BUTTON
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: () {
                            // TODO: handle sending messages
                            _messageController.clear();
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Color.fromARGB(255, 135, 0, 5),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 200, 80, 80),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          hasStarted = true;
                          currentLesson = lessons.first;
                        });
                      },
                      child: const Text(
                        "Start",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
