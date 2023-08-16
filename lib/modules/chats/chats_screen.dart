import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home/cubit/home_cubit.dart';
import 'package:social_app/layout/home/cubit/home_states.dart';
import 'package:social_app/models/user_model/user_model.dart';
import 'package:social_app/modules/chat_details/chat_details_screen.dart';
import 'package:social_app/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (HomeCubit.get(context).users.isNotEmpty) {
          return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildChatItem(context, HomeCubit.get(context).users[index]),
              separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      color: Colors.grey[300],
                      height: .8,
                      width: double.infinity,
                    ),
                  ),
              itemCount: HomeCubit.get(context).users.length);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildChatItem(context, UserModel model) {
    return InkWell(
      onTap: () {
        navigateTo(context, ChatDetailsScreen(userModel: model));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                '${model.image}',
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              '${model.name}',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 16,
                    height: 1.2,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
