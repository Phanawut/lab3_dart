void main() {
  print('--- 🛒 ระบบจัดการร้านขายของชำ (OOP Demo) ---');

  // 1. สร้างสินค้าทั่วไป
  var rice = Product('ข้าวหอมมะลิ', 150.0, 10);
  rice.displayInfo();

  // 2. ทดสอบการใช้ Setter และตรวจสอบเงื่อนไข (Validation)
  print('\n--- ทดสอบการแก้ไขข้อมูลผ่าน Setter ---');
  rice.price = 160.0; // เปลี่ยนราคาได้
  rice.price = -50.0; // จะขึ้น Error เพราะเราดักไว้ใน Setter
  rice.displayInfo();

  print('\n--- สินค้าสืบทอด (Inheritance) ---');
  // 3. สร้างสินค้าลดราคา (Inheritance)
  var milk = DiscountProduct('นมสด', 45.0, 20, 5.0);
  milk.displayInfo();
  
  // 4. แสดงการดึงค่าผ่าน Getter
  print('\nเช็คสต็อกสินค้า: ${milk.name} เหลืออยู่ ${milk.quantity} ชิ้น');
}

// --- 1. Class แม่ (Base Class) ---
class Product {
  // 2. ซ่อนข้อมูลด้วย Private (_) 
  // หมายเหตุ: ใน Dart '_' จะทำงานเป็น Private ระดับ Library (ไฟล์เดียวกัน)
  String _name;
  double _price;
  int _quantity;

  Product(this._name, this._price, this._quantity);

  // 3. Getter/Setter
  String get name => _name;
  
  double get price => _price;
  set price(double value) {
    if (value > 0) {
      _price = value;
    } else {
      print('⚠️ คำเตือน: ราคาของ "$_name" ต้องมากกว่า 0 (ระบบจะไม่เปลี่ยนราคา)');
    }
  }

  int get quantity => _quantity;
  set quantity(int value) => _quantity = value;

  void displayInfo() {
    print('สินค้า: $_name | ราคา: $_price บาท | ในคลัง: $_quantity');
  }
}

// --- 4. การใช้ Inheritance (สืบทอด) ---
class DiscountProduct extends Product {
  double _discountAmount;

  // ใช้ super เพื่อส่งค่าไปยัง Constructor ของ Product
  DiscountProduct(String name, double price, int quantity, this._discountAmount)
      : super(name, price, quantity);

  // Getter สำหรับคำนวณราคาสุทธิ
  double get finalPrice => price - _discountAmount;

  // การ Override เมธอดเพื่อแสดงผลเฉพาะของสินค้าลดราคา
  @override
  void displayInfo() {
    print('สินค้าลดราคา: $name');
    print('- ราคาปกติ: $price บาท');
    print('- ส่วนลด: $_discountAmount บาท');
    print('- ** ราคาสุทธิ: $finalPrice บาท ** (คงเหลือ $quantity ชิ้น)');
  }
}