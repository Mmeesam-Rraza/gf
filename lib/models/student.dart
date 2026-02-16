class Student {
  final int? id;
  final int classId;
  final int rollNumber;
  final String? name;
  final String? fatherName;
  final String? contact;
  final String? fatherContact;
  final String? address;
  final String? comments;
  final int behaviorColor;
  final String? imagePath;
  final String createdAt;
  final String updatedAt;

  Student({
    this.id,
    required this.classId,
    required this.rollNumber,
    this.name,
    this.fatherName,
    this.contact,
    this.fatherContact,
    this.address,
    this.comments,
    this.behaviorColor = 0,
    this.imagePath,
    String? createdAt,
    String? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now().toIso8601String(),
        updatedAt = updatedAt ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toJson() => {
        'id': id,
        'classId': classId,
        'rollNumber': rollNumber,
        'name': name,
        'fatherName': fatherName,
        'contact': contact,
        'fatherContact': fatherContact,
        'address': address,
        'comments': comments,
        'behaviorColor': behaviorColor,
        'imagePath': imagePath,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json['id'] as int?,
        classId: json['classId'] as int,
        rollNumber: json['rollNumber'] as int,
        name: json['name'] as String?,
        fatherName: json['fatherName'] as String?,
        contact: json['contact'] as String?,
        fatherContact: json['fatherContact'] as String?,
        address: json['address'] as String?,
        comments: json['comments'] as String?,
        behaviorColor: json['behaviorColor'] as int? ?? 0,
        imagePath: json['imagePath'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
      );

  Student copyWith({
    int? id,
    int? classId,
    int? rollNumber,
    String? name,
    String? fatherName,
    String? contact,
    String? fatherContact,
    String? address,
    String? comments,
    int? behaviorColor,
    String? imagePath,
    String? createdAt,
    String? updatedAt,
  }) {
    return Student(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      rollNumber: rollNumber ?? this.rollNumber,
      name: name ?? this.name,
      fatherName: fatherName ?? this.fatherName,
      contact: contact ?? this.contact,
      fatherContact: fatherContact ?? this.fatherContact,
      address: address ?? this.address,
      comments: comments ?? this.comments,
      behaviorColor: behaviorColor ?? this.behaviorColor,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String getStatusMessage() {
    final colorName = _getColorName(behaviorColor);
    return '''Name: ${name ?? 'N/A'}
Roll: $rollNumber
Status: $colorName
Comment: ${comments ?? 'N/A'}''';
  }

  String getSummary(String className) {
    return getStatusMessage() + '\nClass: $className';
  }

  String _getColorName(int color) {
    switch (color) {
      case 0xFF4CAF50:
        return 'Excellent';
      case 0xFF2196F3:
        return 'Good';
      case 0xFFFFEB3B:
        return 'Average';
      case 0xFFFF9800:
        return 'Needs Improvement';
      case 0xFFF44336:
        return 'Critical';
      default:
        return 'Not Set';
    }
  }
}
