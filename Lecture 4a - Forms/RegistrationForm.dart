import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              style: const TextStyle(fontSize: 30),
              decoration: const InputDecoration(
                label: Text("Email",),
                hintText: "myname@domain.com"
              ),
              validator: (value){
                print("Validating email: $value");
                if (value!.isEmpty){
                  return "Email must not be empty";
                }
                return null;
              },
              onSaved: (value){
                print("Saving email $value");
              },
            ),

            TextFormField(
              obscureText: true,
              style: const TextStyle(fontSize: 30),
              decoration: const InputDecoration(
                  label: Text("Password",),
              ),
              validator: (value){
                if (value!.length < 14){
                  return "Your password is too short (14+ chars)";
                }
                return null;
              },
              onSaved: (value){
                print("Saving password $value");
              },
            ),

            DropdownButtonFormField(
                style: const TextStyle(fontSize: 30,
                    color: Colors.black,
                ),
                items: <String>["Canada", "USA", "Mexico"]
                        .map<DropdownMenuItem<String>>(
                        (String value){
                          return DropdownMenuItem<String>(value: value,
                            child: Text(value));
                        }).toList(),
                validator: (value){
                  if (value == null){
                    return "You must choose a country";
                  }
                  return null;
                },
                onSaved: (value){
                  print("Saving country $value");
                },
                onChanged: (value){
                  print("User chose $value from the dropdown");
                }
            ),

            ElevatedButton(
                onPressed: (){
                  print("Pressed the button!");

                  if(formKey.currentState!.validate()){
                    print("Validation okay!");
                    formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("User Registered!",
                              style: TextStyle(fontSize: 30),
                          )
                      ),
                    );
                  }
                  else{
                    print("Validation failed!");
                  }

                },
                child: const Text("Register",
                  style: TextStyle(fontSize: 30),
                ),
            ),
          ],
        ),
    );
  }
}
