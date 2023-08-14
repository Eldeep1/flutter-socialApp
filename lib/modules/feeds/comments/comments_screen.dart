import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/layout/home/cubit/home_cubit.dart';
import 'package:social_app/layout/home/cubit/home_states.dart';
import 'package:social_app/models/comments_model/comments_model.dart';
import 'package:social_app/models/post_model/post_model.dart';
import 'package:social_app/models/user_model/user_model.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class CommentsScreen extends StatelessWidget {
  PostModel? model;

  CommentsScreen({super.key, required PostModel model}) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        List<CommentsModel> commentModel = [];
        TextEditingController commentController = TextEditingController();
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(IconBroken.Arrow___Left_Square),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Comments',
            ),
            titleSpacing: 5.0,
            // actions: [
            //   TextButton(onPressed: (){
            //     // if(cubit.postImage==null){
            //     //   cubit.createPost(text: postController.text, dateTime: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),);
            //     // }
            //     if(cubit.postImage==null){
            //       cubit.createPost(text: commentController.text, dateTime:DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()));
            //     }
            //     if(cubit.postImage!=null){
            //       cubit.uploadPostImage(text: commentController.text, dateTime: DateTime.now().toString());
            //     }
            //
            //   }, child: Text('POST',),),
            // ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // if (cubit.commentsModel.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: model?.commentsModel.length,
                    itemBuilder: (context, index) =>
                        CommentsLayout(model!.commentsModel[0]),
                    scrollDirection: Axis.vertical,
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Ali Eldeep',
                        ),
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                            '${cubit.model!.image}',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 7.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 158,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: commentController,
                                style: TextStyle(),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                print('tapped');
                                CommentsModel commentModel = CommentsModel(
                                  text: commentController.text,
                                  dateTime: DateFormat('yyyy-MM-dd HH:mm')
                                      .format(DateTime.now()),
                                  image: cubit.model?.image,
                                  name: cubit.model?.name,
                                );
                                print(cubit.model?.name);

                                cubit.addComment(commentModel,model!.postId!);
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueGrey),
                                ),
                                width: 97.0,
                                child: Center(
                                  child: Text(
                                    'Comment',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget CommentsLayout(CommentsModel model) => Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              Text(
                '${model.name}',
              ),
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
              ),
            ],
          ),
          SizedBox(
            width: 7.0,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                    child: Text(
                      '${model.text}',
                      maxLines: null,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '${model.dateTime}',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
// Row(
// children: [
// Column(
// children: [
// Text('Ali Eldeep',),
//
// CircleAvatar(
// radius: 30.0,
// backgroundImage: NetworkImage(
// '${model?.image}',
// ),
// ),
// ],
// ),
// SizedBox(
// width: 7.0,
// ),
// Expanded(
// child: Center(
// child: Container(
// decoration: BoxDecoration(
// border: Border.all(color: Colors.blueGrey),
// borderRadius: BorderRadius.circular(
// 10,
// ),
// ),
// child: Column(
// // alignment: AlignmentDirectional.bottomEnd,
// crossAxisAlignment: CrossAxisAlignment.end,
// children: [
// Padding(
// padding: const EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
// child: Container(
// child: Text(
// 'I am really tired of that project , and wish I can finsih the course soosdfsdfdsfsdfsssdkfjsifjifmdsjfidsjfin',
// maxLines: null,
//
// ),
// ),
// ),
// Padding(
// padding: const EdgeInsets.symmetric( horizontal: 8.0),
// child: Text('12 june 2023',),
// ),
// ],
// ),
// ),
// ),
// ),
// ],
// ),
//
// SizedBox(height: 19,),
