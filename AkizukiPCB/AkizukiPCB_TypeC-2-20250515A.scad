//
// 秋月電子の C基板と同形状の板
//
// AkizukiPCB_TypeC-2-20250515A.scad
//
// Last update: 2025-05-25(Sun) 08:08 JST / 2025-05-24(Sat) 23:08 UTC
// Last update: 2025-05-26(Mon) 11:50 JST / 2025-05-26(Mon) 02:50 UTC
//

Px = 47.5; Py = 72.0; Pz = 3.0; // パネルの 横・縦・厚さ（P は "Panel" の P）
Cd = 5.0;  Cz = 3.0;            // 円柱の直径、厚さ（Cは "Cylinder" の C）
Hd = 3.2;  Hp = 3.0;            // 穴の直径、位置（H は "Hole" の H）

difference() {
    // (1) まず、4本の円柱を持つ直方体のパネルを作る
    union() {
        // パネルを用意
        cube([Px, Py, Pz]);
        // 円柱を4本立てる
        for (x = [Hp, Px - Hp
            ])
            for (y = [Hp, Py - Hp])
                translate([x, y, Pz]) cylinder(h = Cz, d = Cd, $fn = 36);
    }
    // (2) 次に、それぞれの円柱に穴を貫通させる
    for (x = [Hp, Px - Hp])
        for (y = [Hp, Py - Hp])
            translate([x, y, -1.0]) cylinder(h = Pz + Cz + 2.0, d = Hd, $fn = 36);
            // 確実に穴をあけるため、パネル厚+円柱厚より2mm長い円柱をパネル底面より1mm沈めて配置している
}

