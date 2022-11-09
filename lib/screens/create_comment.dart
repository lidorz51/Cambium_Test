

import 'package:cambium_test/business_logic/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/comments.dart';
import '../interface/shared/ui_helpers.dart';
import '../interface/widgets/button_widget.dart';
import '../interface/widgets/text_input_field_widget.dart';
import '../interface/widgets/text_widget.dart';

class CreateCommentView extends ConsumerWidget {
  CreateCommentView({Key? key}) : super(key: key);

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = FocusNode();
    return Scaffold(
        backgroundColor: Colors.amber[200],
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const TextWiget.headline2('Create a comment'),
          centerTitle: true,
        ),
        body:GestureDetector(
                onTap: () => focusNode.unfocus(),
                child: Padding(
                  padding: basePadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      verticalSpaceLarge,
                      
                      TextInputFieldWidget(
                        placeHolder: 'Name',
                        controller: _nameController,
                      ),

                      verticalSpaceMedium,
                      
                      TextInputFieldWidget(
                        placeHolder: 'Email',
                        controller: _emailController,
                      ),
                      
                      verticalSpaceLarge,
                      
                      TextInputFieldWidget(
                        placeHolder: 'Comment text',
                        controller: _commentController,
                        isContent: true,
                      ),
                      
                      verticalSpaceLarge, 
                                           
                      GestureDetector(
                        onTap: () async {
                          if (_nameController.text.isNotEmpty &&
                              _emailController.text.isNotEmpty &&
                              _commentController.text.isNotEmpty) {
                          
                              if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_emailController.text)){
                               
                              
                              var tempComment = Comments(
                                id: 0,
                                postId: 0,
                                name: _nameController.text,
                                email: _emailController.text,
                                body: _commentController.text,
                              );


                              ref.read(apiProvider).postComment(tempComment);

                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Success"),
                              ));
                            
                              _nameController.clear();
                              _emailController.clear();
                              _commentController.clear();
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Enter a valid email address"),
                              ));
                            }
                          }
                        },
                        child:
                            const ButtonWidget(label: 'Publish this comment'),
                      ),
                    ],
                  ),
                ),
              ),
      );
  }
}