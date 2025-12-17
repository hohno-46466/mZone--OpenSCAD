//
// Raspberry Pi ４B
//
// RaspberryPi4B-2-20251123C.scad
//
// https://www.raspberrypi.com/documentation/computers/raspberry-pi.html
//
// First version: 2025-11-23(Sun) 07:24 JST / 2025-11-22(Sat) 22:24 UTC
// Last update: 2025-12-17(Wed) 14:27 JST / 2025-12-17(Wed) 05:27 UTC   // text = "AK-RS-02/07_2__";
//

Px = 85.0; Py = -56.0; Pz = 3.0;    // パネルの 横・縦・厚さ （P は "Panel" の P）
Cd = 4.2;  Cz = 6.0;                // 円柱の直径、厚さ （Cは "Cylinder" の C）
H1d = 2.8; H2d = 2.8;               // 穴1（円柱）, 穴2(DIN) の直径 （H は "Hole" の H）

tdepth = 2.0;                       // 文字を掘る深さ（mm）
text = "AK-RS-02/07_2__";

// 穴1の位置リスト
hole1_pos = [
    [ 3.4,   -3.4 ],
    [ 3.4,  -52.6 ],
    [ 61.6,  -3.4 ],
    [ 61.6, -52.6 ]
];

// 穴2の位置リスト
hole2_pos = [
  [ Px/2 + 12.7, Py/2 + 12.7 ],
  [ Px/2 + 12.7, Py/2 - 12.7 ],
  [ Px/2 - 12.7, Py/2 + 12.7 ],
  [ Px/2 - 12.7, Py/2 - 12.7 ],
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

    // (4) テキストを掘る 
    translate([Px/2, Py/2, (Pz-tdepth)])
        // 文字の高さを tdepth + 0.5 に指定しているので、 プレート表面より 0.5 だけ飛び出す
        linear_extrude(height = tdepth + 0.5)
            text(text, size = 6, halign = "center", valign = "center");
            // center = true を指定していないので、 XY平面上に z=0 を基準に造形 ← これあってる？
}
