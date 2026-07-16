//
// CylinderBaseWithCenterTube-1-20260426A.scad
//
// Cylinder base with center tube
//
// First version: 2026-04-27(Mon) 02:37 JST / 2026-04-26(Sun) 17:37 UTC 
// Last update: 2026-04-27(Mon) 06:34 JST / 2026-04-26(Sun) 21:34 UTC
//

D_base  = 93.0;  // 底面円柱の直径
H_base  = 3.0;   // 底面円柱の高さ

// D_outer = 63.0;  // 中央円柱の外径
// H_outer = 60.0;  // 中央円柱の高さ
D_outer = 64.5;  // 中央円柱の外径
H_outer = 80.0;  // 中央円柱の高さ

D_hole  = 60.0;  // 中心穴の直径

EPS = 1.0;       // 安全マージン
$fn = 128;       // 円の滑らかさ

difference() {
    union() {
        // 底面円柱
        cylinder(d = D_base, h = H_base);

        // 中央に立つ円柱
        cylinder(d = D_outer, h = H_outer);
    }

    // 中心の貫通穴
    translate([0, 0, -EPS])
        cylinder(d = D_hole, h = H_outer + 2*EPS);
}