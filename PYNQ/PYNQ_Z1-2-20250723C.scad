//
// PYNQ-Z1 No.2
//
// PYNQ_Z1-2-20250723C.scad
//
// First version: 2025-07-18(Fri) 15:00 JST / 2025-07-18(Fri) 06:00 UTC
// Prev update: 2025-07-20(Sun) 14:35 JST / 2025-07-20(Sun) 05:35 UTC // xx=4.8
// Prev update: 2025-07-21(Mon) 18:36 JST / 2025-07-21(Mon) 09:36 UTC // xx=2.0
// Prev update: 2025-07-22(Tue) 20:18 JST / 2025-07-22(Tue) 11:18 UTC // xx=4.0;H1d=3.4
// Prev update: 2025-07-23(Wed) 12:55 JST / 2025-07-23(Wed) 03:55 UTC // xx=3.0;H1d=3.4;yy=3.0;
// Prev update: 2025-07-24(Thu) 03:53 JST / 2025-07-23(Wed) 18:53 UTC // xx=2.0;H1d=3.4;yy=3.0;
// Prev update: 2025-12-17(Wed) 17:20 JST / 2025-12-17(Wed) 08:20 UTC // text="PYNQ-Z1-2-20250723C-x__";
// Last update: 2025-12-18(Thu) 05:46 JST / 2025-12-17(Wed) 20:46 UTC

Px = 220.0; Py = 150.0; Pz = 3.0;   // パネルの 横・縦・厚さ （P は "Panel" の P）
R = 15.0;                           // 角丸の半径　
Cd = 8.0;  Ch = 15.0;               // 円柱の直径、長さ （Cは "Cylinder" の C）
H1d = 3.4; H2d = 2.8; H3d = H1d;    // 穴1,穴2,穴3 の直径 （H は "Hole" の H）
offset1X = 5.0; offset1Y = 5.0;
offset2X = 5.0; offset2Y = 5.0;
offsetX = offset1X + offset2X; offsetY = offset1X + offset2X;
Z1x = 122.0; Z1y = 87.0; Z1h = 4.0; // PYNQ-Z1 の縦(Z1y) 横(Z1x) と設置高 (Z1h)
xx = 2.0; // 2.0; // xx = (Cd - H1d);
yy = 3.0;

tdepth = 2.0;                       // 文字を掘る深さ（mm）
text = "PYNQ-Z1-2-20250723C-x__";

// 穴1の位置リスト（円柱付の穴）
hole1_pos = [
    // 追加した短い円柱 （2個, 高さ Z1h（=4.0mm））
    [ offsetX + Cd,             offsetY + Z1y/2,        Z1h ],
    [ offsetX + Z1x + xx - 6.0, offsetY + Z1y/2 + 14.0, Z1h ],
    // もとからあった長い円柱 (4個, 高さ Ch（=15.0mm）)
    [ offsetX,             offsetY,              Ch ],
    [ offsetX,             offsetY + Z1y + yy,   Ch ],
    [ offsetX + Z1x + xx,  offsetY,              Ch ],
    [ offsetX + Z1x + xx,  offsetY + Z1y + yy,   Ch ]
];

// 穴2の位置リスト（DINレール取付治具用）
hole2_pos = [
  [ Px/2 + 12.7, Py/2 + 12.7 ],
  [ Px/2 + 12.7, Py/2 - 12.7 ],
  [ Px/2 - 12.7, Py/2 + 12.7 ],
  [ Px/2 - 12.7, Py/2 - 12.7 ]
];
  
// 穴3の位置リスト（左上、右上、右下の穴）
hole3_pos = [
    [ Px - offsetX, offsetY],
    [ Px - offsetX, Py - offsetY],
    [ offsetX,      Py - offsetY]
];
  
difference() {
    // (1) まず、4本の円柱を持つ直方体のパネルを作る
    union() {
        // パネルを用意
        linear_extrude(height = Pz) // 厚みを3D方向に押し出して立体にする
            offset(r = R)           // 縮めた形を丸めながらRだけ戻す＝角丸になる
                offset(delta = -R)  // 四角形を内側にRだけ縮める
                    square([Px, Py], center = false);   // 元になる四角形
        // 円柱を長短あわせて6本立てる
        for (pos = hole1_pos) {
            x = pos[0]; y = pos[1]; z = pos[2];
            translate([x, y, Pz]) cylinder(h = z, d = Cd, $fn = 36);
        }
        *translate([offsetX, offsetY, Z1h + Pz]) cube([Z1x + xx, Z1y + yy , 4.0]);
    }
    
    // (2) 次に、それぞれの円柱に穴1を貫通させる
    for (pos = hole1_pos) {
        x = pos[0]; y = pos[1];
        translate([x, y, -1.0]) cylinder(h = Pz + Ch + 2.0, d = H1d, $fn = 36);
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
    
    // (5) 長い円柱（計4本）の途中に穴をあける（高さ 3.0mm（直打ち））
    translate([offsetX, offsetY, Z1h + Pz]) cube([Z1x + xx, Z1y + yy, 3.0]);
    
    // (6) テキストを掘る 
    translate([Px/2, Py/2, (Pz-tdepth)])
        // 文字の高さを tdepth + 1.0 に指定しているので、 プレート表面より 1.0 だけ飛び出す
        linear_extrude(height = tdepth + 1.0)
            text(text, size = 10, halign = "center", valign = "center");
}
