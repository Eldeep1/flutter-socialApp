import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/layout/home/cubit/home_cubit.dart';
import 'package:social_app/layout/home/cubit/home_states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';


class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        TextEditingController postController= TextEditingController();
        FocusNode postNode=FocusNode();
       return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(IconBroken.Arrow___Left_Square),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Add Post',
            ),
            titleSpacing: 5.0,
            actions: [
              TextButton(onPressed: (){
                // if(cubit.postImage==null){
                //   cubit.createPost(text: postController.text, dateTime: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),);
                // }
                if(cubit.postImage==null){
                  cubit.createPost(text: postController.text, dateTime:DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()));
                }
                if(cubit.postImage!=null){
                  cubit.uploadPostImage(text: postController.text, dateTime: DateTime.now().toString());
                }

              }, child: Text('POST',),),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is CreatePostLoadingState)
                LinearProgressIndicator(),
                if(state is CreatePostLoadingState)
                  SizedBox(height: 10.0 ,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/close-up-snake-eye_23-2150536867.jpg?t=st=1691327102~exp=1691330702~hmac=d5a691b5bdb379cf7111acb2a79135ca410dcb1c1ef39badcbd207783d97aea5&w=360'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        'Ali Eldeep',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(
                          fontSize: 16,
                          // height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    focusNode: postNode ,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(postNode);
                    },
                    // onFieldSubmitted: (value) {
                    //   FocusScope.of(context).requestFocus(postNode);
                    //   print('helpppppppppppppp');
                    // },
                    maxLines: null,
                    controller: postController,
                    decoration: InputDecoration(
                      hintText: 'What is on your mind...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if(cubit.postImage!=null)
                   Expanded(
                     child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0,),
                              ),
                              image: DecorationImage(
                                // image: FileImage(image!),
                                image:FileImage(cubit.postImage!),
                                fit: BoxFit.fill,
                              )),
                        ),
                        IconButton(
                          onPressed: () {
                            cubit.deletePostImage();
                          },
                          icon: CircleAvatar(
                              radius: 20.0,
                              child: Icon(
                                Icons.close,
                              )),
                        ),
                      ],
                  ),
                   ),
SizedBox(height: 9.0,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        cubit.pickPostImage();
                      }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(IconBroken.Image),
                          SizedBox(width: 5.0,),
                          Text('add photo',),
                        ],
    )),
                    ),
                    Expanded(child: TextButton(onPressed: (){}, child: Text('# tags',),)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
