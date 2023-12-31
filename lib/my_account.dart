// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:unident_app/documents_list_screen.dart';
import 'package:unident_app/my_account_change_data.dart';
import 'package:unident_app/redirect_recenzii.dart';
// import 'package:unident_app/tratamente.dart';
import 'package:unident_app/utils/api_call_functions.dart';
import '../utils/shared_pref_keys.dart' as pref_keys;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:unident_app/home_screen.dart';

ApiCallFunctions apiCallFunctions = ApiCallFunctions();

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  // bool wasPickedPhoto = false;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  String? pickedPhotoPath;
  Image asd = Image.asset('./assets/images/defaultProfilePicture.png');
  String filePath = '';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text(
            'Contul meu',
            style: TextStyle(
              color: Color.fromARGB(255, 10, 10, 135),
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.grey[100],
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              Container(
                child: filePath == ''
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Stack(
                              children: [
                                const CircleAvatar(
                                    backgroundImage: AssetImage('./assets/images/defaultProfilePicture.png'),
                                    radius: 60),
                                Positioned(
                                  top: 80,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: getImage,
                                    child: Image.asset(
                                      'assets/images/schimbaPoza.png',
                                      scale: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Stack(
                              children: [
                                CircleAvatar(backgroundImage: Image.file(File(filePath)).image, radius: 60),
                                Positioned(
                                  top: 80,
                                  right: 5,
                                  child: GestureDetector(
                                    onTap: getImage,
                                    child: Image.asset(
                                      'assets/images/schimbaPoza.png',
                                      scale: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Aici puteti gasi si modifica datele dumneavoastra personale, la fel puteti urmari planul de tratament si adauga rezultatele analizelor medicale',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const UserProfileScreen();
                  }));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(57, 52, 118, 1),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 13,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 5, 5, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Datele personale',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Ne ajuta sa va indentificam mai rapid pentru a stabili o programare',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const DocumentUserScreen();
                  }));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(57, 52, 118, 1),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 13,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 5, 5, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Descărcați documentele dvs.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Puteți descărca cele mai recente documente medicale ( radiografii, plan de tratament)',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // GestureDetector(
              //   onTap: pickfile,
              //   child: Container(
              //     height: MediaQuery.of(context).size.height * 0.15,
              //     width: MediaQuery.of(context).size.width * 0.85,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: Colors.white,
              //     ),
              //     child: const Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         Expanded(
              //           child: Padding(
              //             padding: EdgeInsets.fromLTRB(20, 5, 5, 10),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   'Adauga rezultatele analizelor',
              //                   style: TextStyle(
              //                     color: Colors.black,
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: 10,
              //                 ),
              //                 Text(
              //                     'In cazul unor manopere ce necesita anumite date despre starea dvs., ne puteti trimite rezultatele direct din aplicatie ',
              //                     maxLines: 3,
              //                     overflow: TextOverflow.ellipsis,
              //                     style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const RedirectFeedback();
                  }));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 5, 5, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lasați-ne o recenzie',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Părerea și feedback-ul dumneavoastră ne ajută să creștem calitatea serviciilor',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
        // body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        //   Center(
        //     child: Stack(
        //       children: [
        //         GestureDetector(
        //           onTap: getImage,
        //           child: CircleAvatar(
        //             backgroundImage: wasPickedPhoto
        //                 ? AssetImage(filePath)
        //                 : const AssetImage('./assets/images/defaultProfilePicture.png'),
        //             radius: 60,
        //           ),
        //         ),
        //         const Positioned(
        //           right: -10,
        //           bottom: 0,
        //           child: SizedBox(
        //             height: 46,
        //             width: 46,
        //             child: Icon(
        //               Icons.camera_alt_rounded,
        //               color: Color.fromARGB(255, 56, 163, 216),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ]),
      ),
    );
  }

  // void _takePicture() async {
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   String appDocPath = appDocDir.path;
  //   // 1. Create an ImagePicker instance.
  //   final ImagePicker picker = ImagePicker();

  //   // 2. Use the new method.
  //   //
  //   // getImage now returns a PickedFile instead of a File (form dart:io)
  //   final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

  //   // 3. Check if an image has been picked or take with the camera.
  //   if (pickedImage == null) {
  //     print(pickedImage);
  //     return;
  //   }
  //   var image = File(pickedImage.path);
  //   final fileName = 'avatar';
  //   final File localImage = await image.copy('${appDocPath}/$fileName');
  //   Image? newImage;
  //   var hasLocalImage = File('${appDocPath}/background_image').existsSync();
  //   if (hasLocalImage) {
  //     var bytes = File('${appDocPath}/background_image').readAsBytesSync();
  //     newImage = Image.memory(bytes);
  //   }
  //   // File tmpFile = File(pickedImage.path);
  //   // final Directory extDir = await getApplicationCacheDirectory();
  //   // String dirPath = extDir.path;
  //   // final fileName = Path.basename(tmpFile.path);
  //   // final String filePath = '$dirPath/image.png';
  //   // final File localImage = await tmpFile.copy('$extDir/$fileName');
  //   print(pickedImage.path);
  //   setState(() {
  //     // pickedPhotoPath = dirPath;
  //     wasPickedPhoto = true;
  //     asd = newImage!;
  //   });
  //   return;
  // }
  pickfile() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // 1. Pick the File
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      // 2. Only allow these formats
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      // 3. Get the extension type
      // String extension = file.path.substring(file.path.lastIndexOf('.'));
      String extension = Path.extension(file.path);
      // 4. Convert to base64
      //final Uint8List byteFile = file.readAsBytesSync();
      List<int> byteFile = await file.readAsBytes();
      String base64 = base64Encode(byteFile);
      // final Uint8List byteFile = await getBase64FormattedFile(file.path);
      // String base64File = readAsBytesSync(file.path);
      String? res = await apiCallFunctions.uploadDocument(
          pContinutDocument: base64, pDenumire: Path.basename(file.path), pExtensie: extension);
      print(res);
    } else {
      print("nullismo");
    }
  }

  Future<Uint8List> getBase64FormattedFile(String path) async {
    File file = File(path);
    print('File is = $file');
    // List<int> fileInByte = file.readAsBytesSync();
    // String fileInBase64 = base64Encode(fileInByte);
    final Uint8List bytes = await file.readAsBytes();
    //Base64Decoder().convert(file.toString().split(",").last);
    //NetworkImage(path) file.readAsBytesSync();
    // final Uint8List list = bytes.buffer.asUint8List();
    // print(list);
    return bytes;
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool check = prefs.containsKey('image');
    if (check) {
      setState(() {
        filePath = prefs.getString('image')!;
      });
      return;
    }
  }

  getImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    String imagePath = image.path;
    await prefs.setString('image', imagePath);
    setState(() {
      filePath = prefs.getString('image')!;
    });
  }
}
