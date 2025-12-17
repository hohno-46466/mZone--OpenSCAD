// Type 4

// DigitalThermoHygroMeter-4.scad

// First version: 2025-11-27(Thu) 08:07 JST / 2025-11-26(Wed) 23:07 UTC
// Prev update:   2025-11-28(Fri) 00:49 JST / 2025-11-27(Thu) 15:49 UTC (4x1)
// Prev update:   2025-11-29(Sat) 21:40 JST / 2025-11-29(Sat) 12:40 UTC (4x2)
// Prev update:   2025-11-30(Sun) 11:31 JST / 2025-11-30(Sun) 02:31 UTC (4x3)
// Prev update:   2025-11-30(Sun) 14:57 JST / 2025-11-30(Sun) 05:57 UTC (4x4)
// Last update:   2025-12-02(Tue) 19:42 JST / 2025-12-02(Tue) 10:42 UTC (431) // z1=60.0
// Last update:   2025-12-02(Tue) 20:44 JST / 2025-12-02(Tue) 11:44 UTC (411) // z1=30.0

$fn = 100;

x0=80.0; y0=60.0; z0=3.0; r0=21.0;
x1=z0;   y1=y0;   z1=30.0; //z1=60.0; //30.0; //20.0; //40.0;
x2=20.0; y2=y0;   z2=z0;
x3=z0;   y3=y0;   z3=15.0; //15.0; //15.0; //20.0;

tdepth = 2.0;   // 文字を掘る深さ（mm）
text="411-_";   //"431-_"; //"4x3"; //"4x2"; //"4x1";

// 穴あき板
module plate_with_hole() {
    translate([0, 0, z0/2])
        difference() {
            cube([x0, y0, z0], center=true);
            #cylinder(r=r0, h=z0 + 2, center=true);
        }
}


//module side_block1() {
//    translate([x0/2, 0, z2/2])      // x方向に x0/2 だけ平行移動
//        cube([x2, y2, z2], center=true);
//}

module side_block1() {
// side_block1：Xの大きい側の側面（Y-Z 面）に「01」を彫る

    difference() {
        // 元のブロック
        translate([x0/2 + x1/2, 0, z1/2 + z0])
            cube([x1, y1, z1], center=true);

        // 文字でくり抜く
        translate([x0/2 + x1 - tdepth, 0, z0 + z1/2]) // 側面の少し内側
            // ★ここで 90度回転を追加（X軸まわり）
            rotate([90, 0, 0])         // Y-Z 平面内で 90度回転
                rotate([0, 90, 0])     // XY -> YZ 面へ
                    #linear_extrude(height = tdepth + 0.5) // 文字の厚みを 0.5 だけ伸ばしておく
                        text(text, size   = 10, halign = "center", valign = "center");                    
    }
}


module side_block2() {
    translate([x0/2 - x2/2, 0, z0 + z1 + z2/2])
        cube([x2, y2, z2], center=true);
}

module side_block3() {
    translate([-x0/2 - x3/2, 0, z0 + z3/2])
        cube([x3, y3, z3], center=true);
}

module cylinder1() {
    #translate([x0/2, 0, z0])
        rotate([90, 0, 0])
        cylinder(h = y0, r = z0, center = true);
}

module cylinder2() {
    #translate([x0/2, 0, z0 + z1])
        rotate([90, 0, 0])
        cylinder(h = y0, r = z0, center = true);
}

module cylinder3() {
    #translate([-x0/2, 0, z0])
        rotate([90, 0, 0])
        cylinder(h = y0, r = z0, center = true);
}

// rotate([0, 90, 0])   // Y軸方向に回転
// translate([-x0/2, 0, -z0/2])          // 回転軸を設定
union() {
    plate_with_hole();
    side_block1();
    side_block2();
    side_block3();
    cylinder1();
    cylinder2();
    cylinder3();
}