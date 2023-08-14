import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home/cubit/home_cubit.dart';
import 'package:social_app/layout/home/cubit/home_states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TextEditingController nameController = TextEditingController();
        TextEditingController bioController = TextEditingController();
        TextEditingController phoneController = TextEditingController();
        HomeCubit cubit = HomeCubit.get(context);
        nameController.text = cubit.model!.name!;
        bioController.text = cubit.model!.bio!;
        phoneController.text = cubit.model!.phone!;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(IconBroken.Arrow___Left_Square),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Edit Profile',
            ),
            titleSpacing: 5.0,
            actions: [
              MaterialButton(
                onPressed: () {
                  cubit.updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                },
                child: Text(
                  'UPDATE',
                  style: TextStyle(
                    color: defaultColor,
                  ),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is HomeUpdateUserLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 250,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 200.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                      // image: FileImage(image!),
                                      image: cubit.coverImage == null
                                          ? NetworkImage(
                                              '${cubit.model?.coverImage}',
                                            ) as ImageProvider
                                          : FileImage(cubit.coverImage!),
                                      fit: BoxFit.fill,
                                    )),
                              ),
                              IconButton(
                                onPressed: () {
                                  // if(image!=null)
                                  // Image.file(image);
                                  cubit.pickCoverImage().then((value) {});

                                  // pickImage().then((value) {
                                  //   cubit.update();
                                  //   print(value);
                                  // }).catchError((error){
                                  //   print('the error we got is : $error');
                                  // });
                                },
                                icon: CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(
                                      IconBroken.Camera,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 65.0,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 60.0,
                                backgroundImage: cubit.profileImage == null
                                    ? NetworkImage('${cubit.model?.image}')
                                        as ImageProvider
                                    : FileImage(cubit.profileImage!),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.pickProfileImage();
                                },
                                icon: CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(
                                      IconBroken.Camera,
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if (cubit.coverImage != null || cubit.profileImage != null)
                    Row(
                      children: [
                        if (cubit.profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  text: 'UPLOAD PROFILE',
                                  buttonColor: Colors.blue,
                                  function: () {
                                    cubit.uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                ),
                                if (state is HomeUpdateUserLoadingState)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is HomeUpdateUserLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (cubit.coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  text: 'UPLOAD COVER',
                                  buttonColor: Colors.blue,
                                  function: () {
                                    cubit.uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                ),
                                if (state is HomeUpdateUserLoadingState)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is HomeUpdateUserLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (cubit.coverImage != null || cubit.profileImage != null)
                    SizedBox(
                      height: 20,
                    ),
                  defaultFormField(
                    context: context,
                    controller: nameController,
                    prefixIcon: IconBroken.User,
                    labelText: 'Name',
                    validation: true,
                    alertText: 'name must not be empty',
                    keyBoardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    context: context,
                    keyBoardType: TextInputType.text,
                    controller: bioController,
                    prefixIcon: IconBroken.Info_Square,
                    labelText: 'Bio',
                    validation: true,
                    alertText: 'Bio must not be empty',
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    context: context,
                    keyBoardType: TextInputType.phone,
                    controller: phoneController,
                    prefixIcon: IconBroken.Call,
                    labelText: 'Phone',
                    validation: true,
                    alertText: 'Phone must not be empty',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
