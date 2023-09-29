import 'package:ToGather/category/category.dart';

class DiscoverFilterController {
  final void Function() onChanged;

  DiscoverFilterController({required this.onChanged});

  DateTime _selectedDate = DateTime.now();
  bool _showPosts = true;
  bool _showEvents = true;
  bool _showClubs = true;
  bool _showPlaces = true;
  bool _showUsers = true;
  List<String> _tags = const [];
  Category? _selectedCategory;

  DateTime get selectedDate => _selectedDate;
  bool get showPosts => _showPosts;
  bool get showEvents => _showEvents;
  bool get showClubs => _showClubs;
  bool get showPlaces => _showPlaces;
  bool get showUsers => _showUsers;
  List<String> get tags => _tags;
  Category? get selectedCategory => _selectedCategory;

  void set selectedDate(DateTime value) {
    _selectedDate = value;
    onChanged();
  }

  void set showPosts(bool value) {
    _showPosts = value;
    onChanged();
  }

  void set showEvents(bool value) {
    _showEvents = value;
    onChanged();
  }

  void set showClubs(bool value) {
    _showClubs = value;
    onChanged();
  }

  void set showPlaces(bool value) {
    _showPlaces = value;
    onChanged();
  }

  void set showUsers(bool value) {
    _showUsers = value;
    onChanged();
  }

  void set tags(List<String> value) {
    _tags = value;
    onChanged();
  }

  void set selectedCategory(Category? value) {
    if (_selectedCategory == value) {
      _selectedCategory = null;
    } else
      _selectedCategory = value;
    onChanged();
  }
}
