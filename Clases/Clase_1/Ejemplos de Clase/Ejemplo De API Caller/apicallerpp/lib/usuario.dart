class Usuario {
	final int id;
	final String email;
	final String firstName;
	final String lastName;
	final String avatarURL;

	Usuario({this.id, this.firstName, this.lastName, this.avatarURL, this.email});

	//Crear Usuario a partir de JSON
	factory Usuario.fromJson(Map<String, dynamic> json) {
		return Usuario(
			id: json['id'],
			firstName: json['first_name'],
			lastName: json['last_name'],
			email: json['email'],
			avatarURL: json['avatar']
		);
	}
}