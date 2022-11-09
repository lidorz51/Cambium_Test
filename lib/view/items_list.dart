import 'package:cambium_test/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../interface/shared/ui_helpers.dart';
import '../interface/widgets/text_widget.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context,ref,child){
            final state = ref.watch(commentDataProvider);
            return state.when(
              data: (data){
                return data.isEmpty
                  ?SliverToBoxAdapter(
                    child: Column(
                      children: const [
                        Text(
                        "Something Went Worng!",
                        style: TextStyle(
                          color: Colors.black
                        ),
                      )
                      ],
                    ),
                  )
                  :SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index){
                          
                          return Card(
                        margin: basePadding,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: kcontentPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWiget.headline3(
                                data[index].name
                              ),
                              verticalSpaceTiny,
                              TextWiget.oneline(
                                'Email: ${data[index].email}',
                              ),
                              verticalSpaceMedium,
                              TextWiget.body(
                                data[index].body,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                      childCount: data.length,
                ),
              );
              }, 
              loading: () => const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, stackTrace) => SliverToBoxAdapter(
                child: Center(
                  child: Column(
                    children: const [
                      Icon(Icons.info),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Something Went Worng!",
                        style: TextStyle(
                          color: Colors.black
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
  }
}
