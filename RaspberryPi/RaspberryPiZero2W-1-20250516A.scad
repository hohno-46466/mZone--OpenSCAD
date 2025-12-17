//
// Raspberry Pi Zero 2W
//
// RaspberryPiZero2W-1-20250516A.scad
//
// https://www.raspberrypi.com/documentation/computers/raspberry-pi.html
//
// Last update: 2025-05-16(Fri) 05:55 JST / 2025-05-15(Thu) 20:55 UTC
// Last update: 2025-05-25(Sun) 08:08 JST / 2025-05-24(Sat) 23:08 UTC
//

Px = 65.0; Py = -30.0; Pz = 3.0;    // パネルの 横・縦・厚さ （P は "Panel" の P）
Cd = 4.0;  Cz = 3.0;                // 円柱の直径、厚さ （Cは "Cylinder" の C）
H1d = 2.8; H2d = 2.8;               // 穴1,穴2の直径 （H は "Hole" の H）

// 穴1の位置リスト
hole1_pos = [
    [ 3.5,   -3.5 ],
    [ 3.5,  -26.5 ],
    [ 61.5,  -3.5 ],
    [ 61.5, -26.5 ]
];

// 穴2の位置リスト
hole2_pos = [
  [ Px/2 + 12.7, Py/2 ],
  [ Px/2 - 12.7, Py/2 ],
];



difference() {
    // (1) まず、4本の円柱を持つ直方体のパネルを作る
    union() {
        // パネルを用意
        // cube([Px, -Py, Pz]); // 第1章限で造形する場合
        translate([0, Py, 0]) cube([Px, -Py, Pz]);  // 第4象限で造形する場合
        // 円柱を4本立てる
        for (pos = hole1_pos) {
            x = pos[0]; y = pos[1];
            translate([x, y, Pz]) cylinder(h = Cz, d = Cd, $fn = 36);
        }
    }
    // (2) 次に、それぞれの円柱に穴1を貫通させる
    for (pos = hole1_pos) {
        x = pos[0]; y = pos[1];
        translate([x, y, -1.0]) cylinder(h = Pz + Cz + 2.0, d = H1d, $fn = 36);
        // 確実に穴をあけるため、パネル厚+円柱厚より2mm長い円柱をパネル底面より1mm沈めて配置
    }
    // (3) 最後に、パネルに穴2を貫通させる
    for (pos = hole2_pos) {
        x = pos[0]; y = pos[1];
        translate([x, y, -1.0]) cylinder(h = Pz + 2.0, d = H2d, $fn = 36);
        // 確実に穴をあけるため、パネル厚+円柱厚より2mm長い円柱をパネル底面より1mm沈めて配置
    }
}
