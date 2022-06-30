import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet_2cs/config/config.dart';
import 'package:projet_2cs/screens/layout.dart';
import 'package:projet_2cs/screens/loading.dart';
import 'package:projet_2cs/services/cloud_service.dart';
import 'package:projet_2cs/widgets/all_widgets.dart';
import 'package:projet_2cs/widgets/free_scaffold.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static const route = "/login";

  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email = '';
  String password = '';
  Map<String, String?> loginInfo = {};
  bool _isLoading = false;
  bool showText = false;
  final _formKey = GlobalKey<FormState>();


  Future<void> validateForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();

      try {
        await Provider.of<Auth>(context, listen: false).login(email, password);
        Navigator.pushReplacementNamed(context, Layout.route);

        setState(() {
          _isLoading = false;
        });
        print('login success');
      } catch (e) {
        errorSnackBar(
            context,
            Provider.of<Auth>(context, listen: false).transportateur?.error ??
                "error");
        setState(() {
          _isLoading = false;
        });
      }

      //Navigator.pushReplacementNamed(context, Layout.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FreeScaffold(
      background: [
        Positioned(
            top: -450,
            left: -150,
            child: SvgPicture.asset('assets/images/bg.svg')),
      ],
      scaffold: Scaffold(
        body: SafeArea(
          child: _isLoading
              ? Loading()
              : SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height -
                        2 * verticalPadding,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Bienvenue",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              Text(
                                "Connectez \nvous!",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ],
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                defaultTextFormField(
                                    label: "Email",
                                    hint: "Ecrire votre email",
                                    validator: (val) {
                                      if (!val!.isNotEmpty) {
                                        return "please enter an email";
                                      }
                                      return null;
                                    },
                                    onSaved: (val) {
                                      setState(() {
                                        email = val ?? "";
                                      });
                                    }),
                                const SizedBox(height: 40),
                                defaultTextFormField(
                                    label: "Mot de passe",
                                    hint: "Ecrire votre mot dr passe",
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            showText = !showText;
                                          });
                                        },
                                        icon: Icon(
                                          showText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        )),
                                    obscureText: showText,
                                    validator: (val) {
                                      if (val!.length < 4) {
                                        return "please enter a 4+ char long password";
                                      }
                                      return null;
                                    },
                                    onSaved: (val) {
                                      setState(() {
                                        password = val ?? '';
                                      });
                                    }),
                                const SizedBox(height: 40),
                                defaultButton(
                                    context: context,
                                    onPressed: () async {
                                      await validateForm();
                                      /* Navigator.pushReplacementNamed(
                                    context, Layout.route);*/
                                    },
                                    text: "Se connecter",
                                    showArrow: false,
                                    centerText: true,
                                    rounded: true),
                              ],
                            ),
                          ),
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
