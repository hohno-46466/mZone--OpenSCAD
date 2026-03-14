//
// standoff-5x22(2.0)-2-20260301A.scad
//
// Cylinder with through hole
//

D_outer = 5.0; // 外径 (mm)
L       = 22;  // 長さ (mm)
D_hole  = 2.0; // 穴径 (mm)

$fn = 64;      // 円の滑らかさ

difference() {
    // 外側の円柱
    cylinder(d = D_outer, h = L);

    // 中心に貫通穴
    // 少し長めにして確実に貫通させる
    translate([0, 0, -1])
        cylinder(d = D_hole, h = L + 2);
}
