import 'package:flutter/material.dart';
import 'package:scene_chat/pages/chat/chat_list_page.dart';
import 'package:scene_chat/pages/widgets/custom_btn.dart';
import 'package:scene_chat/pages/widgets/custom_input.dart';
import 'package:scene_chat/pages/widgets/validation_checkboxes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewSignUpPage extends StatefulWidget {
  const NewSignUpPage({Key? key}) : super(key: key);

  @override
  State<NewSignUpPage> createState() => _NewSignUpPageState();
}

class _NewSignUpPageState extends State<NewSignUpPage> {
  // Create a new user account

  final _pageController = PageController();
  bool isLastPage = false;

  // Default Form Loading State
  final bool _registerFormLoading = false;

  // Form Input Field Values

  String _registerGender = "male";
  String _registerName = "";
  String _lastName = "";

  bool _canSkip = false;

  bool _isFirstNameValid = false;
  bool _isLastNameValid = false;

  onFirstNameChanged(String value) {
    _isFirstNameValid = false;
    _canSkip = false;
    if (value.isNotEmpty && value.length >= 3) {
      _isFirstNameValid = true;
      _canSkip = true;
    }
    setState(() {});
  }

  onLastNameChanged(String value) {
    _isLastNameValid = false;
    _canSkip = false;
    if (value.isNotEmpty && value.length >= 3) {
      _isLastNameValid = true;
      _canSkip = true;
    }
    setState(() {});
  }

  int selectedGender = -1;
  changeGender(int gender) {
    selectedGender = gender;
    if (gender == 0) {
      _registerGender = "male";
    } else {
      _registerGender = "female";
    }
    _canSkip = true;
    print(selectedGender);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            allowImplicitScrolling: false,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 2;
                _canSkip = false;
              });
            },
            children: [
              BuildSignUpPage(
                image: "assets/icon/flame_logo.png",
                title: "What is your preferred name?",
                pageColor: Colors.white30,
                description: "",
                widget: Column(
                  children: [
                    CustomInput(
                      hintText: "Amanda",
                      onChanged: (value) {
                        _registerName = value;
                        onFirstNameChanged(_registerName);
                      },
                      onSubmitted: (value) {},
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 15),
                    ValidationCheckbox(
                      hasValidValue: _isFirstNameValid,
                      name: "Contains at least 3 characters ",
                    ),
                  ],
                ),
              ),
              BuildSignUpPage(
                image: "assets/icon/flame_logo.png",
                title: "What is your preferred last name?",
                pageColor: Colors.white30,
                description: "",
                widget: Column(
                  children: [
                    CustomInput(
                      hintText: "Smith",
                      onChanged: (value) {
                        _lastName = value;
                        onLastNameChanged(_lastName);
                      },
                      onSubmitted: (value) {},
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 15),
                    ValidationCheckbox(
                      hasValidValue: _isLastNameValid,
                      name: "Contains at least 10 digits ",
                    ),
                  ],
                ),
              ),
              BuildSignUpPage(
                image: "assets/icon/flame_logo.png",
                title: "What is your preferred Gender?",
                pageColor: Colors.white30,
                description: "",
                widget: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GenderShape(
                          title: "Male",
                          isSelected: selectedGender == 0 ? true : false,
                          onTap: () {
                            selectedGender = 0;

                            changeGender(selectedGender);
                          },
                        ),
                        const SizedBox(width: 40),
                        GenderShape(
                          title: "Female",
                          isSelected: selectedGender == 1 ? true : false,
                          onTap: () {
                            selectedGender = 1;

                            changeGender(selectedGender);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomSheet: isLastPage
            ? Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomBtn(
                  text: "Create Account",
                  textColor: Colors.white,
                  outlineBtn: false,
                  onPressed: () async {
                    if (_canSkip) {
                      final prefs = await SharedPreferences.getInstance();

                      await prefs.setString("firstName", _registerName);

                      await prefs.setString("lastName", _lastName);

                      await prefs.setString("gender", _registerGender);

                      final String? getLastName = prefs.getString('lastName');
                      await prefs.setBool('isRegistered', true);

                      print(getLastName);

                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const ChatPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return child;
                          },
                        ),
                      );
                    }
                  },
                  isDisabled: !_canSkip,
                  isLoading: _registerFormLoading,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: BottomButton(
                        onTap: () {
                          if (_canSkip) {
                            _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          }
                        },
                        title: "Next",
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class GenderShape extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool isSelected;

  const GenderShape({
    Key? key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isSelected
          ? ClipOval(
              child: Container(
                height: 100,
                width: 100,
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          : ClipOval(
              child: Container(
                height: 100,
                width: 100,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.black12,
                child: Center(
                    child: Text(
                  title,
                )),
              ),
            ),
    );
  }
}

class BottomButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final double? width;

  const BottomButton(
      {Key? key, required this.title, required this.onTap, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),

        fixedSize: MaterialStateProperty.all<Size>(
          Size(width ?? double.minPositive, 50.0),
        ),
        // fill color
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.black,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 15, color: Theme.of(context).colorScheme.inversePrimary),
      ),
    );
  }
}

class BuildSignUpPage extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final Color pageColor;
  final Widget widget;

  const BuildSignUpPage({
    Key? key,
    required this.title,
    required this.image,
    required this.pageColor,
    required this.description,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: pageColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                description != "" ? const SizedBox(height: 20) : Container(),
                description != ""
                    ? Text(
                        description,
                      )
                    : Container(),
                const SizedBox(height: 20),
                widget,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
