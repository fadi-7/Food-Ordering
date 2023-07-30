import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_orders_proj/ui/shared/custom_widgets/custom_text_field.dart';
import 'package:food_orders_proj/ui/shared/utils.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_text.dart';
import '../login_view/login_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  final ImagePicker picker = ImagePicker();
  FileModel? selectedFile;
  bool showOptions = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.orangeMainColor));
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
            child: ListView(children: [
              CustomButton(
                  text: 'Send email',
                  onPressed: () {
                    String? encodeQueryParameters(Map<String, String> params) {
                      return params.entries
                          .map((MapEntry<String, String> e) =>
                              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                          .join('&');
                    }

// ···
                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'smith@example.com',
                      query: encodeQueryParameters(<String, String>{
                        'subject': 'Example Subject & Symbols are allowed!',
                      }),
                    );

                    launchUrl(emailLaunchUri);
                  }),
              Padding(
                padding: EdgeInsets.only(top: size.width * 0.15),
                child: Center(
                  child: CustomText(
                    text: "Sign Up",
                    textColor: AppColors.blackMainColor,
                    textSize: size.width * 0.08,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.width * 0.04, bottom: size.width * 0.03),
                child: CustomText(
                  text: "Add your details to sign up",
                  textColor: AppColors.blackMainColor,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                    end: size.width * 0.2, bottom: size.width * 0.05),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.orangeMainColor,
                      radius: size.width * 0.22,
                      child: InkWell(
                        onTap:
                            selectedFile == null || selectedFile!.path.isEmpty
                                ? () {
                                    setShowOPtion(true);
                                  }
                                : null,
                        child: CircleAvatar(
                          backgroundColor: AppColors.whiteMainColor,
                          radius: size.width * 0.213,
                          child: selectedFile == null
                              ? Icon(
                                  Icons.person,
                                  color: AppColors.textFieldGrey,
                                  size: size.width * 0.2,
                                )
                              : selectedFile!.path.isNotEmpty &&
                                      selectedFile!.type == FileType.FILE
                                  ? Icon(
                                      Icons.file_copy,
                                      size: size.width * 0.15,
                                      color: AppColors.textFieldGrey,
                                    )
                                  : selectedFile!.path.isNotEmpty
                                      ? AspectRatio(
                                          aspectRatio: 1,
                                          child: ClipOval(
                                            child: Image.file(
                                              File(selectedFile!.path),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : Icon(
                                          Icons.person,
                                          color: AppColors.textFieldGrey,
                                          size: size.width * 0.2,
                                        ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible:
                          selectedFile != null && selectedFile!.path.isNotEmpty,
                      child: CircleAvatar(
                        backgroundColor: AppColors.textFieldGrey,
                        radius: size.width * 0.08,
                        child: CircleAvatar(
                          backgroundColor: AppColors.whiteMainColor,
                          radius: size.width * 0.07,
                          child: IconButton(
                              onPressed: () {
                                setShowOPtion(true);
                              },
                              icon: Icon(
                                Icons.camera_enhance,
                                color: AppColors.textFieldGrey,
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: showOptions,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                        text: "Camera",
                        onPressed: () {
                          pickFile(FileType.CAMERA)
                              .then((value) => selectedFile = value);
                        }),
                    (size.width * 0.05).ph,
                    CustomButton(
                        text: "Galley",
                        onPressed: () {
                          pickFile(FileType.GALLERY)
                              .then((value) => selectedFile = value);
                        }),
                    (size.width * 0.05).ph,
                    CustomButton(
                        text: "File",
                        onPressed: () {
                          pickFile(FileType.FILE)
                              .then((value) => selectedFile = value);
                        }),
                  ],
                ),
              ),
              (size.width * 0.05).ph,
              CustomTextField(
                hintText: "Name",
                controller: nameController,
                validator: (value) {
                  return value!.isEmpty || !isName(value)
                      ? "please enter your name"
                      : null;
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                child: CustomTextField(
                  hintText: "Email",
                  controller: emailController,
                  validator: (value) {
                    return value!.isEmpty || !isEmail(value)
                        ? "please enter your Email"
                        : null;
                  },
                ),
              ),
              CustomTextField(
                hintText: "Mobile No",
                controller: mobileNoController,
                validator: (value) {
                  return value!.isEmpty || !isPhoneNum(value)
                      ? "please enter your Mobile Number"
                      : null;
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                child: CustomTextField(
                  hintText: "Address",
                  controller: addressController,
                  validator: (value) {
                    return value!.isEmpty || !isAddress(value)
                        ? "please enter your Address"
                        : null;
                  },
                ),
              ),
              CustomTextField(
                  hintText: "Password",
                  controller: passwordController,
                  validator: (value) {
                    return value!.isEmpty || !isPassword(value)
                        ? "pls enter your password"
                        : null;
                  }),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                child: CustomTextField(
                  hintText: "Confirm Password",
                  controller: confirmPasswordController,
                  validator: (value) {
                    return value! != passwordController.text
                        ? "Not Matched"
                        : null;
                  },
                ),
              ),
              isLoading
                  ? SpinKitCircle(
                      color: AppColors.orangeMainColor,
                    )
                  : CustomButton(
                      text: "Sign Up",
                      backgroundColor: AppColors.orangeMainColor,
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          print("every thing is ok");
                          setState(() {
                            isLoading = true;
                          });
                          Future.delayed(Duration(seconds: 2)).then((value) {
                            setState(() {
                              isLoading = false;
                            });
                            Get.to(SignUpView());
                          });
                        } else {
                          print(":)");
                        }
                      }),
              Padding(
                padding: EdgeInsets.only(
                    top: size.width * 0.05, left: size.width * 0.1),
                child: Row(
                  children: [
                    CustomText(
                      text: "Already have an Account?",
                    ),
                    CustomButton(
                        text: "Login",
                        textColor: AppColors.orangeMainColor,
                        onPressed: () {
                          Get.to(LoginView());
                        })
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void setShowOPtion(bool value) {
    setState(() {
      showOptions = value;
    });
  }

  Future<FileModel> pickFile(FileType type) async {
    String path = '';

    switch (type) {
      case FileType.CAMERA:
        await picker
            .pickImage(source: ImageSource.camera)
            .then((value) => path = value?.path ?? '');
        break;
      case FileType.GALLERY:
        await picker
            .pickImage(source: ImageSource.gallery)
            .then((value) => path = value?.path ?? '');
        break;
      case FileType.FILE:
        await FilePicker.platform
            .pickFiles()
            .then((value) => path = value?.paths[0] ?? '');
        break;
    }
    setShowOPtion(false);
    return FileModel(path.isNotEmpty ? path : selectedFile!.path,
        path.isNotEmpty ? type : selectedFile!.type);
  }
}

class FileModel {
  FileType type;
  String path;

  FileModel(this.path, this.type);
}

enum FileType {
  CAMERA,
  GALLERY,
  FILE,
}
