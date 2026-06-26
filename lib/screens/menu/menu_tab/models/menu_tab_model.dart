class MenuTabModel {
  final String title;
  final List<MenuTabItemModel> items;

  MenuTabModel({
    required this.title,
    required this.items,
  });
}

class MenuTabItemModel {
  final MenuTabItemType type;
  final bool isSvg;
  bool? value;

  MenuTabItemModel({
    required this.type,
    this.isSvg = true,
    this.value,
  });
}

enum MenuTabItemType {
  employeeCard(title: 'Ажилтны карт', icon: 'employee_card.svg'),
  giftCard(title: 'Gift card', icon: 'gift_card.svg'),
  pointHistory(title: 'Онооны түүх', icon: 'coin.svg'),
  buyHistory(title: 'Худалдан авалтын түүх', icon: 'recipe.svg'),
  myFinance(title: 'Миний санхүү', icon: 'chart.svg'),
  pinChange(title: 'Гүйлгээний нууц үг солих', icon: 'key.svg'),
  biometric(title: 'Биометр тохиргоо', icon: 'face.svg'),
  notification(title: 'Мэдэгдэл хүлээн авах', icon: 'notification.svg'),
  ebarimt(title: 'E barimt - холбох', icon: 'ebarimt.png'),
  contact(title: 'Холбоо барих', icon: 'phone.svg'),
  faq(title: 'Түгээмэл асуулт хариулт', icon: 'question.svg'),
  branch(title: 'Салбарын байршил', icon: 'map.svg'),
  terms(title: 'Үйлчилгээний нөхцөл', icon: 'task.svg'),
  policy(title: 'Нууцлалын бодлого', icon: 'privacy.svg');

  const MenuTabItemType({
    required this.title,
    required this.icon,
  });
  final String title;
  final String icon;
}
