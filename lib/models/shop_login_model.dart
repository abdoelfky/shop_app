class ShopLoginModel
{
  bool status;
  String message;
  UserData data;
  ShopLoginModel.fromJson(Map<String,dynamic> json)
  {
    status=json['status'];
    message=json['message'];
    data=json['data']!=null ? UserData.fromJson(json['data']):null;
    }

}

class UserData
{
  int id;
  String name;
  String email;
  String image;
  String phone;
  int points;
  int credit;
  String token;

  //UserData({
  //this.email,
  //this.id,
  //this.image,
  //this.name,
  //this.phone,
  //this.credit,
  //this.points,
//this.token,
//});

  //named Constructor
  UserData.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    email=json['email'];
    name=json['name'];
    image=json['image'];
    phone=json['phone'];
    credit=json['credit'];
    points=json['points'];
    token=json['token'];
  }


}