//
// 秋月電子の C基板と同形状の板
//
// AkizukiPCB_TypeC-1-20250506A.scad
//
// Last update: 2025-05-26(Mon) 11:50 JST / 2025-05-26(Mon) 02:50 UTC
//

// パネルサイズと穴位置
Pw = 47.5; Ph = 72.0; Pz = 3;   // 縦・横・厚
Hd = 3.6;                       // 穴径。ちょっと大きめ
Hp = 3.0; // + Hd/2;            // 穴位置

// ベースパネルに  穴4つ（角から Hp だけ内側に）
difference() {
  cube([Pw, Ph, Pz]);
  for (x = [Hp, Pw - Hp])
    for (y = [Hp, Ph - Hp])
      translate([x, y, -1.0])
        cylinder(h = Pz + 2.0, d = Hd, $fn = 50);
}
