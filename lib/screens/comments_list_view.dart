import 'package:cambium_test/interface/widgets/text_widget.dart';
import 'package:cambium_test/screens/create_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cambium_test/data/repository.dart';


import '../view/items_list.dart';


class CommentsList extends ConsumerStatefulWidget {
  const CommentsList({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _CommentsListState createState() => _CommentsListState();
}



class _CommentsListState extends ConsumerState<CommentsList> {

  final ScrollController scrollController = ScrollController();
  
  @override
  Widget build(BuildContext context) {

    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta =  MediaQuery.of(context).size.width*0.20;
      if(maxScroll - currentScroll <= delta){
         ref.read(commentDataProvider.notifier).fetchNextBatch();
      }
    },);

    return Scaffold(
      backgroundColor: Colors.amber[200],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
           Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateCommentView()),
        );
        },
        icon: const Icon(Icons.comment),
        label: const TextWiget.headline3(
                "Comment",
              ),
      ), 
      appBar: AppBar(
        title: const TextWiget.headline2("Cambuim Test"),
        centerTitle: true,
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers:const [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          ItemsList(),
        ],
      ),
    );
  }
}


