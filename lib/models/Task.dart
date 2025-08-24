class Task {
  String id;
  String title;
  String description;
  bool isCompleted;
  
  // Validation constants
  static const int minTitleLength = 1;
  static const int maxTitleLength = 10;
  static const int minDescriptionLength = 0;
  static const int maxDescriptionLength = 20;
  
  Task({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  }) {
    // Validate during construction
    if (!_isValidTitle(title)) {
      throw ArgumentError('Title must be between $minTitleLength and $maxTitleLength characters');
    }
    if (!_isValidDescription(description)) {
      throw ArgumentError('Description must be between $minDescriptionLength and $maxDescriptionLength characters');
    }
  }
  
  
  // Private validation methods
  bool _isValidTitle(String title) {
    return title.length >= minTitleLength && title.length <= maxTitleLength;
  }
  
  bool _isValidDescription(String description) {
    return description.length >= minDescriptionLength && description.length <= maxDescriptionLength;
  }
  

  // Public validation methods for UI to use
  static String? validateTitle(String? title) {
    if (title == null || title.isEmpty) {
      return 'Title is required';
    }
    if (title.length < minTitleLength) {
      return 'Title must be at least $minTitleLength characters';
    }
    if (title.length > maxTitleLength) {
      return 'Title cannot exceed $maxTitleLength characters';
    }
    return null; // Return null if valid
  }
  
  static String? validateDescription(String? description) {
    if (description == null) return null; // Description can be empty
    
    if (description.length > maxDescriptionLength) {
      return 'Description cannot exceed $maxDescriptionLength characters';
    }
    return null; // Return null if valid
  }
}