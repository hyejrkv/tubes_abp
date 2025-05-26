import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Mock task model
class Task {
  final String title;
  final String description;
  final DateTime dateTime;
  final bool isCompleted;
  final String priority;

  Task({
    required this.title,
    required this.description,
    required this.dateTime,
    required this.isCompleted,
    required this.priority,
  });
}

class CalendarTab extends StatefulWidget {
  final int userId;

  CalendarTab({required this.userId}); // Constructor no longer const

  @override
  _CalendarTabState createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  DateTime _selectedDate = DateTime.now();
  DateTime _currentMonth = DateTime.now();
  List<Task> _selectedDateTasks = [];
  bool _isLoading = false;
  Set<int> _daysWithTasks = {}; // Store days that have tasks

  @override
  void initState() {
    super.initState();
    _loadTasksForMonth(); // Load tasks for the entire month to check for task dates
  }

  // Mock function to get tasks by date
  List<Task> _getTasksByDate(DateTime date) {
    // Sample mock tasks (adjust as needed)
    return [
      Task(
        title: 'Sample Task 1',
        description: 'This is a description of Task 1',
        dateTime: DateTime(date.year, date.month, date.day, 10, 30),
        isCompleted: false,
        priority: 'high',
      ),
      Task(
        title: 'Sample Task 2',
        description: 'This is a description of Task 2',
        dateTime: DateTime(date.year, date.month, date.day, 14, 45),
        isCompleted: true,
        priority: 'low',
      ),
    ];
  }

  // Mock function to get tasks for the month
  void _loadTasksForMonth() {
    Set<int> daysWithTasks = {};

    // Simulating tasks on specific days for the current month
    final tasks = [
      Task(
        title: 'Sample Task 1',
        description: 'This is a description of Task 1',
        dateTime: DateTime(_currentMonth.year, _currentMonth.month, 5, 10, 30),
        isCompleted: false,
        priority: 'high',
      ),
      Task(
        title: 'Sample Task 2',
        description: 'This is a description of Task 2',
        dateTime: DateTime(_currentMonth.year, _currentMonth.month, 15, 14, 45),
        isCompleted: true,
        priority: 'low',
      ),
      Task(
        title: 'Sample Task 3',
        description: 'This is a description of Task 3',
        dateTime: DateTime(_currentMonth.year, _currentMonth.month, 20, 9, 00),
        isCompleted: false,
        priority: 'medium',
      ),
    ];

    for (var task in tasks) {
      final day = task.dateTime.day;
      daysWithTasks.add(day);
    }

    setState(() {
      _daysWithTasks = daysWithTasks;
    });
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
    _loadTasksForMonth();
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
    _loadTasksForMonth();
  }

  Widget _buildCalendar() {
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    final firstWeekday = firstDayOfMonth.weekday % 7; // Convert to 0-6 where 0 is Sunday

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _previousMonth,
                icon: Icon(Icons.chevron_left, size: 28),
                color: Color(0xFF5C6BC0),
              ),
              Text(
                DateFormat('MMMM yyyy').format(_currentMonth),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5C6BC0),
                ),
              ),
              IconButton(
                onPressed: _nextMonth,
                icon: Icon(Icons.chevron_right, size: 28),
                color: Color(0xFF5C6BC0),
              ),
            ],
          ),
          SizedBox(height: 15),

          // Days of week header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                .map((day) => Container(
              width: 35,
              child: Text(
                day,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ))
                .toList(),
          ),
          SizedBox(height: 10),

          // Calendar grid
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: 42, // 6 weeks * 7 days
            itemBuilder: (context, index) {
              final dayOffset = index - firstWeekday;

              if (dayOffset < 0 || dayOffset >= daysInMonth) {
                // Empty cells for days outside current month
                return Container();
              }

              final day = dayOffset + 1;
              final date = DateTime(_currentMonth.year, _currentMonth.month, day);
              final now = DateTime.now();

              final isSelected = _selectedDate.day == day &&
                  _selectedDate.month == _currentMonth.month &&
                  _selectedDate.year == _currentMonth.year;
              final isToday = now.day == day &&
                  now.month == _currentMonth.month &&
                  now.year == _currentMonth.year;
              final hasTask = _daysWithTasks.contains(day);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = date;
                  });
                  setState(() {
                    _selectedDateTasks = _getTasksByDate(date); // Use the mock method here
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color(0xFF5C6BC0)
                        : isToday
                        ? Colors.pink.shade100 // Highlight today with light pink
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: isToday && !isSelected
                        ? Border.all(color: Color(0xFF5C6BC0), width: 2)
                        : null,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: Text(
                          day.toString(),
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : isToday
                                ? Color(0xFF5C6BC0)
                                : Colors.black87,
                            fontWeight: isSelected || isToday
                                ? FontWeight.bold
                                : FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      if (hasTask)
                        Positioned(
                          bottom: 2,
                          child: Icon(
                            Icons.circle,
                            color: Color(0xFF5C6BC0),
                            size: 8,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Good Morning, ABC',
              style: TextStyle(
                color: Color(0xFF5C6BC0),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              Icons.notifications_outlined,
              color: Color(0xFF5C6BC0),
              size: 24,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          _buildCalendar(),
          SizedBox(height: 20),
          Expanded(
            child: _selectedDateTasks.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No tasks for ${DateFormat('MMMM dd').format(_selectedDate)}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
                : Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: _selectedDateTasks.length,
                itemBuilder: (context, index) {
                  final task = _selectedDateTasks[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: task.isCompleted
                                  ? Colors.green
                                  : Color(0xFF5C6BC0),
                              width: 2,
                            ),
                            color: task.isCompleted
                                ? Colors.green
                                : Colors.transparent,
                          ),
                          child: task.isCompleted
                              ? Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          )
                              : null,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              if (task.description.isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Text(
                                    task.description,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: task.priority == 'high'
                                    ? Colors.red[400]
                                    : task.priority == 'medium'
                                    ? Colors.orange[400]
                                    : Colors.green[400],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                task.priority.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              DateFormat('HH:mm').format(task.dateTime),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
