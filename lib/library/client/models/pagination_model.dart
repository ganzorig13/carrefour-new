class PaginationModel {
  int offset = 0;
  final int limit = 20;

  bool _initial = true;
  int _itemCount = 0;
  int _count = 0;

  bool get shouldFetch => _initial ? true : _itemCount < _count;
  bool get isInitial => _initial;

  void setValue({
    required int itemCount,
    required int count,
  }) {
    _initial = false;
    _itemCount = itemCount;
    _count = count;
    offset += 1;
  }

  void reset() {
    _initial = true;
    _itemCount = 0;
    _count = 0;
    offset = 0;
  }
}
