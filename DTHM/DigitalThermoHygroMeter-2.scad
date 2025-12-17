// Type 2

// DigitalThermoHygroMeter-2.scad

// Last update: 2025-11-27(Thu) 08:13 JST / 2025-11-26(Wed) 23:13 UTC
// Prev update: 2025-12-01(Mon) 21:28 JST / 2025-12-01(Mon) 12:28 UTC (231) // z3=25.0;
// Last update: 2025-12-02(Tue) 18:57 JST / 2025-12-02(Tue) 09:57 UTC (211) // z3=20.0;
$fn = 100;

x1=80.0; y1=75.0; z1=3.0;
r2=21.0; z2=3.0;
x3=3.0;  y3=y1; z3=20.0; // z3=25.0;

tdepth = 2.0;    // 文字を掘る深さ（mm）
text="211-_";

// 穴あき板
module plate_with_hole() {
    translate([0, 0, z1/2])
    difference() {
        cube([x1, y1, z1], center=true);
        cylinder(r=r2, h=z2 + 1, center=true);
    }
}


//module side_block1() {
//    translate([x1/2, 0, z3/2])      // x方向に x1/2 だけ平行移動
//        cube([x3, y3, z3], center=true);
//}

// side_block1：Xの大きい側の側面（Y-Z 面）に文字を彫る
module side_block1() {
    difference() {
        // 元のブロック
        translate([x1/2 + x3/2, 0, z3/2 + z1])
            cube([x3, y3, z3], center=true);

        // 文字でくり抜く
        #translate([x1/2 + x3 - tdepth, 0, z3/2 + z1])  // 側面の外側から tdepth だけ沈める
            // 文字の高さを tdepth + 0.5 に指定しているので、 side_block1 より 0.5 だけ飛び出す
            rotate([-90, 0, 0])         // YZ 平面内で 90度回転
                rotate([0, 90, 0])      // XY -> YZ 面へ
                    #linear_extrude(height = tdepth + 0.5)
                        text(text, size = 10, halign = "center", valign = "center");
                        // center = true を指定していないので、 XY平面上に z=0 を基準に造形
    }
}

module side_block2() {
    translate([-x1/2 - x3/2, 0, z3/2 + z1])      // x方向に -x1/2 だけ平行移動
        cube([x3, y3, z3], center=true);
}


module cylinder1() {
    #translate([x1/2, 0, z1])
        rotate([90, 0, 0])
        cylinder(h = y1, r = z1, center = true);
}

module cylinder2() {
    #translate([-x1/2, 0, z1])
        rotate([90, 0, 0])
        cylinder(h = y1, r = z1, center = true);
}

union() {
    plate_with_hole();
    side_block1();
    side_block2();
    #cylinder1();
    #cylinder2();
}
