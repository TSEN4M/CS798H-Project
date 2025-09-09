import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../state/theme_provider.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Map<String, dynamic>> tasks = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? stored = prefs.getString('tasks');
    if (stored != null) {
      final List decoded = json.decode(stored);
      final List<Map<String, dynamic>> filtered =
          decoded
              .where((task) {
                final createdAt = DateTime.parse(task['createdAt']);
                return DateTime.now().difference(createdAt).inHours < 24;
              })
              .map((task) => Map<String, dynamic>.from(task))
              .toList();
      setState(() => tasks = filtered);
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> filtered =
        tasks
            .map(
              (t) => {
                "task": t['task'],
                "createdAt": t['createdAt'],
                "done": t['done'],
              },
            )
            .toList();
    await prefs.setString('tasks', json.encode(filtered));
  }

  void _addTask(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      tasks.add({
        "task": text.trim(),
        "createdAt": DateTime.now().toIso8601String(),
        "done": false,
      });
      _controller.clear();
    });
    _saveTasks();
  }

  void _toggleDone(int index) {
    setState(() {
      tasks[index]['done'] = !tasks[index]['done'];
    });
    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().currentTheme;

    return Scaffold(
      backgroundColor: theme.primary,
      appBar: AppBar(
        title: Text("Your Tasks", style: TextStyle(color: theme.neutral)),
        backgroundColor: theme.secondary,
        iconTheme: IconThemeData(color: theme.neutral),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              style: TextStyle(color: theme.neutral),
              decoration: InputDecoration(
                hintText: "Enter new task...",
                hintStyle: TextStyle(color: theme.neutral.withOpacity(0.6)),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add, color: theme.neutral),
                  onPressed: () => _addTask(_controller.text),
                ),
                filled: true,
                fillColor: theme.secondary.withAlpha(180),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (_, index) {
                  final task = tasks[index];
                  return CheckboxListTile(
                    value: task['done'],
                    onChanged: (_) => _toggleDone(index),
                    title: Text(
                      task['task'],
                      style: TextStyle(
                        color: theme.neutral,
                        decoration:
                            task['done'] ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    activeColor: theme.accent,
                    checkColor: theme.primary,
                    checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    tileColor: theme.secondary.withAlpha(120),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
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
