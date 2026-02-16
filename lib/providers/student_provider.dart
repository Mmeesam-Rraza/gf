import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/student.dart';
import '../models/class_model.dart';

class StudentProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper.instance;
  
  List<ClassModel> _classes = [];
  List<Student> _currentClassStudents = [];
  Student? _currentStudent;
  int? _currentClassId;
  int _selectedColorFilter = -1;
  bool _isLoading = false;
  String _searchQuery = '';

  List<ClassModel> get classes => _classes;
  List<Student> get currentClassStudents => _filteredStudents;
  Student? get currentStudent => _currentStudent;
  int? get currentClassId => _currentClassId;
  int get selectedColorFilter => _selectedColorFilter;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  List<Student> get _filteredStudents {
    List<Student> filtered = _currentClassStudents;
    
    if (_selectedColorFilter >= 0) {
      filtered = filtered.where((s) => s.behaviorColor == _selectedColorFilter).toList();
    }
    
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((s) =>
        (s.name?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
        s.rollNumber.toString().contains(_searchQuery) ||
        (s.fatherName?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false)
      ).toList();
    }
    
    return filtered;
  }

  Future<void> loadClasses() async {
    _isLoading = true;
    notifyListeners();
    _classes = await _db.getAllClasses();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadStudentsByClass(int classId) async {
    _isLoading = true;
    _currentClassId = classId;
    notifyListeners();
    _currentClassStudents = await _db.getStudentsByClass(classId);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadStudent(int studentId) async {
    _isLoading = true;
    notifyListeners();
    _currentStudent = await _db.getStudentById(studentId);
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> saveStudent(Student student) async {
    try {
      _isLoading = true;
      notifyListeners();
      if (student.id != null) {
        await _db.updateStudent(student);
      } else {
        await _db.insertStudent(student);
      }
      if (_currentClassId != null) {
        await loadStudentsByClass(_currentClassId!);
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Other methods remain the same...
  void clearCurrentStudent() {
    _currentStudent = null;
    notifyListeners();
  }
}