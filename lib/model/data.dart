import 'dart:convert';

Data rawDataFromJson(String str) => Data.fromJson(json.decode(str));

String rawDataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.lastDate,
    this.listData,
  });

  DateTime? lastDate;
  List<Provinsi>? listData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        lastDate: json["last_date"] == null
            ? null
            : DateTime.parse(json["last_date"]),
        listData: json["list_data"] == null
            ? null
            : List<Provinsi>.from(
                json["list_data"].map((x) => Provinsi.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "last_date": lastDate == null
            ? null
            : "${lastDate?.year.toString().padLeft(4, '0')}-${lastDate?.month.toString().padLeft(2, '0')}-${lastDate?.day.toString().padLeft(2, '0')}",
        "list_data": listData == null
            ? null
            : List<dynamic>.from(listData!.map((x) => x.toJson())),
      };
}

class Provinsi {
  Provinsi({
    this.key,
    this.docCount,
    this.status,
    this.penambahan,
  });

  String? key;
  int? docCount;
  Status? status;
  Penambahan? penambahan;

  factory Provinsi.fromJson(Map<String, dynamic> json) => Provinsi(
        key: json["key"] == null ? null : json["key"],
        docCount: json["doc_count"] == null ? null : json["doc_count"],
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        penambahan: json["penambahan"] == null
            ? null
            : Penambahan.fromJson(json["penambahan"]),
      );

  Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "doc_count": docCount == null ? null : docCount,
        "status": status == null ? null : status?.toJson(),
        "penambahan": penambahan == null ? null : penambahan?.toJson(),
      };
}

class Penambahan {
  Penambahan({
    this.positif,
    this.sembuh,
    this.meninggal,
  });

  int? positif;
  int? sembuh;
  int? meninggal;

  factory Penambahan.fromJson(Map<String, dynamic> json) => Penambahan(
        positif: json["positif"] == null ? null : json["positif"],
        sembuh: json["sembuh"] == null ? null : json["sembuh"],
        meninggal: json["meninggal"] == null ? null : json["meninggal"],
      );

  Map<String, dynamic> toJson() => {
        "positif": positif == null ? null : positif,
        "sembuh": sembuh == null ? null : sembuh,
        "meninggal": meninggal == null ? null : meninggal,
      };
}

class Status {
  Status({
    this.docCountErrorUpperBound,
    this.sumOtherDocCount,
    this.buckets,
  });

  int? docCountErrorUpperBound;
  int? sumOtherDocCount;
  List<Bucket>? buckets;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        docCountErrorUpperBound: json["doc_count_error_upper_bound"] == null
            ? null
            : json["doc_count_error_upper_bound"],
        sumOtherDocCount: json["sum_other_doc_count"] == null
            ? null
            : json["sum_other_doc_count"],
        buckets: json["buckets"] == null
            ? null
            : List<Bucket>.from(json["buckets"].map((x) => Bucket.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "doc_count_error_upper_bound":
            docCountErrorUpperBound == null ? null : docCountErrorUpperBound,
        "sum_other_doc_count":
            sumOtherDocCount == null ? null : sumOtherDocCount,
        "buckets": buckets == null
            ? null
            : List<dynamic>.from(buckets!.map((x) => x.toJson())),
      };
}

class Bucket {
  Bucket({
    this.key,
    this.docCount,
  });

  StatusKey? key;
  int? docCount;

  factory Bucket.fromJson(Map<String, dynamic> json) => Bucket(
        key: json["key"] == null ? null : keyValues.map![json["key"]],
        docCount: json["doc_count"] == null ? null : json["doc_count"],
      );

  Map<String, dynamic> toJson() => {
        "key": key == null ? null : keyValues.reverse[key],
        "doc_count": docCount == null ? null : docCount,
      };
}

enum StatusKey { SEMBUH, MENINGGAL, DALAM_PERAWATAN }

final keyValues = EnumValues({
  "DALAM PERAWATAN": StatusKey.DALAM_PERAWATAN,
  "MENINGGAL": StatusKey.MENINGGAL,
  "SEMBUH": StatusKey.SEMBUH
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}