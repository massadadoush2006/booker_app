import 'dart:io';
import 'package:booker/bloc/profile_bloc/profile_bloc.dart';
import 'package:booker/bloc/profile_bloc/profile_event.dart';
import 'package:booker/bloc/profile_bloc/profile_state.dart';
import 'package:booker/service/profil_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';


TextEditingController First_Name = TextEditingController();
TextEditingController Last_Name = TextEditingController();
TextEditingController Date_of_birth = TextEditingController();

class fill_profile extends StatefulWidget {
  const fill_profile({super.key});

  @override
  State<fill_profile> createState() => _fill_profileState();
}

class _fill_profileState extends State<fill_profile> {
  File? personalImage;
  File? idImage;

  Future<void> pickImage(bool isPersonal) async {
  final picker = ImagePicker();

  final source = await showDialog<ImageSource>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("chooese "),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("camera"),
            onTap: () => Navigator.pop(context, ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text("albom"),
            onTap: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ],
      ),
    ),
  );

  if (source != null) {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        if (isPersonal) {
          personalImage = File(pickedFile.path);
        } else {
          idImage = File(pickedFile.path);
        }
      });
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VerifyProfileBloc(ProfileRepository()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(127, 86, 217, 1),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Fill Your Profile",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<VerifyProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(" profile is saved  ")),
              );
            } else if (state is ProfileFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                children: [
                  const SizedBox(height: 49),
                  InkWell(
                    onTap: () => pickImage(true),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey.shade300,
                          child: personalImage == null
                              ? const Icon(Icons.person, size: 50, color: Colors.white)
                              : ClipOval(
                                  child: Image.file(
                                    personalImage!,
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: const Icon(Icons.add, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 61),
                  buildTextField("First Name", First_Name),
                  const SizedBox(height: 21),
                  buildTextField("Last Name", Last_Name),
                  const SizedBox(height: 21),
                  buildTextField("Date of birth", Date_of_birth),
                  const SizedBox(height: 21),
                  InkWell(
                    onTap: () => pickImage(false),
                    child: Container(
                      width: 327,
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: idImage == null
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Icon(Icons.camera_alt, size: 20, color: Colors.grey),
                                ),
                                Text(
                                  "Add ID Image",
                                  style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(idImage!, fit: BoxFit.cover, width: double.infinity),
                            ),
                    ),
                  ),
                  const SizedBox(height: 63),
                  InkWell(
                    onTap: () {
                      final firstName = First_Name.text.trim();
                      final lastName = Last_Name.text.trim();
                      final dob = Date_of_birth.text.trim();
                      final phone = "0946548515";

                      debugPrint("First Name: $firstName");
                      debugPrint("Last Name: $lastName");
                      debugPrint("Date of Birth: $dob");
                      debugPrint("Phone Number: $phone");
                      debugPrint("Personal Image: ${personalImage?.path}");
                      debugPrint("ID Image: ${idImage?.path}");

                      if (firstName.isEmpty || lastName.isEmpty || dob.isEmpty || personalImage == null || idImage == null) {
                        String missing = '';
                        if (firstName.isEmpty) missing += ' firstName , ';
                        if (lastName.isEmpty) missing += ' lastName , ';
                        if (dob.isEmpty) missing += 'dob  ';
                        if (personalImage == null) missing += ' personalImage, ';
                        if (idImage == null) missing += ' idImage ';

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(" please enter: ${missing.trim().replaceAll(RegExp(r',$'), '')}")),
                        );
                        return;
                      }

                      context.read<VerifyProfileBloc>().add(
                            SubmitProfileEvent(
                              firstName: firstName,
                              lastName: lastName,
                              dateOfBirth: dob,
                              phoneNumber: phone,
                              personalImage: personalImage!,
                              idImage: idImage!,
                            ),
                          );
                    },
                    child: Container(
                      width: 327,
                      height: 52,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromRGBO(127, 86, 217, 1),
                      ),
                      child: Center(
                        child: state is ProfileLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildTextField(String hint, TextEditingController controller) {
    return SizedBox(
      width: 327,
      height: 50,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}