import 'dart:typed_data';
import 'package:campus_connect_app/models/user.dart';
import 'package:campus_connect_app/providers/user_provider.dart';
import 'package:campus_connect_app/resources/firestore_methods.dart';
import 'package:campus_connect_app/utils/colors.dart';
import 'package:campus_connect_app/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  Uint8List? _file;
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _venuecontroller = TextEditingController();
  bool _isLoading = false;

  void postEvent(
      String uid, String username, String userId, String profImage) async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_namecontroller.text == '' || _venuecontroller.text == '') {
        showSnackBar("Please provide name and venue", context);
        return;
      }
      String res = await FirestoreMethods().uploadEvent(
        _namecontroller.text,
        _venuecontroller.text,
        _file!,
        uid,
        username,
        userId,
        profImage,
      );
      if (res == 'Success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar("Posted", context);
        clearImage();
        Navigator.pop(context);
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
      _namecontroller.text = "";
      _venuecontroller.text = "";
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Create an Event"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Take a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.camera,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Choose from gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.gallery,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _namecontroller.dispose();
    _venuecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Center(
            child: IconButton(
              onPressed: () => _selectImage(context),
              icon: const Icon(Icons.upload),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: clearImage,
              ),
              title: const Text(
                "Post Event",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
              actions: [
                TextButton(
                    onPressed: () => postEvent(
                          user?.uid ?? 'DefauliUid',
                          user?.username ?? 'DefauliUid',
                          user?.userid ?? 'DefauliUid',
                          user?.photoUrl ?? 'DefauliUid',
                        ),
                    child: const Text(
                      "Post",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ))
              ],
            ),
            body: Column(children: [
              _isLoading
                  ? const LinearProgressIndicator()
                  : const Padding(
                      padding: EdgeInsets.only(top: 0),
                    ),
              const Divider(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      children: [
                        TextField(
                          controller: _namecontroller,
                          decoration: const InputDecoration(
                            label: const Text("Event Name"),
                            hintText: 'Event name...',
                            border: InputBorder.none,
                          ),
                          maxLines: 1,
                        ),
                        TextField(
                          controller: _venuecontroller,
                          decoration: const InputDecoration(
                            label: const Text("Event Venue"),
                            hintText: 'Event venue...',
                            border: InputBorder.none,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      height: 250,
                      width: 170,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(_file!),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ]),
          );
  }
}
