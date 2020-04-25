class User {
  final String username;
  final String id;
  final String node_id;
  final String userimage;
  final String userhtmlurl;
  final String followerurl;
  final String followingurl;
  final String name;
  final String company;
  final String location;
  final String email;
  final String bio;
  final String created_at;
  final String updated_at;

  User(
      {this.username,
      this.id,
      this.node_id,
      this.userimage,
      this.userhtmlurl,
      this.followerurl,
      this.followingurl,
      this.bio,
      this.company,
      this.created_at,
      this.email,
      this.location,
      this.name,
      this.updated_at});
}
