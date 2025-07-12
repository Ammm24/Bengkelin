
import '../config/endpoint.dart';
import '../config/model/resp.dart';
import '../config/network.dart';

class ServiceViewmodel {

  Future<Resp> kecamatan() async {
    var resp = await Network.getApi(
        Endpoint.kecamatanUrl);
    Resp data = Resp.fromJson(resp);
    return data;
  }

  Future<Resp> kelurahan({kecamatanId}) async {
    var resp = await Network.getApi(
        "${Endpoint.kelurahanUrl}/$kecamatanId");
    Resp data = Resp.fromJson(resp);
    return data;
  }
}