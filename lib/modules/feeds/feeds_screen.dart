import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home/cubit/home_cubit.dart';
import 'package:social_app/layout/home/cubit/home_states.dart';
import 'package:social_app/models/post_model/post_model.dart';
import 'package:social_app/modules/feeds/comments/comments_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        if(state is GetPostsLoadingState)
          return Center(child: CircularProgressIndicator(),);
        else
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 10.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Image(
                      image: NetworkImage(
                        'https://img.freepik.com/free-photo/medium-shot-man-wearing-vr-glasses_23-2150394443.jpg?w=740&t=st=1691327209~exp=1691327809~hmac=0a705d2fe348fce2aa453c11061f1ef092c4e5d35f07f1b9dfd560e4a012e94a',
                      ),
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'communicate with friends',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => buildPostItem(context,cubit.posts[index],index),itemCount: cubit.posts.length,),
            ],
          ),
        );
      },
    );
  }

  Widget buildPostItem(context,PostModel model,index)=>          Card(
    color: Theme.of(context).scaffoldBackgroundColor,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10.0,
    margin: EdgeInsetsDirectional.all(8.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                '${model.image}',
                ),),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${model.name}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                            fontSize: 16,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: defaultColor,
                          size: 16.0,
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.more_horiz,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(height: -.9),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              color: Colors.grey[300],
              height: .8,
              width: double.infinity,
            ),
          ),
          Text(
            '${model.text} ',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(height: 1.3, fontSize: 14),
          ),


          // Wrap(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsetsDirectional.only(end: 6.0),
          //       child: Container(
          //         child: MaterialButton(
          //           onPressed: () {},
          //           child: Text(
          //             '#software',
          //             style: Theme.of(context)
          //                 .textTheme
          //                 .caption
          //                 ?.copyWith(color: defaultColor),
          //           ),
          //           padding: EdgeInsets.zero,
          //           minWidth: 1,
          //         ),
          //         height: 25.0,
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsetsDirectional.only(end: 6.0),
          //       child: Container(
          //         child: MaterialButton(
          //           onPressed: () {},
          //           child: Text(
          //             '#Flutter',
          //             style: Theme.of(context)
          //                 .textTheme
          //                 .caption
          //                 ?.copyWith(color: defaultColor),
          //           ),
          //           padding: EdgeInsets.zero,
          //           minWidth: 1,
          //         ),
          //         height: 25.0,
          //       ),
          //     ),
          //   ],
          // ),
          if(model.postImage!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top : 15.0),
            child: Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(
                     '${model.postImage}',   ),
                    fit: BoxFit.fill,
                  )),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Icon(IconBroken.Heart,
                            size: 18.0,
                            color: Colors.red,
                          ),
                          SizedBox(width: 5.0,),
                          Text('${HomeCubit.get(context).likes[index]}',style: Theme.of(context).textTheme.caption,),
                        ],
                      ),
                    ),
                    onTap: (){
                      print(model.text);
                      print(model.postId);
                      print(model.likesNumbers);
                      HomeCubit.get(context).likePost(model.postId!);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(IconBroken.Chart,
                            size: 18.0,
                            color: Colors.amber,
                          ),
                          SizedBox(width: 5.0,),
                          Text('${HomeCubit.get(context).comments[index]} Comment',style: Theme.of(context).textTheme.caption,),
                        ],
                      ),
                    ),
                    onTap: (){

                    },
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              color: Colors.grey[300],
              height: .8,
              width: double.infinity,
            ),
          ),

          Row(
            children: [
              CircleAvatar(
                radius: 18.0,
                backgroundImage: NetworkImage(
                    '${model.image}' ,),),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    print(index);
                    navigateTo(context, CommentsScreen(model: model,));
                  },
                  child: Text(
                    'Write a comment...',
                    style: Theme.of(context).textTheme.caption?.copyWith(height:2 ),
                  ),
                ),
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Icon(IconBroken.Heart,
                          size: 18.0,
                          color: Colors.red,
                        ),
                      ),
                      Text('like',style: Theme.of(context).textTheme.caption,),
                    ],
                  ),
                ),
                onTap: (){
                  HomeCubit.get(context).likePost(model.postId!);
                },
              ),


            ],
          ),
        ],
      ),
    ),
  );

}
