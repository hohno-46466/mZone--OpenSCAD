//
// 秋月電子の C基板と同形状の板
//
// AkizukiPCB_TypeC-4-20260103A.scad (AEPCB_C-4-20260103A)
//
// https://akizukidenshi.com/goodsaffix/p3231_ryoumen_c.pdf （C基板）
// https://akizukidenshi.com/goodsaffix/LPMxxxT2-C_rev1.pdf （C基板用アクリルパネル）
//
// Last update: 2026-01-03(Sat) 06:47 JST / 2026-01-02(Fri) 21:47 UTC
//

Px = 47.5; Py = 72.0; Pz = 3.0;     // 通常の「C基板」に合わせる場合の 横・縦・厚さ （P は "Panel" の P）
// Px = 51.0; Py = 76.0; Pz = 3.0;  // 「C基板用アクリルパネル』にあわせる場合
Cd = 6.0;  Cz = 3.0;                // 円柱の直径、位置、厚さ （Cは "Cylinder" の C）
H1d = 3.2; H1p = 3.0; // H1p = 5.0; // 穴1の直径、位置（オフセット） （H は "Hole" の H）
H2d = 2.8;                          // 穴2の直径

tdepth = 2.0;                       // 文字を掘る深さ（mm）
text   = "AEPCB_C-4-20260103A";

// ネジ穴1の位置リスト
hole1_pos = [
  [ H1p,       H1p      ],
  [ Px - H1p,  H1p      ],
  [ H1p,       Py - H1p ],
  [ Px - H1p,  Py - H1p ]
];

// ネジ穴2の位置リスト
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
        cube([Px, Py, Pz]);  // 第1章限で造形する場合
        // translate([0, Py, 0]) cube([Px, -Py, Pz]); // 第4象限で造形する場合
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
    // （4） テキストを掘る
    translate([Px/2, Py/2, (Pz-tdepth)])
      rotate([0, 0, 90])
        // 文字の高さを tdepth + 1.0 に指定しているので、 プレート表面より 1.0 だけ飛び出す
        #linear_extrude(height = tdepth + 1.0)
            text(text, size = 4, halign = "center", valign = "center");
}
