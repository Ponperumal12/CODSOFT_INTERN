import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  const 
  TodoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Login Screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate login process
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });
if(!mounted)return;
      // Navigate to TodoList screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => TodoListScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 87, 52, 212),
              Color.fromARGB(255, 68, 109, 221),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Section
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(230),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(25),
                          spreadRadius: 5,
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.check_circle_outline,
                      size: 80,
                      color: Color(0xFF667eea),
                    ),
                  ),
                  SizedBox(height: 40),

                  // Welcome Text
                  Text(
                    'TaskNest',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Sign in to manage your tasks',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(204),
                    ),
                  ),
                  SizedBox(height: 40),

                  // Login Form
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(242),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(26),
                          spreadRadius: 5,
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email TextField
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter your email',
                              prefixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFF667eea),
                                  width: 2,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Password TextField
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFF667eea),
                                  width: 2,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 12),

                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Forgot password clicked')),
                                );
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Color(0xFF667eea),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF667eea),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 3,
                              ),
                              child: _isLoading
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Text('Signing In...'),
                                      ],
                                    )
                                  : Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Task Model
class Task {
  int id;
  String text;
  bool completed;
  String priority;
  String category;
  DateTime createdAt;

  Task({
    required this.id,
    required this.text,
    this.completed = false,
    this.priority = 'medium',
    this.category = 'personal',
    required this.createdAt,
  });
}

// Todo List Screen
class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});
  @override
  TodoListScreenState createState() => TodoListScreenState();
}

class TodoListScreenState extends State<TodoListScreen> {
  List<Task> tasks = [
    Task(
      id: 1,
      text: "Welcome to your Todo App!",
      priority: 'medium',
      category: 'personal',
      createdAt: DateTime.now(),
    ),
    Task(
      id: 2,
      text: "Try adding a new task",
      priority: 'high',
      category: 'work',
      createdAt: DateTime.now(),
    ),
  ];

  String filter = 'all';
  bool showAddForm = false;

  // Add Task Form Controllers
  final _taskController = TextEditingController();
  String newTaskPriority = 'medium';
  String newTaskCategory = 'personal';

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void addTask() {
    if (_taskController.text.trim().isNotEmpty) {
      setState(() {
        tasks.insert(
          0,
          Task(
            id: DateTime.now().millisecondsSinceEpoch,
            text: _taskController.text.trim(),
            priority: newTaskPriority,
            category: newTaskCategory,
            createdAt: DateTime.now(),
          ),
        );
        _taskController.clear();
        showAddForm = false;
        newTaskPriority = 'medium';
        newTaskCategory = 'personal';
      });
    }
  }

  void toggleTask(int id) {
    setState(() {
      int index = tasks.indexWhere((task) => task.id == id);
      if (index != -1) {
        tasks[index].completed = !tasks[index].completed;
      }
    });
  }

  void deleteTask(int id) {
    setState(() {
      tasks.removeWhere((task) => task.id == id);
    });
  }

  List<Task> getFilteredTasks() {
    switch (filter) {
      case 'completed':
        return tasks.where((task) => task.completed).toList();
      case 'pending':
        return tasks.where((task) => !task.completed).toList();
      default:
        return tasks;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String getCategoryIcon(String category) {
    switch (category) {
      case 'work':
        return '💼';
      case 'personal':
        return '👤';
      case 'shopping':
        return '🛒';
      case 'health':
        return '💊';
      default:
        return '📝';
    }
  }

  void _logout() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Task> filteredTasks = getFilteredTasks();
    int completedCount = tasks.where((task) => task.completed).length;
    int totalCount = tasks.length;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Top bar with logout
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Tasks',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: _logout,
                          icon: Icon(Icons.logout, color: Colors.white),
                          tooltip: 'Logout',
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    // Progress info
                    Text(
                      '$completedCount of $totalCount completed',
                      style: TextStyle(
                        color: Colors.white.withAlpha(204),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 15),

                    // Progress Bar
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(77),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: totalCount > 0 ? completedCount / totalCount : 0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.green, Colors.lightGreen],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Filter Tabs
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(51),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: ['all', 'pending', 'completed'].map((filterType) {
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => filter = filterType),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: filter == filterType
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text(
                                  filterType.substring(0, 1).toUpperCase() +
                                      filterType.substring(1),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: filter == filterType
                                        ? Color(0xFF667eea)
                                        : Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),

              // Task List
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: filteredTasks.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.task_alt,
                                size: 64,
                                color: Colors.white.withAlpha(153),
                              ),
                              SizedBox(height: 16),
                              Text(
                                filter == 'completed'
                                    ? 'No completed tasks'
                                    : filter == 'pending'
                                        ? 'All caught up!'
                                        : 'No tasks yet',
                                style: TextStyle(
                                  color: Colors.white.withAlpha(204),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredTasks.length,
                          itemBuilder: (context, index) {
                            Task task = filteredTasks[index];
                            return Container(
                              margin: EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(243),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(25),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                leading: GestureDetector(
                                  onTap: () => toggleTask(task.id),
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: task.completed
                                            ? Colors.green
                                            : Colors.grey,
                                        width: 2,
                                      ),
                                      color: task.completed
                                          ? Colors.green
                                          : Colors.transparent,
                                    ),
                                    child: task.completed
                                        ? Icon(
                                            Icons.check,
                                            size: 16,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                ),
                                title: Row(
                                  children: [
                                    Text(
                                      getCategoryIcon(task.category),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        task.text,
                                        style: TextStyle(
                                          decoration: task.completed
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                          color: task.completed
                                              ? Colors.grey[600]
                                              : Colors.black87,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: getPriorityColor(task.priority),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () => deleteTask(task.id),
                                      child: Icon(
                                        Icons.delete_outline,
                                        color: Colors.red[400],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => showAddForm = true),
        backgroundColor: Colors.white,
        child: Icon(Icons.add, color: Color(0xFF667eea)),
      ),

      // Add Task Bottom Sheet
      bottomSheet: showAddForm
          ? Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Add New Task',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      hintText: 'What needs to be done?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFF667eea)),
                      ),
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: newTaskCategory,
                          decoration: InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(value: 'personal', child: Text('👤 Personal')),
                            DropdownMenuItem(value: 'work', child: Text('💼 Work')),
                            DropdownMenuItem(value: 'shopping', child: Text('🛒 Shopping')),
                            DropdownMenuItem(value: 'health', child: Text('💊 Health')),
                          ],
                          onChanged: (value) => setState(() => newTaskCategory = value!),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: newTaskPriority,
                          decoration: InputDecoration(
                            labelText: 'Priority',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(value: 'low', child: Text('🟢 Low')),
                            DropdownMenuItem(value: 'medium', child: Text('🟡 Medium')),
                            DropdownMenuItem(value: 'high', child: Text('🔴 High')),
                          ],
                          onChanged: (value) => setState(() => newTaskPriority = value!),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => setState(() => showAddForm = false),
                          child: Text('Cancel'),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: addTask,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF667eea),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text('Add Task'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )
          : null,
    );
  }
}