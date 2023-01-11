


import 'package:dio/dio.dart';

class mycontroller {


  static Dio dio = Dio();

  static BaseOptions options2 = BaseOptions(
      baseUrl: 'https://api.emailjs.com/api/v1.0/email/send',
      connectTimeout: 30000,
      receiveTimeout: 30000,
      contentType: "application/json",
      headers: {"origin": 'http://localhost'},
      validateStatus: (code) {
        if (code! >= 200) {
          return true;
        } else
          return false;
      });

  Future sendEmail(
      {String? nom,
        String? prenom,
        String? email,
        String? number,
        String? type}) async {
    final serviceId = "service_p8mkvip";
    final templateId = "template_xxpagys";
    final userId = "MRdKyP9ahaYYZpRWn";
    Dio dio = Dio(options2);

    try {
      final response = await dio.post("/", data: {
        "service_id": serviceId,
        "template_id": templateId,
        "user_id": userId,
        "template_params": {
          "type": type,
          "nom": (nom!+" " +prenom!),
          "e_mail": email,
          "tel": number,
        }
      });

      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("feedbacksent");
        print(response.data.toString());
        return "Nous vous contacterons pour confirmer votre réservation";
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        print(response.data.toString());
        return "ERROR feedback" + response.data.toString();
      }
    } on DioError catch (exception) {
      print("feedback catch");

      if (exception == null ||
          exception.toString().contains('SocketException')) {
        return "Network Error";
        throw Exception("Network Error");

      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        return
            "Could'nt connect, please ensure you have a stable network.";
      } else {
        print(exception.error);
        print(exception.message);

        return exception.message.toString();
      }
    }
  }

}