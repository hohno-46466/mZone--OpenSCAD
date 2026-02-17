//
// USBカメラ用固定板
//
// USBcameraBaseplate-1-20260210A.scad
//
// Last update: 2026-02-10(Tue) 07:54 JST / 2026-02-09(Mon) 22:54 UTC
//

// パネルサイズと穴位置
Px = 120.0; Py = 120.0; Pz = 3.0;   // 縦・横・厚
Hd = 105.0  ;                       // 穴径。ちょっと大きめ


// ベースパネルに  穴4つ（角から Hp だけ内側に）
difference() {
  cube([Px, Py, Pz]);
      translate([Px/2, Py/2, -1.0])
        cylinder(h = Pz + 2.0, d = Hd, $fn = 50);
}
