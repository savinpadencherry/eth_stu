// ignore_for_file: prefer_const_constructors_in_immutables, sort_child_properties_last, prefer_const_constructors

part of sign_up_view;

class _SignUpMobile extends StatefulWidget {
  _SignUpMobile();

  @override
  State<_SignUpMobile> createState() => _SignUpMobileState();
}

class _SignUpMobileState extends State<_SignUpMobile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  submit() async {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();
    final UserCredential? user = await getIt<AuthService>().signUpUser(
      email: nameController.text.trim(),
      password: passwordController.text.trim(),
    );
    if (user != null) {
      getIt<NavigatorService>().buildAndPush(
        HomeView(
          userCredential: user,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Notif',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Must Contain a email';
                    }
                    if (!isEmail(value.trim())) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: Text('Sign Up'),
                    onPressed: submit,
                  )),
              Row(
                children: <Widget>[
                  const Text('Have an account?'),
                  TextButton(
                    child: const Text(
                      'Log In',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      getIt<NavigatorService>().buildAndPush(
                        const LoginView(),
                      );
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
