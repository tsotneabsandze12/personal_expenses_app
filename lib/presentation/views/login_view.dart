import 'package:flutter/material.dart';
import 'package:personal_expenses_app/presentation/widgets/btn.dart';
import '../size_config.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

      return  Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,

        body: Align(
          alignment: Alignment.topCenter,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints con) {
              return Container(
                margin: EdgeInsets.only(top: con.maxHeight * .2),
                height: con.maxHeight * .6,
                width: con.maxWidth * .6,
                child: Column(
                  children: [
                    Image.asset('assets/images/logo.png'),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 40,
                      width: con.maxWidth,
                      decoration: BoxDecoration(
                        color:Theme.of(context).primaryColor ,
                        borderRadius:  BorderRadius.circular(10),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 17),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Btn(
                      text: 'LOGIN',
                      height: 40,
                      width: con.maxWidth,
                      radius: 10,
                      fontColor: Colors.black,
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
  }
}
