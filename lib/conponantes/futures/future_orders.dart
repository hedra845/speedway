import 'package:dio/dio.dart';
import 'package:sender/config/Strings.dart';
import 'package:sender/conponantes/futures/future_read_t.dart';
import 'package:uid/uid.dart';

Future orders_data() async {
  var headers = {'Authorization': 'Bearer ${await storage.read(key: 'token')}'};
  var data = FormData.fromMap({
    'uid': UId.getId(),
  });

  var dio = Dio();
  var response = await dio.request(
    '${Apis.BASE_URL}/orders/all',
    options: Options(
      method: 'POST',
      headers: headers,
    ),
    data: data,
  );

  if (response.statusCode == 200) {
    if (response.data == null) {
      return null;
    } else {
      if (!(response.data['data'] == null)) {
        final data = response.data['data'];
        return data;
      }
      print(response.statusMessage);
    }
  }
}
