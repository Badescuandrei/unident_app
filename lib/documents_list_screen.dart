import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unident_app/apinio.dart';
import 'package:unident_app/utils/api_call_functions.dart';
import 'package:unident_app/utils/classes.dart';

final Color kDarkBlueColor = const Color(0xFF053149);
ApiCallFunctions apiCallFunctions = ApiCallFunctions();
final BoxShadow kDefaultBoxshadow = const BoxShadow(
  color: Color(0xFFDFDFDF),
  spreadRadius: 1,
  blurRadius: 10,
  offset: Offset(2, 2),
);

class DocumentUserScreen extends StatefulWidget {
  const DocumentUserScreen({super.key});

  @override
  State<DocumentUserScreen> createState() => _DocumentUserScreenState();
}

class _DocumentUserScreenState extends State<DocumentUserScreen> {
  bool documenteToggle = true;
  Future<List<FetchedDocument>?>? listadocumenteUser;
  Future<List<FetchedDocument>?>? listadocumenteCopil;
  @override
  void initState() {
    // (setPage);
    super.initState();
    listadocumenteUser = getListaDocumente();
    listadocumenteCopil = getListaDocumenteCopil();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: const Text('Documente', style: TextStyle(fontSize: 20)),
          backgroundColor: const Color.fromRGBO(57, 52, 118, 1),
          centerTitle: true),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 20),
            documenteUserToggle(context),
            const SizedBox(height: 20),
            documenteToggle ? listaDocumenteUser() : listaDocumenteCopil(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<FetchedDocument>?> listaDocumenteUser() {
    return FutureBuilder(
      future: listadocumenteUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('A apărut o eroare!'));
        }
        return ListView.separated(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  child: Row(children: [
                    Expanded(
                      flex: 8,
                      child: Text(snapshot.data![index].nume),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          apiCallFunctions.getSirBitiDocument(snapshot.data![index].id).then((value) async {
                            Uint8List bytes = base64Decode(value);
                            final output = await getApplicationDocumentsDirectory();
                            File file = File("${output.path}/${snapshot.data![index].nume}");
                            await file.writeAsBytes(bytes, flush: true);
                            return file;
                          }).then((value) => openFile(value.path));

                          //                                 }).then((value) =>

                          //                                     // Navigator.push(
                          //                                     //     context, MaterialPageRoute(builder: (context) => PDFScreen(path: value.path))));
                          //  return await OpenFile.open('${myFile.toString()}');
                          //                                     OpenFile.open(value.path));
                        },
                        child: const Icon(Icons.cloud_download_sharp),
                      ),
                    )
                  ]),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            itemCount: snapshot.data!.length);
      },
    );
  }

  FutureBuilder<List<FetchedDocument>?> listaDocumenteCopil() {
    return FutureBuilder(
      future: listadocumenteCopil,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('A apărut o eroare!'));
        }
        return ListView.separated(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  child: Row(children: [
                    Expanded(
                      flex: 8,
                      child: Text(snapshot.data![index].nume),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          apiCallFunctions.getSirBitiDocument(snapshot.data![index].id).then((value) async {
                            Uint8List bytes = base64Decode(value);
                            final output = await getApplicationDocumentsDirectory();
                            File file = File("${output.path}/${snapshot.data![index].nume}");
                            await file.writeAsBytes(bytes, flush: true);
                            return file;
                          }).then((value) => openFile(value.path));

                          //                                 }).then((value) =>

                          //                                     // Navigator.push(
                          //                                     //     context, MaterialPageRoute(builder: (context) => PDFScreen(path: value.path))));
                          //  return await OpenFile.open('${myFile.toString()}');
                          //                                     OpenFile.open(value.path));
                        },
                        child: const Icon(Icons.cloud_download_sharp),
                      ),
                    )
                  ]),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            itemCount: snapshot.data!.length);
      },
    );
  }

  Future<List<FetchedDocument>?> getListaDocumente() async {
    List<FetchedDocument>? listadocs = [];
    listadocs = await apiCallFunctions.getListaDocumente();
    if (listadocs != null) {
      return listadocs;
    } else {
      return null;
    }

    // Shared.documente.clear();
    // Shared.documente.addAll(value);
    // if (mounted) {
    //   setState(() {});
    // }
  }

  Future<List<FetchedDocument>?> getListaDocumenteCopil() async {
    List<FetchedDocument>? listadocs = [];
    listadocs = await apiCallFunctions.getListaDocumenteCopil();
    if (listadocs != null) {
      return listadocs;
    } else {
      return null;
    }

    // Shared.documente.clear();
    // Shared.documente.addAll(value);
    // if (mounted) {
    //   setState(() {});
    // }
  }

  openFile(String path) async {
    final myFile = File(path);
    // return await OpenFilex.open(myFile.path.toString());
    return await OpenFilex.open(myFile.path);
  }

  AppinioAnimatedToggleTab documenteUserToggle(BuildContext context) {
    return AppinioAnimatedToggleTab(
      duration: const Duration(milliseconds: 150),
      offset: 0,
      callback: (int index) {
        setState(() {
          documenteToggle = !documenteToggle;
        });
      },
      tabTexts: const [
        'Documentele dvs.',
        'Documentele copilului',
      ],
      height: 45,
      width: MediaQuery.of(context).size.width * 0.9,
      boxDecoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          kDefaultBoxshadow,
        ],
      ),
      animatedBoxDecoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 63, 119, 153).withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(2, 2),
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      activeStyle: TextStyle(
        fontSize: 12,
        color: kDarkBlueColor,
        fontWeight: FontWeight.w600,
      ),
      inactiveStyle: const TextStyle(
        fontSize: 12,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
