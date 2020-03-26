/// results : [{"user":{"gender":"female","name":{"title":"mrs","first":"vera","last":"howell"},"location":{"street":"6015 beechcrest rd","city":"missoula","state":"kentucky","zip":"35204"},"email":"vera.howell33@example.com","username":"yellowladybug995","password":"tabatha","salt":"hRjTNnWj","md5":"2accdd57090839c35b785ca6dad6fec2","sha1":"815bc0e07b008bf8f07b32addbbc0d2fc14d7d6a","sha256":"3ea01874974ea376a1105cd10e17f678a0a6bc47fe0da6e4307809bce079f950","registered":"1369301751","dob":"77934839","phone":"(589)-279-2336","cell":"(449)-851-7699","SSN":"851-45-6154","picture":"http://api.randomuser.me/portraits/women/35.jpg"},"seed":"6e66041cd81bf972","version":"0.4"}]

class JSONUser {
	List<ResultsBean> results;
	
	static JSONUser fromMap(Map<String, dynamic> map) {
		if (map == null) return null;
		JSONUser networkBean = JSONUser();
		networkBean.results = List()
			..addAll(
					(map['results'] as List ?? []).map((o) =>
							ResultsBean.fromMap(o))
			);
		return networkBean;
	}
	
	Map toJson() =>
			{
				"results": results,
			};
}

/// user : {"gender":"female","name":{"title":"mrs","first":"vera","last":"howell"},"location":{"street":"6015 beechcrest rd","city":"missoula","state":"kentucky","zip":"35204"},"email":"vera.howell33@example.com","username":"yellowladybug995","password":"tabatha","salt":"hRjTNnWj","md5":"2accdd57090839c35b785ca6dad6fec2","sha1":"815bc0e07b008bf8f07b32addbbc0d2fc14d7d6a","sha256":"3ea01874974ea376a1105cd10e17f678a0a6bc47fe0da6e4307809bce079f950","registered":"1369301751","dob":"77934839","phone":"(589)-279-2336","cell":"(449)-851-7699","SSN":"851-45-6154","picture":"http://api.randomuser.me/portraits/women/35.jpg"}
/// seed : "6e66041cd81bf972"
/// version : "0.4"

class ResultsBean {
	UserBean user;
	String seed;
	String version;
	
	static ResultsBean fromMap(Map<String, dynamic> map) {
		if (map == null) return null;
		ResultsBean resultsBean = ResultsBean();
		resultsBean.user = UserBean.fromMap(map['user']);
		resultsBean.seed = map['seed'];
		resultsBean.version = map['version'];
		return resultsBean;
	}
	
	Map toJson() =>
			{
				"user": user,
				"seed": seed,
				"version": version,
			};
}

/// gender : "female"
/// name : {"title":"mrs","first":"vera","last":"howell"}
/// location : {"street":"6015 beechcrest rd","city":"missoula","state":"kentucky","zip":"35204"}
/// email : "vera.howell33@example.com"
/// username : "yellowladybug995"
/// password : "tabatha"
/// salt : "hRjTNnWj"
/// md5 : "2accdd57090839c35b785ca6dad6fec2"
/// sha1 : "815bc0e07b008bf8f07b32addbbc0d2fc14d7d6a"
/// sha256 : "3ea01874974ea376a1105cd10e17f678a0a6bc47fe0da6e4307809bce079f950"
/// registered : "1369301751"
/// dob : "77934839"
/// phone : "(589)-279-2336"
/// cell : "(449)-851-7699"
/// SSN : "851-45-6154"
/// picture : "http://api.randomuser.me/portraits/women/35.jpg"

class UserBean {
	String gender;
	NameBean name;
	LocationBean location;
	String email;
	String username;
	String password;
	String salt;
	String md5;
	String sha1;
	String sha256;
	String registered;
	String dob;
	String phone;
	String cell;
	String SSN;
	String picture;
	
	static UserBean fromMap(Map<String, dynamic> map) {
		if (map == null) return null;
		UserBean userBean = UserBean();
		userBean.gender = map['gender'];
		userBean.name = NameBean.fromMap(map['name']);
		userBean.location = LocationBean.fromMap(map['location']);
		userBean.email = map['email'];
		userBean.username = map['username'];
		userBean.password = map['password'];
		userBean.salt = map['salt'];
		userBean.md5 = map['md5'];
		userBean.sha1 = map['sha1'];
		userBean.sha256 = map['sha256'];
		userBean.registered = map['registered'];
		userBean.dob = map['dob'];
		userBean.phone = map['phone'];
		userBean.cell = map['cell'];
		userBean.SSN = map['SSN'];
		userBean.picture = map['picture'];
		return userBean;
	}
	
	Map toJson() =>
			{
				"gender": gender,
				"name": name,
				"location": location,
				"email": email,
				"username": username,
				"password": password,
				"salt": salt,
				"md5": md5,
				"sha1": sha1,
				"sha256": sha256,
				"registered": registered,
				"dob": dob,
				"phone": phone,
				"cell": cell,
				"SSN": SSN,
				"picture": picture,
			};
}

/// street : "6015 beechcrest rd"
/// city : "missoula"
/// state : "kentucky"
/// zip : "35204"

class LocationBean {
	String street;
	String city;
	String state;
	String zip;
	
	static LocationBean fromMap(Map<String, dynamic> map) {
		if (map == null) return null;
		LocationBean locationBean = LocationBean();
		locationBean.street = map['street'];
		locationBean.city = map['city'];
		locationBean.state = map['state'];
		locationBean.zip = map['zip'];
		return locationBean;
	}
	
	Map toJson() =>
			{
				"street": street,
				"city": city,
				"state": state,
				"zip": zip,
			};
}

/// title : "mrs"
/// first : "vera"
/// last : "howell"

class NameBean {
	String title;
	String first;
	String last;
	
	static NameBean fromMap(Map<String, dynamic> map) {
		if (map == null) return null;
		NameBean nameBean = NameBean();
		nameBean.title = map['title'];
		nameBean.first = map['first'];
		nameBean.last = map['last'];
		return nameBean;
	}
	
	Map toJson() =>
			{
				"title": title,
				"first": first,
				"last": last,
			};
}