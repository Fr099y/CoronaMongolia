import 'package:http/http.dart';

class RestAPI {
  Client client = Client();

  static const BASE_URL =
      "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/ncov_cases/FeatureServer/1/query?f=json&where=Confirmed%20%3E%200&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&orderByFields=Confirmed%20desc,Country_Region%20asc,Province_State%20asc&resultOffset=0&resultRecordCount=250&cacheHint=true&fbclid=IwAR2V2KE9KgVqEcbrJG-Vbd-4bzn33EZwhYw6zuZepmu0A9Swvz0JP9I7OSk";

  Future<dynamic> getGlobalStatistics() async {
    Response mainResponse = await client.get(BASE_URL);
    return mainResponse?.body ?? null;
  }
}
