//
// DPM #01 (Digital Pane Meter No.1)
//
// DPM-1-20250522A.scad
//
// Prev update: 2025-05-22(Thu) 02:00 JST / 2025-05-21(Wed) 17:00 UTC
// Prev update: 2025-05-22(Thu) 23:15 JST / 2025-05-22(Thu) 14:15 UTC
// Prev update: 2025-05-25(Sun) 08:08 JST / 2025-05-24(Sat) 23:08 UTC
// Last update: 2025-12-18(Thu) 05:17 JST / 2025-12-17(Wed) 20:17 UTC    // text="DPM-1-20250522A-x__";

Px = 150.0; Py = 60.0; Pz = 3.0;    // パネルの 横・縦・厚さ （P は "Panel" の P）
Hd = 3.2;   Hp = 10.0;              // ネジ穴の直径、位置 （H は "Hole" の H）
Sx = 46.0;  Sy = 26.0;              // 角穴の横・縦 (S は "Square" の S)

tdepth = 2.0;                       // 文字を掘る深さ（mm）
text = "DPM-1-20250522A-x__";

// ネジ穴の位置リスト
hole1_pos = [
  [ Hp,       Hp      ],
  [ Px - Hp,  Hp      ],
  [ Hp,       Py - Hp ],
  [ Px - Hp,  Py - Hp ]
];

// 角穴の位置リスト
square_pos = [
  [ Sx, Sy, Px/2-Sx/2-5.0, Py/2 ],
  [ Sx, Sy, Px/2+Sx/2+5.0, Py/2 ]
];

difference() {
    // (1) まず、直方体のパネルを作る
    cube([Px, Py, Pz]);  // 第1章限で造形する場合
    
    // (2) 次に、パネルの四隅に穴1を貫通させる
    for (pos = hole1_pos) {
        x = pos[0]; y = pos[1];
        translate([x, y, -1.0]) cylinder(h = Pz + 2.0, d = Hd, $fn = 36);
        // 確実にネジ穴をあけるため、パネル厚より2mm長い円柱をパネル底面より1mm沈めて配置
    }
    
    // (3) 最後に、パネルに穴2を貫通させる
    w = 0; h = 0; x = 0; y = 0; z = Pz;
    for (pos = square_pos) {
        w = pos[0]; h = pos[1]; x = pos[2]; y = pos[3]; z = Pz;
        translate([x, y, z/2]) cube([w, h, z + 2.0], center = true);
        // 確実に角穴をあけるため、パネル厚より2mm長い直方体をパネル底面より1mm沈めて配置
        // 補足：cube を center=true で生成しているので、 z方向の長さを 2.0 長くすると、
        // z方向の中心から上下方向に 1.0 ずつ伸びることに注意
    }
    
    // （4） テキストを掘る
    translate([Px/2, Py*0.1, (Pz-tdepth)])
        // 文字の高さを tdepth + 1.0 に指定しているので、 プレート表面より 1.0 だけ飛び出す
        linear_extrude(height = tdepth + 1.0)
            text(text, size = 5, halign = "center", valign = "center");
}
