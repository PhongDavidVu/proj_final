import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hw/gen/assets.gen.dart';
import 'package:hw/generated/l10n.dart';
import 'package:hw/postSignUp/todo_screen.dart';
import 'package:hw/signup/bloc/sign_up_cubit.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
        child: BlocProvider<SignUpCubit>(
          create: (context) => SignUpCubit(),
          child: _HomeContent(),
        ),
      );
}

class _HomeContent extends StatelessWidget {
  _HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 92.0),
                      child: Text(
                        Batch16String.current.welcome,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Assets.female.image(width: 89, height: 88),
                ),
                Text(
                  Batch16String.current.request,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocListener<SignUpCubit, SignUpState>(
                      listener: (context, state) {
                        if (state is SignUpFailed && state.provider == 'github') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(Batch16String.current.notSupported( 'Github'))));
                        }
                        if (state is SignUpFailed && state.provider == 'LinkedIn') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(Batch16String.current.notSupported( 'LinkedIn'))));
                        }
                        if (state is SignUpSuccess && state.provider == 'google') {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => todo_screen()));
                          });
                        }
                      },
                      child: AccountHolder(
                          image: Assets.git.image(width: 43, height: 43),
                          onTap: () {
                            context.read<SignUpCubit>().signupWithGitHub();
                          }),
                    ),
                    AccountHolder(
                      image: Assets.google.image(width: 43, height: 43),
                      onTap: () =>
                          context.read<SignUpCubit>().signupWithGoogle(),
                    ),
                    AccountHolder(
                        image: Assets.linkedIN.image(width: 43, height: 43),
                        onTap: () =>
                            context.read<SignUpCubit>().signupWithLinkedIn())
                  ],
                ),

                Text(
                  Batch16String.current.or,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                ),
                SizedBox(height: 20),
                IconTextFieldRow(
                  hint: Batch16String.current.name,
                  image: Assets.human.path,
                  onTextChange: (value) {
                    context
                        .read<SignUpCubit>()
                        .name = value;
                  },
                ),
                IconTextFieldRow(
                  hint: Batch16String.current.email,
                  image: Assets.mail.path,
                  onTextChange: (value) {
                    context
                        .read<SignUpCubit>()
                        .email = value;
                  },
                ),
                IconTextFieldRow(
                  hint: Batch16String.current.password,
                  image: Assets.key.path,
                  hintImage: Assets.visible.path,
                  onTextChange: (value) {
                    context
                        .read<SignUpCubit>()
                        .password = value;
                  },
                ),
                SizedBox(height: 25),
                BlocBuilder<SignUpCubit, SignUpState>(
                  builder: (context, state) {
                    if (state is SignUp && state.status == 'Failed') {
                      return Text(state.reason);
                    }
                    if (state is SignUp && state.status == 'Success') {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => todo_screen()));
                      });
                    }

                    return SizedBox.shrink();
                  },
                ),
                InkWell(
                  child: Container(
                    height: 34,
                    width: 65,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                        child: Text(
                          Batch16String.current.login,
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              color: Colors.white),
                        )),
                  ),
                  onTap: () {
                    context.read<SignUpCubit>().signUp();
                  },
                ),

              ]),
            ),
          )),
    );
  }
}

class AccountHolder extends StatelessWidget {
  const AccountHolder({required this.image, this.onTap, super.key});
  final Image image;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(17),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 40,
                    blurStyle: BlurStyle.outer,
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(2, 2))
              ]),
          child: image,
        ),
      );
}

class IconTextFieldRow extends StatefulWidget {
  const IconTextFieldRow(
      {required this.image,
      required this.hint,
      this.hintImage,
      required this.onTextChange,
      super.key});

  final String image;
  final String hint;
  final String? hintImage;
  final ValueChanged<String> onTextChange;
  @override
  State<IconTextFieldRow> createState() => _IconTextFieldRowState();
}

class _IconTextFieldRowState extends State<IconTextFieldRow> {
  final TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller.addListener(() {
      widget.onTextChange(controller.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Row(
          children: [
            Image.asset(widget.image, width: 43, height: 43),
            SizedBox(width: 10),
            Expanded(
                child: Container(
              height: 40,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(0, 4),
                      blurRadius: 20)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(17, 20, 20, 10),
                    hintText: widget.hint,
                    suffixIcon: widget.hintImage != null
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: 13.0,
                                right: 8.0), // Adjust the padding as needed
                            child: Image.asset(widget.hintImage!,
                                width: 21,
                                height:
                                    17), // If an image is provided, use it as a prefix icon
                          )
                        : null, // If no image is provided, don't display an icon
                  )),
            )),
          ],
        ),
      );
}