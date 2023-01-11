

class Place {
	String? name;
	String? desc;
	List<Coordinate>? coordinates;

	Place({ required this.name,  required this.desc, required this.coordinates});

	 Place.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		desc = json['desc'];
		// coordinates=json['desc'];
		// return Place(name: name, desc: desc, coordinates: coordinates);
		coordinates = <Coordinate>[];
		if (json['coordinates'] != null) {
			json['coordinates'].forEach((v) { coordinates?.add(Coordinate.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['desc'] = this.desc;
		// if (this.coordinates != null) {
    //   data['coordinates'] = this.coordinates.map((v) => v.toJson()).toList();
    // }
		return data;
	}
}

class Coordinate {
String? lat;
String? long;

	Coordinate({required this.lat, required this.long});

	 Coordinate.fromJson(List liste) {
		lat = liste[0].toString() ;
		long = liste[1].toString();
	}

	List toList() {

		return [lat,long];
	}
}
