import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  final String avatarImage;
  final void Function() onLoginClick;
  final void Function() googleSignIn;
  final void Function() navigatePage;

  const LoginWidget({
    super.key,
    required this.avatarImage,
    required this.onLoginClick,
    required this.googleSignIn,
    required this.navigatePage,
  });

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/mountains.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 120),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(53, 55, 88, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(37.5),
                topRight: Radius.circular(37.5),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 90),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "欢迎回来",
                    style: TextStyle(
                        fontSize: 17,
                        color: Color.fromRGBO(147, 148, 184, 1),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 22.5, right: 22.5, left: 22.5),
                    child: TextField(
                      controller: emailController,
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(90, 90, 90, 1))),
                        icon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        contentPadding: EdgeInsets.all(11.25),
                        hintText: "邮箱",
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 22.5, right: 22.5, left: 22.5),
                    child: TextField(
                      controller: passwordController,
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(90, 90, 90, 1),
                          ),
                        ),
                        icon: Icon(Icons.lock, color: Colors.white),
                        contentPadding: EdgeInsets.all(11.25),
                        hintText: "密码",
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      obscureText: true,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    margin: const EdgeInsets.only(top: 40, left: 30, right: 30),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(255, 87, 34, 1),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      onPressed: widget.onLoginClick,
                      child: const Text(
                        "登陆",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    margin: const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: TextButton(
                      style: ButtonStyle(
                        // backgroundColor: MaterialStateProperty.all<Color>(
                        //   Colors.transparent,
                        // ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      onPressed: widget.googleSignIn,
                      child: const Text(
                        "Google 登陆",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 60),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        children: [
                          IconButton(
                              icon: const Icon(Icons.keyboard_arrow_up),
                              onPressed: widget.navigatePage),
                          const Text(
                            "注册",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 2 - 50,
              top: MediaQuery.of(context).size.height / 10.1,
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(widget.avatarImage),
            ),
          ),
        ],
      ),
    );
  }
}
