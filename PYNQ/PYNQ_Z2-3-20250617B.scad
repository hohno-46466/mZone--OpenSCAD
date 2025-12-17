//
// PYNQ-Z2 No.3
//
// PYNQ_Z2-3-20250617B.scad
//
// Prev update: 2025-06-11(Wed) 08:36 JST / 2025-05-10(Tue) 23:36 UTC
// Prev update: 2025-06-15(Sun) 06:20 JST / 2025-06-14(Sat) 21:20 UTC
// Prev update: 2025-06-16(Mon) 20:31 JST / 2025-06-16(Mon) 11:31 UTC
// Prev update: 2025-06-18(Wed) 03:50 JST / 2025-06-17(Tue) 18:50 UTC
// Prev update: 2025-12-17(Wed) 17:09 JST / 2025-12-17(Wed) 08:09 UTC   // text="PYNQ-Z2-3-20250617B-x__";
// Last update: 2025-12-18(Thu) 05:43 JST / 2025-12-17(Wed) 20:43 UTC

// Px = 215.0; Py = 147.0; Pz = 3.0;   // パネルの 横・縦・厚さ （P は "Panel" の P）
Px = 220.0; Py = 150.0; Pz0 = 0.3; Pz1 = 2.7;
Pz = Pz0 + Pz1;                     // パネルの 横・縦・厚さ （P は "Panel" の P）
Wing1 = 15.0; Wing2 = 20.0; Wing = Wing1 + Wing2;
R = 15.0;                           // 角丸の半径　
Cd = 8.0;  Cz = 10.0;               // 円柱の直径、位置、厚さ （Cは "Cylinder" の C）
H1d = 3.2; H2d = 2.8; H3d = H1d;    // 穴1,穴2,穴3 の直径 （H は "Hole" の H）
offsetX = 5.0; offsetY = 5.0;

tdepth = 2.0;                       // 文字を掘る深さ（mm）
text = "PYNQ-Z2-3-20250617B-x__";

// 穴1の位置リスト
hole1_pos = [
    [ offsetX + 5.0,         offsetY +  5.0 ],
    [ offsetX + 5.0,         offsetY +  5.0 + 79.0 ],
    [ offsetX + 5.0 + 129.0, offsetY +  5.0 ],
    [ offsetX + 5.0 + 129.0, offsetY +  5.0 + 79.0 ]
];

// 穴2の位置リスト
hole2_pos = [
  [ Px/2 + 12.7, Py/2 + 12.7 ],
  [ Px/2 + 12.7, Py/2 - 12.7 ],
  [ Px/2 - 12.7, Py/2 + 12.7 ],
  [ Px/2 - 12.7, Py/2 - 12.7 ]
];
  
// 穴3の位置リスト
hole3_pos = [
    [ Px - (offsetX + 5.0),   offsetY +  5.0],
    [ Px - (offsetX + 5.0),   Py - (offsetY +  5.0)],
    [ offsetX + 5.0,          Py - (offsetY +  5.0)]
];
  
difference() {
    // (1) まず、4本の円柱を持つ直方体のパネルを作る
    union() {
        #translate([0, -Wing1, 0]) cube([Px, Py+Wing, Pz0]);    // Wing
        // パネルを用意
        linear_extrude(height = Pz) // 厚みを3D方向に押し出して立体にする
            offset(r = R)           // 縮めた形を丸めながらRだけ戻す＝角丸になる
                offset(delta = -R)  // 四角形を内側にRだけ縮める
                    square([Px, Py], center = false);   // 元になる四角形
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
    
    // (3) パネルに穴2を貫通させる
    for (pos = hole2_pos) {
        x = pos[0]; y = pos[1];
        translate([x, y, -1.0]) cylinder(h = Pz + 2.0, d = H2d, $fn = 36);
        // 確実に穴をあけるため、パネル厚+円柱厚より2mm長い円柱をパネル底面より1mm沈めて配置
    }
    
    // (4) パネルに穴3を貫通させる
    for (pos = hole3_pos) {
        x = pos[0]; y = pos[1];
        translate([x, y, -1.0]) cylinder(h = Pz + 2.0, d = H3d, $fn = 36);
        // 確実に穴をあけるため、パネル厚+円柱厚より2mm長い円柱をパネル底面より1mm沈めて配置
    }
    
    // (5) テキストを掘る 
    translate([Px/2, Py/2, (Pz-tdepth)])
        // 文字の高さを tdepth + 1.0 に指定しているので、 プレート表面より 1.0 だけ飛び出す
        linear_extrude(height = tdepth + 1.0)
            text(text, size = 10, halign = "center", valign = "center");
}
