
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/layout/home/cubit/home_cubit.dart';
import 'package:social_app/layout/home/cubit/home_states.dart';
import 'package:social_app/models/message_model/message_model.dart';
import 'package:social_app/models/user_model/user_model.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel? userModel;
  TextEditingController message = TextEditingController();
  double x=0;
  ScrollController scrollController=ScrollController();
  bool? firstTime;
  bool checker=false;
  ChatDetailsScreen({
    required UserModel userModel,
  }) {
    this.userModel = userModel;
  }
  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.elasticOut);
    } else {
      Timer(Duration(milliseconds: 400), () => scrollToBottom());
    }
  }
@override
  Widget build(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is GetMessageSuccessState){
          WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());

        }
      },
      builder: (context, state) {
        // message.text=HomeCubit.get(context).messageToBeSent;
        HomeCubit.get(context).getMessages(receiverId: userModel?.uId);
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(
                    '${userModel?.image}',
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  '${userModel?.name}',
                ),
              ],
            ),
            titleSpacing: 0.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (HomeCubit.get(context).messages.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (HomeCubit.get(context)
                                  .messages[index]
                                  .receiverId ==
                              userModel?.uId)
                            return buildMyMessages(
                                HomeCubit.get(context).messages[index]);
                          else
                            return buildMessage(
                                HomeCubit.get(context).messages[index]);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 15.0,
                            ),
                        itemCount: HomeCubit.get(context).messages.length),
                  ),
                if (HomeCubit.get(context).messages.isEmpty)
                  Text(
                    'this is the start of your legendery chat with ${userModel?.name}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                Container(
                  height: 60.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300]!,
                    ),
                    borderRadius: BorderRadius.circular(
                      15.0,
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                            controller: message,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type your message here...'),
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        child: MaterialButton(
                          onPressed: () {
                            HomeCubit.get(context).sendMessage(
                                dateTime: DateFormat('yyyy-MM-dd HH:mm')
                                    .format(DateTime.now()),
                                receiverId: userModel!.uId!,
                                text: message.text);
                            // HomeCubit.get(context).messageToBeSent='';
                            message.text='';
                            firstTime=true;
                            scrollController.jumpTo(scrollController. position.maxScrollExtent);
                            scrollToBottom();

                          },
                          minWidth: 1,
                          child: Icon(
                            IconBroken.Send,
                            size: 20,
                            color: Colors.white,
                          ),
                          color: defaultColor,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildMessage(MessageModel messageModel) => Align(
        alignment: AlignmentDirectional.topStart,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10,
              ),
              child: Text(
                '${messageModel.text}',
              ),
            )),
      );

  Widget buildMyMessages(MessageModel messageModel) => Align(
        alignment: AlignmentDirectional.topEnd,
        child: Container(
            decoration: BoxDecoration(
              color: defaultColor.withOpacity(
                .4,
              ),
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10,
              ),
              child: Text(
                '${messageModel.text}',
              ),
            )),
      );
}
