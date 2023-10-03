import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
// import 'package:practice3/login_page.dart';

class ProfileController extends GetxController {
  Rx<XFile?> profileImage = Rx<XFile?>(null);
  final emailController = TextEditingController();
  final emailError = ''.obs;
  void pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage.value = pickedFile;
    }
  }

  void pickImageFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      profileImage.value = pickedFile;
    }
  }
  void validateEmail() {
    String email = emailController.text.trim();
    if (email.isEmpty) {
      emailError.value = 'Please enter an email address';
    } else {
      // Regular expression pattern for email validation
      String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
      RegExp regExp = RegExp(emailPattern);
      if (!regExp.hasMatch(email)) {
        emailError.value = 'Please enter a valid email address';
      } else {
        emailError.value = '';
      }
    }
  }

  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}

class ProfilePage extends StatelessWidget {
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight:MediaQuery.of(context).size.height*0.12,
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xFFFFFFFF),
            flexibleSpace: FlexibleSpaceBar(
                background:
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.06,
                        // vertical: MediaQuery.of(context).size.height * 0.1,
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Image.asset(
                              'assests/linear_arrow.png',
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding:  EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.06,
                    // vertical: MediaQuery.  of(context).size.height * 0.1,
                  ),
                  child: Container(
                    // color:Color(0xFFFFFFFF),
                    child: SingleChildScrollView(
                        child:
                        Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                            Center(
                              child: Stack(
                                alignment: Alignment.center,
                                clipBehavior: Clip.none,
                                children: <Widget>[
                                  Obx(() => CircleAvatar(
                                    radius: 80.0,
                                    backgroundImage: _profileController.profileImage.value == null
                                        ? AssetImage("assests/profile.png") as ImageProvider<Object>?
                                        : FileImage(File(_profileController.profileImage.value!.path)),
                                  )),
                                  Positioned(
                                    bottom: -20,
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF4730E),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: ((builder) => bottomSheet()),
                                            );
                                          },
                                          child: Image.asset(
                                            'assests/linear_camera.png',
                                            width: MediaQuery.of(context).size.width * 0.05,
                                            height: MediaQuery.of(context).size.width * 0.05,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width *
                                      0.02),
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.08,
                                color: Color(
                                    0xFFF2F2F2),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    hintText: 'Eric Smith',
                                    isDense: true,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        'Name:         ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenWidth * 0.04,
                                        ),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFF2F2F2),
                                    border: InputBorder
                                        .none,
                                    focusedBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: screenHeight*0.025),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width *
                                      0.02),
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.08,
                                color: Color(
                                    0xFFF2F2F2),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  controller: _profileController.emailController,
                                  keyboardType:
                                  TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: 'ericsmith@mail.com',
                                    isDense: true,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        'Email:         ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenWidth * 0.04,
                                        ),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFF2F2F2),
                                    border: InputBorder
                                        .none,
                                    focusedBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: screenHeight*0.025),
                                  ),
                                  onChanged: (value) {
                                    _profileController.emailError.value = '';
                                  },
                                  onEditingComplete: () {
                                    _profileController.validateEmail();
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.00,
                            ),
                            Obx(
                                  () => Padding(
                                padding: EdgeInsets.only(
                                    left: screenWidth * 0.08,
                                    bottom: screenHeight * 0.01),
                                child: Text(
                                  _profileController.emailError.value.isNotEmpty
                                      ? _profileController.emailError.value
                                      : '',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: screenWidth * 0.035),
                                ),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width *
                                      0.02),
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.08,
                                color: Color(
                                    0xFFF2F2F2),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    hintText: 'Florida',
                                    isDense: true,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        'Address:      ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenWidth * 0.04,
                                        ),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFF2F2F2),
                                    border: InputBorder
                                        .none,
                                    focusedBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: screenHeight*0.025),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width *
                                      0.02),
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.08,
                                color: Color(
                                    0xFFF2F2F2),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    hintText: '123456',
                                    isDense: true,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        'Postel Code:',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenWidth * 0.04,
                                        ),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFF2F2F2),
                                    border: InputBorder
                                        .none,
                                    focusedBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: screenHeight*0.025),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width *
                                      0.02),
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.08,
                                color: Color(
                                    0xFFF2F2F2),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    hintText: 'USA',
                                    isDense: true,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        'Country:         ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenWidth * 0.04,
                                        ),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFF2F2F2),
                                    border: InputBorder
                                        .none,
                                    focusedBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: screenHeight*0.025),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.04,
                            ),
                            Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _profileController.validateEmail();
                                      String email = _profileController.emailController.text;
                                      if (email.isEmpty ||
                                          _profileController.emailError.value.isNotEmpty ) {
                                        return;
                                      } else {
                                        // Get.to(LoginPage());
                                      }
                                    },
                                    child: Text(
                                      'Update Profile',
                                      style: TextStyle(fontSize: screenWidth * 0.05),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                        Color(0xFFF4730E),
                                      ),
                                      minimumSize: MaterialStateProperty.all<Size>(
                                        Size(double.infinity, screenHeight * 0.07),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.023,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  // Get.back();
                                },
                                child: Container(
                                  child: Text(
                                    "Update to Business Profile",
                                    style: TextStyle(color: Color(0xFFF4730E), fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.1,
                            ),
                          ],)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  _profileController.pickImageFromCamera();
                  Get.back();
                },
                icon: Icon(Icons.camera),
                label: Text("Camera"),
                style: TextButton.styleFrom(
                  primary: Colors.black,
                  onSurface: Colors.white,
                ),
              ),
              SizedBox(width: 20),
              TextButton.icon(
                onPressed: () {
                  _profileController.pickImageFromGallery();
                  Get.back();
                },
                icon: Icon(Icons.image),
                label: Text("Gallery"),
                style: TextButton.styleFrom(
                  primary: Colors.black,
                  onSurface: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
