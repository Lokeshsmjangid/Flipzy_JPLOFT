import 'package:flipzy/resources/text_utility.dart';
import 'package:flutter/material.dart';

class ABBCD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F1FF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.arrow_back, size: 24),
                  SizedBox(width: 8),
                  Text('Back', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 80,
              height: 80,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Image.asset('assets/lightbulb.png'),
            ),
            const SizedBox(height: 20),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  // margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.only(bottom: 20,left: 20,),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    // image: DecorationImage(image: AssetImage('assets/drawer_images/Maskshap.png',),
                    //     alignment: Alignment.topCenter)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addHeight(20),
                      Center(
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('Email Address'),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Email Address',
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text('Password'),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.visibility_off),
                          hintText: '**********',
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text('Confirm Password'),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.visibility_off),
                          hintText: '**********',
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Checkbox(value: true, onChanged: (val) {}),
                          Expanded(
                            child: Wrap(
                              children: [
                                Text('I accept the '),
                                Text(
                                  'Terms and Conditions',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                Text(' and '),
                                Text(
                                  'Privacy Policy.',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          backgroundColor: Color(0xFF5B4DCF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Text('Sign up'),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text('or sign up with'),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.g_mobiledata, size: 36, color: Colors.red),
                          const SizedBox(width: 20),
                          Icon(Icons.facebook, size: 30, color: Colors.blue),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Wrap(
                          children: [
                            Text("Already have an account? "),
                            Text("Login", style: TextStyle(color: Colors.blue)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: -60,
                    left: 0,
                    right: 0,
                    child: Image.asset('assets/drawer_images/Maskshap.png')),

              ],
            ),
          ],
        ),
      ),
    );
  }
}