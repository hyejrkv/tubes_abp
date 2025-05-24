import 'package:flutter/material.dart';

class AddTaskPopup extends StatefulWidget {
  const AddTaskPopup({super.key});

  @override
  State<AddTaskPopup> createState() => _AddTaskPopupState();
}

class _AddTaskPopupState extends State<AddTaskPopup> {
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  String _selectedPriority = 'High';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("what task do you want to add?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF373F9D))),
              const SizedBox(height: 20),
              const Text("Task name"),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              const Text("due date"),
              TextField(
                controller: _dateController,
                readOnly: true,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) {
                    _dateController.text =
                    "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                  }
                },
              ),
              const SizedBox(height: 15),
              const Text("priority"),
              Row(
                children: [
                  ChoiceChip(
                    label: const Text("High"),
                    selected: _selectedPriority == 'High',
                    selectedColor: Colors.red,
                    labelStyle: const TextStyle(color: Colors.white),
                    onSelected: (val) =>
                        setState(() => _selectedPriority = 'High'),
                  ),
                  const SizedBox(width: 10),
                  ChoiceChip(
                    label: const Text("Low"),
                    selected: _selectedPriority == 'Low',
                    selectedColor: Colors.green,
                    labelStyle: const TextStyle(color: Colors.white),
                    onSelected: (val) =>
                        setState(() => _selectedPriority = 'Low'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF373F9D),
                    ),
                    onPressed: () {
                      // TODO: Simpan task ke list / database
                      Navigator.pop(context);
                    },
                    child: const Text("add", style: TextStyle(color: Colors.white)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
