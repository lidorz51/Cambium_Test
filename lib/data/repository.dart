import 'package:cambium_test/business_logic/services/api_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view/infinite_scroll.dart';
import 'models/comments.dart';

final commentDataProvider = 
      StateNotifierProvider<PaginationNotifier<Comments>, AsyncValue<List<Comments>>>((ref) {
        return PaginationNotifier
        (
          itemsPerBatch: 20,
          fetchNextItems: (
            (item) {
              return ref.read(apiProvider).getComments(item);
            }
          ), 
          )..init();
      },);




