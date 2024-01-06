import 'package:core_soft_meeting/config/constants/index.dart';
import 'package:core_soft_meeting/services/index.dart';
import 'package:core_soft_meeting/widgets/index.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../config/navigation/application_routes.dart';

class LoginPage extends StatefulWidget {
  static const name = 'login-page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final authServices = AuthServices();

  bool isPasswordVisible = false;
  bool isLoading = false;
  bool validEmail = false;
  bool validPassword = false;

  final String welcomeText = '¡Bienvenido!';
  final String signInText = 'Por favor, inicia sesión para continuar.';
  final String emailPlaceholder = 'Correo Electrónico';
  final String passwordPlaceholder = 'Contraseña';
  final String forgotPasswordText = '¿Olvidaste tu contraseña?';
  final String loginButtonText = 'Iniciar Sesión';
  final String signUpText = '¿No tienes una cuenta aún?';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> onLoginTap() async {
    setState(() {
      isLoading = true;
    });
    FocusScope.of(context).unfocus();

    try {
      final hash = await authServices.postLogin(
        emailController.text,
        passwordController.text,
      );

      if (hash.isNotEmpty) {
        String? token = await FirebaseMessaging.instance.getToken();
        if (token != null) {
          //? Logina para mandar el token mobile
          // Si todo sale bien
          final hash2 = await authServices.updateUserToken(
            token,
            passwordController.text,
          );
          if (hash2.isNotEmpty) {
            if (mounted) {
              Navigator.pushReplacementNamed(context, Routes.home);
              CustomDialog.showSuccessDialog(
                context,
                "¡Bienvenido!",
                "Has iniciado sesión correctamente.",
              );
            }
          } else {
            // Si la respuesta de postLogin es vacía
            // Muestra una alerta indicando que la autenticación falló
            if (mounted) {
              CustomDialog.showErrorDialog(
                context,
                "Error de autenticación",
                "Las credenciales son incorrectas.",
              );
            }
          }
        }
      } else {
        // Si la respuesta de postLogin es vacía
        // Muestra una alerta indicando que la autenticación falló
        if (mounted) {
          CustomDialog.showErrorDialog(
            context,
            "Error de autenticación",
            "Las credenciales son incorrectas.",
          );
        }
      }
    } catch (e) {
      // Si ocurre un error en las solicitudes, muestra una alerta genérica
      String message = e.toString();
      String title = "Error";
      String content = "Hubo un problema al procesar tu solicitud.";
      String error = message.substring(10, message.length - 1);
      if (error == " Usuario o contraseña incorrecto") {
        title = "Error de autenticación";
        content = "Las credenciales son incorrectas.";
        if (mounted) {
          CustomDialog.showErrorDialog(context, title, content);
        }
      } else {
        if (mounted) {
          CustomDialog.showErrorDialog(context, title, content);
        }
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void validateEmail(String email) {
    setState(() {
      validEmail = isValidEmail(email);
    });
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email);
  }

  void validatePassword(String password) {
    setState(() {
      validPassword = password.length >= 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* const SizedBox(
                      height: 16,
                    ),
                    Image.asset(
                      "",
                      width: 150,
                    ), */
                    const SizedBox(height: 10),
                    Text(
                      welcomeText,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      signInText,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      leftIcon: Icons.email,
                      placeholder: emailPlaceholder,
                      controller: emailController,
                      onChanged: validateEmail,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      leftIcon: Icons.lock,
                      placeholder: passwordPlaceholder,
                      isPassword: true,
                      controller: passwordController,
                      onChanged: validatePassword,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(forgotPasswordText,
                            style: const TextStyle(color: black)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                          onPressed:
                              validEmail && validPassword ? onLoginTap : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(loginButtonText,
                              style:
                                  const TextStyle(fontSize: 16, color: white))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(signUpText),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.register);
                          },
                          child: const Text("Regístrate",
                              style: TextStyle(color: black)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  color: black,
                ),
              ),
            )
        ],
      ),
    );
  }
}
