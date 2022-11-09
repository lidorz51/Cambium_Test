import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginationNotifier<T> extends StateNotifier<AsyncValue<List<T>>> {
  PaginationNotifier({
    required this.fetchNextItems,
    required this.itemsPerBatch,
  }) : super(const AsyncValue.loading());
  
  final Future<List<T>> Function(int item) fetchNextItems;
  final int itemsPerBatch;

  final List<T> _items = [];
  
  void init() {
    if (_items.isEmpty) {
      fetchFirstBatch();
    }
  }

  void updateData(List<T> result) {
    if (result.isEmpty) {
      state = AsyncValue.data(_items);
    } else {
      state = AsyncValue.data(_items..addAll(result));
    }
  }

  Future<void> fetchFirstBatch() async {
    try {
      state = const AsyncValue.loading();

      final List<T> result = _items.isEmpty
           ? await fetchNextItems(0)
          : await fetchNextItems(_items.length);
       updateData(result);
    } catch (e, stk) {
      state = AsyncValue.error(e, stk);
    }
  }

  Future<void> fetchNextBatch() async {

    state = AsyncValue.data(_items);
    try {
      await Future.delayed(const Duration(seconds: 2));
      final result = await fetchNextItems(_items.length);
      updateData(result);
    } catch (e, stk) {
      state = AsyncValue.error(e,stk);
    }
  }
}
