//
// APM #01 (Analog Panel Meter No.1)
//
// APM-1-20251217A.scad
//
// First version 2025-12-17(Wed) 20:41 JST / 2025-12-17(Wed) 11:41 UTC  // text="APM-1-20251218A-x__";
// Last update:  2025-12-18(Thu) 13:17 JST / 2025-12-18(Thu) 04:17 UTC
//

$fn = 100;

Px = 150.0; Py = 60.0; Pz = 4.0;    // パネル の横・縦・厚さ （P は "Panel" の P）
H1d = 3.2;  H1p = 10.0;             // ネジ穴1 の直径、位置 （H は "Hole" の H）
H2d = 3.2;                          // ネジ穴2 の直径
Cd = 45.0;                          // パネルメータ（丸穴, Cylinder）の直径

tdepth = 2.0;                       // 文字を掘る深さ（mm）
text1 = "APM-1-";
text2 = "20251218A-x__";

// ネジ穴1 の位置と穴径のリスト
hole1_pos = [
  [ H1p,      H1p,      H1d ],
  [ Px - H1p, H1p,      H1d ],
  [ H1p,      Py - H1p, H1d ],
  [ Px - H1p, Py - H1p, H1d ]
];

// ネジ穴2 の APM中央からのオフセットと穴径のリスト
hole2_pos = [
  [ -19.0, -19.0,  H2d ],
  [  19.0, -19.0,  H2d ],
  [ -19.0,  19.0,  H2d ],
  [  19.0,  19.0,  H2d ],
];

// パネルメータの丸穴の位置と穴径のリスト
cylinder_pos = [
    [ Px * 0.72, Py / 2, Cd],
    [ Px * 0.28, Py / 2, Cd]
];

difference() {
    // (1) まず、直方体のパネルを作る
    cube([Px, Py, Pz]);  // 第1章限で造形する場合
 
    // (2) 次に、パネルの四隅に穴1を貫通させるための円柱を配置
    for (pos = hole1_pos) {
        x1 = pos[0]; y1 = pos[1]; d1 = pos[2];
        translate([x1, y1, -1.0]) cylinder(h = Pz + 2.0, d = d1);
        // 確実にネジ穴をあけるため、パネル厚より2mm長い円柱をパネル底面より1mm沈めて配置（他の穴も同じ）
    }

    // (3) さらに，アナログメータ本体の丸穴と固定用ネジの穴（穴2）をあけるための円柱を配置
    for (pos = cylinder_pos) {
        x1 = pos[0]; y1 = pos[1]; d1 = pos[2];
        translate([x1, y1, -1.0]) cylinder(h = Pz + 2.0, d = d1);
        
        for (pos2 = hole2_pos) {
            x2 = pos2[0]; y2 = pos2[1]; d2 = pos2[2];
            translate([x1 + x2, y1 + y2, -1.0]) cylinder(h = Pz + 2.0, d = d2);
        } 
    }
    
    // (4） 文字を掘る（2行）
    // 文字の高さを tdepth + 1.0 に指定し、 プレート表面より 1.0 だけ飛び出すように配置
    translate([Px/2 - 3.5, Py/2, (Pz - tdepth)])
        linear_extrude(height = tdepth + 1.0)
            rotate([0, 0, 90])
                text(text1, size = 5, halign = "center", valign = "center");
    translate([Px/2 + 3.5, Py/2, (Pz - tdepth)])
        linear_extrude(height = tdepth + 1.0)
            rotate([0, 0, 90])
                text(text2, size = 5, halign = "center", valign = "center");
}

