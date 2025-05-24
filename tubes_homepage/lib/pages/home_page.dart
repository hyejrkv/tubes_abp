import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/task_card.dart';
import '../widgets/bottom_nav_bar.dart';
import '../models/task_model.dart';
import '../widgets/add_task_popup.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    if (hour < 20) return "Good Evening";
    return "Good Night";
  }

  @override
  Widget build(BuildContext context) {
    List<TaskModel> tasks = [
      TaskModel(title: "Proposal ABP", time: "9:00 PM", priority: "High"),
      TaskModel(title: "Tugas 6 - CSS", time: "9:00 PM", priority: "High"),
      TaskModel(title: "Tugas 6 - Machine Learning", time: "11:00 PM", priority: "Low"),
    ];

    String formattedDate = DateFormat('d MMMM, EEE').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${getGreeting()}, ABC",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 4)],
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'search task...',
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Today, $formattedDate",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ...tasks.map((task) => TaskCard(task: task)).toList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddTaskPopup(),
          );
        },
        backgroundColor: const Color(0xFF373F9D),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
