class UserDetails {
  final String username;
  final String id;
  final String userimage;
  final String userhtmlurl;
  final String name;
  final String company;
  final String location;
  final String email;
  final String bio;
  final String created_at;
  final String updated_at;
  final String follwers;
  final String following;
  final String public_repos;
  final String public_gists;
  UserDetails(
      {this.username,
      this.public_gists,
      this.public_repos,
      this.name,
      this.updated_at,
      this.id,
      this.userimage,
      this.userhtmlurl,
      this.bio,
      this.company,
      this.created_at,
      this.email,
      this.location,
      this.following,
      this.follwers});
}
