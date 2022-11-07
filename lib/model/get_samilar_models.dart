import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class GetSamilar {
  late List<List<dynamic>> data;
  late Map<String, dynamic> samilar;
  late List<dynamic> recommend;

  GetSamilar({
    required this.data,
    required this.samilar,
    required this.recommend,
  });

  loadAssets() async {
    final myData = await rootBundle
        .loadString('assets/corr_attraction - corr_attraction.csv');
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(myData);
    data = csvTable;
  }

  get_samilar(String attraction, double rating) {
    for (var i = 1; i <= 24; i++) {
      if (data[0][i] == attraction) {
        for (var j = 1; j <= 24; j++) {
          double similar_score = data[j][i] * (rating - 2.5);
          samilar.putIfAbsent(data[j][0], () => similar_score);
        }
      }
    }
  }

  get_attraction(Map<String, dynamic> samilaritie) {
    var temp1 = 0.0;
    List<dynamic> temp = [];
    List<dynamic> max = [];
    samilaritie.forEach((key, value) {
      if (value > 0.55 && value < 2.5) {
        temp.add([key, value]);
      }
    });
    for (var i = 0; i < temp.length; i++) {
      if (temp[i][1] > temp1) {
        temp1 = temp[i][1];
        recommend.insert(0, temp[i][0]);
      } else {
        recommend.add(temp[i][0]);
      }
    }
  }
}
