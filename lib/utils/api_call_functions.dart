import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './shared_pref_keys.dart' as pref_keys;
import 'api_call.dart';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'classes.dart';

class ApiCallFunctions {
  ApiCall apiCall = ApiCall();

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future<String?> register({
    required String pNume,
    required String pPrenume,
    required String pTelefonMobil,
    required String pDataDeNastereYYYYMMDD,
    required String pAdresaMail,
    required String pParola,
    required String pFirebaseGoogleDeviceID,
  }) async {
    final String pParolaMD5 = generateMd5(pParola);
    final Map<String, String> parametriiApiCall = {
      'pNume': pNume,
      'pPrenume': pPrenume,
      'pTelefonMobil': pTelefonMobil,
      'pDataDeNastereYYYYMMDD': pDataDeNastereYYYYMMDD,
      'pAdresaMail': pAdresaMail,
      'pParolaMD5': pParolaMD5,
      'pTipDispozitiv': Platform.isAndroid
          ? '1'
          : Platform.isIOS
              ? '2'
              : '0',
      'pModelDispozitiv': await deviceInfo(),
      'pFirebaseGoogleDeviceID': pFirebaseGoogleDeviceID,
      'pLimbaSelectata': '1',
    };

    String? res = await apiCall.apeleazaMetodaString(pNumeMetoda: 'AdaugaPacient', pParametrii: parametriiApiCall);

    return res;
  }

  Future<List<Sediu>> getListaSedii() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String idUser = prefs.getString(pref_keys.userIdAjustareCurenta)!;
    final Map<String, String> param = {
      "pAdresaMail": prefs.getString(pref_keys.userEmail)!,
      "pParolaMD5": prefs.getString(pref_keys.userPassMD5)!
    };
    String? data = await apiCall.apeleazaMetodaString(pNumeMetoda: 'GetListaSedii', pParametrii: param);

    List<Sediu> sedii = <Sediu>[];

    if (data == null) {
      return [];
    }

    if (data.contains('*\$*')) {
      List<String> l = data.split('*\$*');
      l.removeWhere((element) => element.isEmpty);
      for (var element in l) {
        List<String> parts = element.split('\$#\$');

        Sediu s = Sediu(id: parts[0], denumire: parts[1], adresa: parts[2], telefon: parts[3]);
        sedii.add(s);
      }
    }
    return sedii;
  }

  Future<String?> login({
    required String pAdresaEmail,
    required String pParolaMD5,
    required String pFirebaseGoogleDeviceID,
  }) async {
    final Map<String, String> param = {
      'pAdresaEmail': pAdresaEmail,
      'pParolaMD5': pParolaMD5,
      'pFirebaseGoogleDeviceID': pFirebaseGoogleDeviceID,
      'pTipDispozitiv': Platform.isAndroid
          ? '1'
          : Platform.isIOS
              ? '2'
              : '0',
      'pModelDispozitiv': await deviceInfo(),
    };

    String? res = await apiCall.apeleazaMetodaString(pNumeMetoda: 'Login', pParametrii: param);

    return res;
  }

  Future<List<Medic>?> getListaMedici() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String idUser = prefs.getString(pref_keys.userIdAjustareCurenta)!;
    final Map<String, String> param = {
      "pAdresaMail": prefs.getString(pref_keys.userEmail)!,
      "pParolaMD5": prefs.getString(pref_keys.userPassMD5)!
    };

    String? data = await apiCall.apeleazaMetodaString(pNumeMetoda: 'GetListaMediciV2', pParametrii: param);
    // print(data);
    List<Medic> medici = <Medic>[];
    if (data == null) {
      return null;
    }
    if (data.contains('*\$*')) {
      List<String> rawList = data.split('*\$*');
      rawList.removeWhere((element) => element.isEmpty);

      for (var string in rawList) {
        List<String> list = string.split('\$#\$');

        List<String> cats = list[5].split(',');
        List<String> sedii = list[6].split(',');
        List<String> profesii = list[7].split(',');
        String judet = list[8];

        List<int> ints = <int>[];

        if (list[2].isNotEmpty) {
          ints = list[2].split('-').map((e) => int.parse(e, radix: 16)).toList();
        }

        medici.add(Medic(
            judet: judet,
            profesii: profesii,
            id: list[0],
            nume: list[1],
            poza: Uint8List.fromList(ints),
            miniCv: list[3],
            areCvDetaliat: list[4] == '1' ? true : false,
            listaSedii: sedii,
            listaCategorii: cats));
      }
    }

    return medici;
  }

  Future<List<MedicSlotLiber>?> getListaMediciSlotLiber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String idUser = prefs.getString(pref_keys.userIdAjustareCurenta)!;
    final Map<String, String> param = {
      "pAdresaMail": prefs.getString(pref_keys.userEmail)!,
      "pParolaMD5": prefs.getString(pref_keys.userPassMD5)!
    };

    String? data =
        await apiCall.apeleazaMetodaString(pNumeMetoda: 'GetListaMediciCuPrimulSlotLiber', pParametrii: param);

    List<MedicSlotLiber> medici = <MedicSlotLiber>[];
    if (data == null) {
      return null;
    }
    if (data.contains('*\$*')) {
      String denumireSediu = '';
      String idCabinet = '';
      String idSediu = '';
      String judet = '';
      String localitate = '';
      List<String> rawList = data.split('*\$*');
      rawList.removeWhere((element) => element.isEmpty);

      for (var string in rawList) {
        List<String> list = string.split('\$#\$');
        List<String> cats = list[5].split(',');
        List<String> sedii = list[6].split(',');

        List<int> ints = <int>[];

        if (list[2].isNotEmpty) {
          ints = list[2].split('-').map((e) => int.parse(e, radix: 16)).toList();
        }
        List<String> profesii = [];
        if (list[7].isNotEmpty) {
          profesii = list[7].split(',');
          print(profesii);
        }

        DateTime dataPrimulSlotLiber = DateTime(1, 1, 1);
        // print(list.length);

        if (list.length > 9) {
          print(list[9]);
          dataPrimulSlotLiber = DateTime.utc(int.parse(list[9].substring(0, 4)), int.parse(list[9].substring(4, 6)),
              int.parse(list[9].substring(6, 8)));

          denumireSediu = list[12];
          idCabinet = list[10];
          idSediu = list[11];
          judet = list[13];
          localitate = list[14];
          // print(data);
          // print(list[7]);
        }
        if (dataPrimulSlotLiber != DateTime(1, 1, 1)) {
          medici.add(MedicSlotLiber(
              denumireSediu: denumireSediu,
              idCabinet: idCabinet,
              idSediu: idSediu,
              judet: judet,
              localitate: localitate,
              profesii: profesii,
              id: list[0],
              nume: list[1],
              poza: Uint8List.fromList(ints),
              miniCv: list[3],
              areCvDetaliat: list[4] == '1' ? true : false,
              listaSedii: sedii,
              listaCategorii: cats,
              dataPrimulSlotLiber: dataPrimulSlotLiber));
        }

        // print(list.length);
      }
    }

    return medici;
  }

  Future<String?> uploadDocument({
    required String pContinutDocument,
    required String pDenumire,
    required String pExtensie,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, String> param = {
      'pAdresaMail': prefs.getString(pref_keys.userEmail)!,
      'pParolaMD5': prefs.getString(pref_keys.userPassMD5)!,
      'pSirBitiDocument': pContinutDocument,
      'pDenumire': pDenumire,
      'pExtensie': pExtensie,
    };
    String? res = await apiCall.apeleazaMetodaString(pNumeMetoda: 'IncarcaDocumentPacient', pParametrii: param);

    return res;
  }

  Future<String?> loginByPhone({
    required String pTelefon,
    required String pParolaMD5,
    required String pFirebaseGoogleDeviceID,
  }) async {
    final Map<String, String> param = {
      'pTelefon': pTelefon,
      'pParolaMD5': pParolaMD5,
      'pFirebaseGoogleDeviceID': pFirebaseGoogleDeviceID,
      'pTipDispozitiv': Platform.isAndroid
          ? '1'
          : Platform.isIOS
              ? '2'
              : '0',
      'pModelDispozitiv': await deviceInfo(),
    };

    String? res = await apiCall.apeleazaMetodaString(pNumeMetoda: 'LoginByTelefon', pParametrii: param);

    return res;
  }

  Future<String?> updateDeviceID({
    required String pAdresaEmail,
    required String pPrimesteNotificari,
    required String pParolaMD5,
    required String pFirebaseGoogleDeviceID,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, String> param = {
      'pPrimesteNotificari': pPrimesteNotificari,
      'pAdresaEmail': pAdresaEmail,
      'pParolaMD5': pParolaMD5,
      'pFirebaseGoogleDeviceID': prefs.getString(pref_keys.fcmToken)!,
      'pTipDispozitiv': Platform.isAndroid
          ? '1'
          : Platform.isIOS
              ? '2'
              : '0',
      'pModelDispozitiv': await deviceInfo(),
    };

    String? res = await apiCall.apeleazaMetodaString(pNumeMetoda: 'UpdateDeviceID', pParametrii: param);

    return res;
  }

  Future<Programari?> getListaProgramari() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString(pref_keys.userEmail));

    // final String idUser = prefs.getString(pref_keys.userIdAjustareCurenta)!;
    final Map<String, String> param = {
      'pIdLimba': '0',
      "pAdresaMail": prefs.getString(pref_keys.userEmail)!,
      "pParolaMD5": prefs.getString(pref_keys.userPassMD5)!
    };

    String? res = await apiCall.apeleazaMetodaString(pNumeMetoda: 'GetListaProgramarileLui', pParametrii: param);

    List<Programare> programariViitoare = <Programare>[];
    List<Programare> programariTrecute = <Programare>[];
    if (res == null) {
      return null;
    }
    if (res.contains('%\$%')) {
      List<String> list = res.split('%\$%');

      List<String> viitoare = list[0].split('*\$*');
      List<String> trecute = list[1].split('*\$*');
      viitoare.removeWhere((element) => element.isEmpty);
      trecute.removeWhere((element) => element.isEmpty);

      for (var element in viitoare) {
        List<String> l = element.split('\$#\$');

        DateTime date = DateTime.utc(
          int.parse(l[0].substring(0, 4)),
          int.parse(l[0].substring(4, 6)),
          int.parse(l[0].substring(6, 8)),
          int.parse(l[0].substring(8, 10)),
          int.parse(l[0].substring(10, 12)),
        );
        DateTime dateSf = DateTime.utc(
          int.parse(l[0].substring(0, 4)),
          int.parse(l[0].substring(4, 6)),
          int.parse(l[0].substring(6, 8)),
          int.parse(l[1].substring(0, 2)),
          int.parse(l[1].substring(3, 5)),
        );

//TODO verif
        Programare p = Programare(
          nume: '',
          prenume: '',
          idPacient: '',
          medic: l[2],
          categorie: l[3],
          status: l[4],
          anulata: l[5],
          inceput: date,
          sfarsit: dateSf,
          id: l[6],
          hasFeedback: l[7],
          idMedic: l[8],
          locatie: l[9],
        );
        programariViitoare.add(p);
      }

      for (var element in trecute) {
        List<String> l = element.split('\$#\$');
//data inceput, ora final, identitate medic, categorie, status programare, 0/1 (este sau nu anulata)
        DateTime date = DateTime.utc(
          int.parse(l[0].substring(0, 4)),
          int.parse(l[0].substring(4, 6)),
          int.parse(l[0].substring(6, 8)),
          int.parse(l[0].substring(8, 10)),
          int.parse(l[0].substring(10, 12)),
        );
        DateTime dateSf = DateTime.utc(
          int.parse(l[0].substring(0, 4)),
          int.parse(l[0].substring(4, 6)),
          int.parse(l[0].substring(6, 8)),
          int.parse(l[1].substring(0, 2)),
          int.parse(l[1].substring(3, 5)),
        );
//TODO verif
        Programare p = Programare(
            nume: '',
            prenume: '',
            idPacient: '',
            id: l[6],
            medic: l[2],
            categorie: l[3],
            status: l[4],
            anulata: l[5],
            inceput: date,
            sfarsit: dateSf,
            hasFeedback: l[7],
            idMedic: l[8],
            locatie: l[9]);
        programariTrecute.add(p);
      }
    }
    programariTrecute.sort((a, b) => b.inceput.compareTo(a.inceput));
    programariViitoare.sort((a, b) => a.inceput.compareTo(b.inceput));
    return Programari(trecute: programariTrecute, viitoare: programariViitoare);
  }

  Future<String> deviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String device = '';
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      device = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      device = iosInfo.utsname.machine;
    }
    return device;
  }

  Future<void> anuleazaProgramarea(String pIdProgramare) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, String> params = {
      'pAdresaMail': prefs.getString(pref_keys.userEmail)!,
      'pParolaMD5': prefs.getString(pref_keys.userPassMD5)!,
      'pIdProgramare': pIdProgramare,
    };
    await apiCall.apeleazaMetodaString(pNumeMetoda: 'AnuleazaProgramarea', pParametrii: params);
  }

  Future<void> confirmaProgramarea(String pIdProgramare) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, String> params = {
      'pAdresaMail': prefs.getString(pref_keys.userEmail)!,
      'pParolaMD5': prefs.getString(pref_keys.userPassMD5)!,
      'pIdProgramare': pIdProgramare,
    };
    await apiCall.apeleazaMetodaString(pNumeMetoda: 'ConfirmaProgramarea', pParametrii: params);
  }

  Future<List<LinieFisaTratament>?> getListaLiniiFisaTratamentRealizate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> params = {
      'pAdresaMail': prefs.getString(pref_keys.userEmail)!,
      'pParolaMD5': prefs.getString(pref_keys.userPassMD5)!,
    };

    String? res =
        await apiCall.apeleazaMetodaString(pNumeMetoda: 'GetListaLiniiFisaTratamentRealizate', pParametrii: params);

    List<LinieFisaTratament> interventii = <LinieFisaTratament>[];
    if (res == null) {
      return null;
    }
    if (res.contains('*\$*')) {
      List<String> interventiiRaw = res.split('*\$*');
      interventiiRaw.removeWhere((v) => v.isEmpty);

      for (var interv in interventiiRaw) {
        List<String> list = interv.split('\$#\$');

        DateTime dateTime = DateTime.utc(
            int.parse(list[6].substring(0, 4)), int.parse(list[6].substring(4, 6)), int.parse(list[6].substring(6, 8)));

        String data = DateFormat('dd.MM.yyyy').format(dateTime);

        interventii.add(LinieFisaTratament(
            tipObiect: list[0],
            idObiect: list[1],
            numeMedic: list[2],
            denumireInterventie: list[3],
            dinti: list[4],
            observatii: list[5],
            dataDateTime: dateTime,
            dataString: data,
            pret: list[7],
            culoare: Color(int.parse(list[8])),
            valoareInitiala: list[9]));
      }
    }
    return interventii;
  }

  Future<List<LinieFisaTratament>?> getListaLiniiFisaTratamentDeFacut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> params = {
      'pAdresaMail': prefs.getString(pref_keys.userEmail)!,
      'pParolaMD5': prefs.getString(pref_keys.userPassMD5)!,
    };

    String? res =
        await apiCall.apeleazaMetodaString(pNumeMetoda: 'GetListaLiniiFisaTratamentDeFacut', pParametrii: params);

    List<LinieFisaTratament> interventii = <LinieFisaTratament>[];
    if (res == null) {
      return null;
    }
    if (res.contains('*\$*')) {
      List<String> interventiiRaw = res.split('*\$*');
      interventiiRaw.removeWhere((v) => v.isEmpty);

      for (var interv in interventiiRaw) {
        List<String> list = interv.split('\$#\$');

        DateTime dateTime = DateTime.utc(
            int.parse(list[6].substring(0, 4)), int.parse(list[6].substring(4, 6)), int.parse(list[6].substring(6, 8)));

        String data = DateFormat('dd.MM.yyyy').format(dateTime);

        interventii.add(LinieFisaTratament(
            tipObiect: list[0],
            idObiect: list[1],
            numeMedic: list[2],
            denumireInterventie: list[3],
            dinti: list[4],
            observatii: list[5],
            dataDateTime: dateTime,
            dataString: data,
            pret: list[7],
            culoare: Color(int.parse(list[8])),
            valoareInitiala: list[9]));
      }
    }
    return interventii;
  }

  Future<List<LinieFisaTratament>?> getListaLiniiFisaTratamentRealizateMembruFamilie(
      MembruFamilie membruFamilie) async {
    Map<String, String> params = {'pIdMembru': membruFamilie.id};

    String? res = await apiCall.apeleazaMetodaString(
        pNumeMetoda: 'GetListaLiniiFisaTratamentRealizatePeMembruFamilie', pParametrii: params);

    List<LinieFisaTratament> interventii = <LinieFisaTratament>[];
    if (res == null) {
      return null;
    }
    if (res.contains('*\$*')) {
      List<String> interventiiRaw = res.split('*\$*');
      interventiiRaw.removeWhere((v) => v.isEmpty);

      for (var interv in interventiiRaw) {
        List<String> list = interv.split('\$#\$');

        DateTime dateTime = DateTime.utc(
            int.parse(list[6].substring(0, 4)), int.parse(list[6].substring(4, 6)), int.parse(list[6].substring(6, 8)));

        String data = DateFormat('dd.MM.yyyy').format(dateTime);

        interventii.add(LinieFisaTratament(
            tipObiect: list[0],
            idObiect: list[1],
            numeMedic: list[2],
            denumireInterventie: list[3],
            dinti: list[4],
            observatii: list[5],
            dataDateTime: dateTime,
            dataString: data,
            pret: list[7],
            culoare: Color(int.parse(list[8])),
            valoareInitiala: list[9]));
      }
    }
    return interventii;
  }

  Future<List<LinieFisaTratament>?> getListaLiniiFisaTratamentDeFacutPeMembruFamilie(
      MembruFamilie membruFamilie) async {
    Map<String, String> params = {'pIdMembru': membruFamilie.id};

    String? res = await apiCall.apeleazaMetodaString(
        pNumeMetoda: 'GetListaLiniiFisaTratamentDeFacutPeMembruFamilie', pParametrii: params);

    List<LinieFisaTratament> interventii = <LinieFisaTratament>[];
    if (res == null) {
      return null;
    }
    if (res.contains('*\$*')) {
      List<String> interventiiRaw = res.split('*\$*');
      interventiiRaw.removeWhere((v) => v.isEmpty);

      for (var interv in interventiiRaw) {
        List<String> list = interv.split('\$#\$');

        DateTime dateTime = DateTime.utc(
            int.parse(list[6].substring(0, 4)), int.parse(list[6].substring(4, 6)), int.parse(list[6].substring(6, 8)));

        String data = DateFormat('dd.MM.yyyy').format(dateTime);

        interventii.add(LinieFisaTratament(
            tipObiect: list[0],
            idObiect: list[1],
            numeMedic: list[2],
            denumireInterventie: list[3],
            dinti: list[4],
            observatii: list[5],
            dataDateTime: dateTime,
            dataString: data,
            pret: list[7],
            culoare: Color(int.parse(list[8])),
            valoareInitiala: list[9]));
      }
    }
    return interventii;
  }

  Future<String?> getDetaliiProgramare(String pIdProgramare) async {
    ApiCall apiCall = ApiCall();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, String> params = {
      'pAdresaMail': prefs.getString(pref_keys.userEmail)!,
      'pParolaMD5': prefs.getString(pref_keys.userPassMD5)!,
      'pIdProgramare': pIdProgramare,
    };
    String? lmao = await apiCall.apeleazaMetodaString(pNumeMetoda: 'GetDetaliiProgramare', pParametrii: params);
    print(lmao);
    if (lmao == null) {
      return null;
    } else {
      List<String> ayy = lmao.split('\$#\$');
      DetaliiProgramare a = DetaliiProgramare(
          dataInceput: ayy[0],
          oraFinal: ayy[1],
          numeMedic: ayy[2],
          idCategorie: ayy[3],
          statusProgramare: ayy[4],
          esteAnulat: ayy[5],
          numeLocatie: ayy[6],
          listaInterventii: ayy[7].split('%\$%'));
      // String total = '';
      // List<String> details = [];
      // details.add(a.numeLocatie);
      // print(a.listaInterventii);
      // // print(a.listaInterventii[6]);
      // List<double> listaPreturi = [];

      // for (String date in a.listaInterventii) {
      //   listaPreturi.add(double.parse(date[2]));
      // }
      // double sumaTotala = listaPreturi.reduce((a, b) => a + b);
      // return (sumaTotala.toString());
      return a.GetTotal().toString();
    }
  }

  Future<String?> reseteazaParola({
    required String pAdresaMail,
    required String pParolaNoua,
  }) async {
    final String pParolaNouaMD5 = generateMd5(pParolaNoua);
    final Map<String, String> param = {'pAdresaMail': pAdresaMail, 'pParolaNouaMD5': pParolaNouaMD5};
    String? res = await apiCall.apeleazaMetodaString(pNumeMetoda: 'ReseteazaParola', pParametrii: param);
    return res;
  }

  Future<String?> reseteazaParolaValidarePIN({
    required String pAdresaMail,
    required String pParolaNoua,
    required String pPINDinMail,
  }) async {
    final String pParolaNouaMD5 = generateMd5(pParolaNoua);

    final Map<String, String> param = {
      'pAdresaMail': pAdresaMail,
      'pParolaNouaMD5': pParolaNouaMD5,
      'pPINDinMail': pPINDinMail
    };

    String? res = await apiCall.apeleazaMetodaString(pNumeMetoda: 'ReseteazaParolaValidarePIN', pParametrii: param);
    return res;
  }

  Future<String?> schimbaDateleDeContact({
    required String pNouaAdresaDeEmail,
    required String pNoulTelefon,
    required String pAdresaDeEmail,
    required String pParola,
  }) async {
    Map<String, String> param = {
      'pAdresaMail': pAdresaDeEmail,
      'pParola': pParola,
      'pNouaAdresaDeEmail': pNouaAdresaDeEmail,
      'pNoulTelefon': pNoulTelefon,
    };

    String? data = await apiCall.apeleazaMetodaString(pNumeMetoda: 'SchimbaDateleDeContact', pParametrii: param);

    return data;
  }

  Future<String?> adaugaTaskActualizareDateContact({
    required String pAdresaMailNoua,
    required String pTelefonNou,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> param = {
      'pAdresaMail': prefs.getString(pref_keys.userEmail)!,
      'pParolaMD5': prefs.getString(pref_keys.userPassMD5)!,
      'pTelefonNou': pTelefonNou,
      'pAdresaMailNoua': pAdresaMailNoua,
    };

    String? data =
        await apiCall.apeleazaMetodaString(pNumeMetoda: 'AdaugaTaskActualizareDateContact', pParametrii: param);
    return data;
  }

  Future<String?> schimbaDateleDeContactValidarePin({
    required String pAdresaMail,
    required String pParola,
    required String pPINDinMail,
  }) async {
    final Map<String, String> param = {'pAdresaMail': pAdresaMail, 'pParola': pParola, 'pPINDinMail': pPINDinMail};
    String? res =
        await apiCall.apeleazaMetodaString(pNumeMetoda: 'SchimbaDateleDeContactValidarePIN', pParametrii: param);
    return res;
  }

  Future<String?> adaugaProgramare({
    required String pIdCategorie,
    required String pIdMedic,
    required String pDataProgramareDDMMYYYYHHmm,
    required String pObservatiiProgramare,
    required String pIdSediu,
    required String pIdMembruFamilie,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, String> param = {
      'pAdresaMail': prefs.getString(pref_keys.userEmail)!,
      'pParolaMD5': prefs.getString(pref_keys.userPassMD5)!,
      'pIdCategorie': pIdCategorie,
      'pIdMedic': pIdMedic,
      'pDataProgramareDDMMYYYYHHmm': pDataProgramareDDMMYYYYHHmm,
      'pObservatiiProgramare': pObservatiiProgramare,
      'pIdSediu': pIdSediu,
      'pIdMembruFamilie': pIdMembruFamilie,
    };

    String? data = await apiCall.apeleazaMetodaString(pNumeMetoda: 'AdaugaProgramareV2', pParametrii: param);

    return data;
  }

  Future<String?> adaugaFeedbackPeMedic({
    required String pIdProgramare,
    required String nota,
    required String pIdMedic,
    String? pObservatii,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, String> param = {
      'pAdresaMail': prefs.getString(pref_keys.userEmail)!,
      'pParolaMD5': prefs.getString(pref_keys.userPassMD5)!,
      'pIdMedic': pIdMedic,
      'pIdProgramare': pIdProgramare,
      'pObservatii': pObservatii ?? "",
      'pNota': nota,
    };
    String? data = await apiCall.apeleazaMetodaString(pNumeMetoda: 'AdaugaFeedbackPeMedic', pParametrii: param);
    print(data);
    return data;
  }

  Future<DetaliiDoctor?> getDetaliiDoctor({
    required String pIdMedic,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, String> param = {
      'pAdresaEmail': prefs.getString(pref_keys.userEmail)!,
      'pParolaMD5': prefs.getString(pref_keys.userPassMD5)!,
      'pIdMedic': pIdMedic,
    };
    String? data = await apiCall.apeleazaMetodaString(pNumeMetoda: 'GetDetaliiMedic', pParametrii: param);
    List<String> listaDetalii = data!.split('\$#\$');
    DetaliiDoctor detaliiDoctor = DetaliiDoctor(
      nrReviewuri: listaDetalii[0],
      notaMedieReview: listaDetalii[1],
      nrPacienti: listaDetalii[2],
      experienta: listaDetalii[3],
    );
    return detaliiDoctor;
  }

  Future<String> getSirBitiDocument(String pIdDocument) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, String> param = {
      'pAdresaMail': prefs.getString(pref_keys.userEmail)!,
      'pParolaMD5': prefs.getString(pref_keys.userPassMD5)!,
      'pIdDocument': pIdDocument,
    };
    String? data = await apiCall.apeleazaMetodaString(pNumeMetoda: 'GetSirBitiDocument', pParametrii: param);
    return data!;
  }

  Future<List<MembruFamilie>> getListaFamilie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, String> param = {
      'pAdresaMail': prefs.getString(pref_keys.userEmail)!,
      'pParolaMD5': prefs.getString(pref_keys.userPassMD5)!,
    };
    String? data = await apiCall.apeleazaMetodaString(pNumeMetoda: 'GetListaFamilie', pParametrii: param);

    List<MembruFamilie> familie = <MembruFamilie>[];
    if (data == null) {
      return [];
    }
    if (data.contains('*\$*')) {
      List<String> l = data.split('*\$*');
      l.removeWhere((element) => element.isEmpty);
      for (var element in l) {
        List<String> parts = element.split('\$#\$');

        MembruFamilie s = MembruFamilie(id: parts[0], nume: parts[1], prenume: parts[2]);
        familie.add(s);
      }
    }

    return familie;
  }

  Future<List<FetchedDocument>?> getListaDocumente() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, String> param = {
      'pAdresaMail': prefs.getString(pref_keys.userEmail)!,
      'pParolaMD5': prefs.getString(pref_keys.userPassMD5)!,
    };
    String? data = await apiCall.apeleazaMetodaString(pNumeMetoda: 'GetListaDocumente', pParametrii: param);
    List<FetchedDocument> listaDocumenteFinala = [];
    if (data == null) {
      return null;
    } else if (data.contains('*\$*')) {
      List<String> listaDocumente = data.split('*\$*');
      listaDocumente.removeWhere((element) => element.isEmpty);

      for (var document in listaDocumente) {
        List<String> listaDocument = document.split('\$#\$');
        listaDocumenteFinala.add(FetchedDocument(
          id: listaDocument[0],
          nume: listaDocument[1],
        ));
      }
    }
    return listaDocumenteFinala;
  }

  Future<List<FetchedDocument>?> getListaDocumenteCopil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, String> param = {
      'pIdMembru': Shared.familie[0].id,
    };
    String? data =
        await apiCall.apeleazaMetodaString(pNumeMetoda: 'GetListaDocumentePeMembruFamilie', pParametrii: param);
    List<FetchedDocument> listaDocumenteFinala = [];
    if (data == null) {
      return null;
    } else if (data.contains('*\$*')) {
      List<String> listaDocumente = data.split('*\$*');
      listaDocumente.removeWhere((element) => element.isEmpty);

      for (var document in listaDocumente) {
        List<String> listaDocument = document.split('\$#\$');
        listaDocumenteFinala.add(FetchedDocument(
          id: listaDocument[0],
          nume: listaDocument[1],
        ));
      }
    }
    return listaDocumenteFinala;
  }
}
