import 'package:flutter/material.dart';
import 'package:vocabulary_app/cubit/login/login_cubit.dart';
import 'package:vocabulary_app/cubit/login/login_state.dart';
import 'package:vocabulary_app/ui/home_view.dart';
import 'package:vocabulary_app/ui/register_view.dart';
import 'package:vocabulary_app/ui/utils/validators/auth_validators.dart';
import 'package:vocabulary_app/ui/widgets/auth_form_fields.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      await context.read<LoginCubit>().login(
            _emailController.text,
            _passwordController.text,
          );
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş Yap'),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
        if (state.status == LoginStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Bir hata oluştu'),
            ),
          );
        }
        if (state.status == LoginStatus.success) {
          Navigator.pushReplacement(context, MaterialPageRoute<dynamic>(builder: (context) => const HomeView()));
        }
      }, builder: (context, state) {
        if (state.status == LoginStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: 64),
              AuthFormField(
                controller: _emailController,
                hintText: 'Email',
                labelText: 'Email',
                icon: Icons.email,
                obscureText: false,
                validator: AuthValidators.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              AuthFormField(
                controller: _passwordController,
                hintText: 'Şifre',
                labelText: 'Şifre',
                icon: Icons.lock,
                obscureText: true,
                validator: AuthValidators.validatePassword,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _login,
                child: const Text(
                  'Giriş Yap',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(
                      builder: (context) {
                        return const RegisterView();
                      },
                    ),
                  );
                },
                child: const Text(
                  'Kayıt ol',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ]),
          ),
        );
      }),
    );
  }
}
