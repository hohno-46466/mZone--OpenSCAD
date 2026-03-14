//
// standoff-6x22(2.8)-2-20260301B.scad
//
// Cylinder with through hole
//

D_outer = 6.0; // 外径 (mm)
L       = 22;  // 長さ (mm)
D_hole  = 2.8; // 穴径 (mm)

$fn = 64;      // 円の滑らかさ

difference() {
    // 外側の円柱
    cylinder(d = D_outer, h = L);

    // 中心に貫通穴
    // 少し長めにして確実に貫通させる
    translate([0, 0, -1])
        cylinder(d = D_hole, h = L + 2);
}
