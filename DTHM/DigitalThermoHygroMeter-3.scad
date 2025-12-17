// Type 3

// DigitalThermoHygroMeter-3.scad

// Prev update: 2025-11-25(Tue) 07:26 JST / 2025-11-24(Mon) 22:26 UTC
// Prev update: 2025-12-02(Tue) 19:29 JST / 2025-12-02(Tue) 10:29 UTC (311) // tilt_angle=45
// Prev update: 2025-12-02(Tue) 20:20 JST / 2025-12-02(Tue) 11:20 UTC (331) // tilt_angle=30
// Prev update: 2025-12-02(Tue) 20:27 JST / 2025-12-02(Tue) 11:27 UTC (351) // tilt_angle=15
// Last update: 2025-12-09(Tue) 21:35 JST / 2025-12-09(Tue) 12:35 UTC (371) // tilt_angle=0; z3=120
// Last update: 2025-12-18(Thu) 05:52 JST / 2025-12-17(Wed) 20:52 UTC

$fn = 100;

// 穴あき板の大きさ
x1 = 80.0;  // 板の幅 ← Type2 から 60 → 80 に変更
y1 = 60.0;  // 板の奥行き
z1 = 3.0;   // 板の高さ

// 穴あき板の穴の大きさ
r2 = 21.0;  // 穴の半径
z2 = z1;    // 穴の高さ

// ブロック1の大きさ
x3 = z1;    // ブロック1 の幅
y3 = y1;    // ブロック1 の奥行き
z3 = 120.0; // ブロック1 の高さ

tdepth = 2.0;       // 文字を掘る深さ（mm）
tilt_angle = 0;     // side_block1 を内側へ傾ける角度（度）
text = "371-_";     // Type=3, Version=7(tilt_angle=0), Release=1 // 刻印が 377 になっている造形物もある

// 穴あき板
module plate_with_hole() {
    translate([0, 0, z1/2])     // z1/2 だけ浮上させ、plate の底面が z=0 にする
    difference() {
        cube([x1, y1, z1], center=true);
        cylinder(r=r2, h=z2 + 1, center=true);
    }
}

// 穴あき板を支えるブロック（板）
module side_block1() {
    // ブロック中心位置
    block_x = x1/2 + x3/2;
    block_z = z1   + z3/2;

    // side_block1 の「内側の面」は、plate_with_hole の「上面」のヘリ（最も右側）と接している。
    // その接線の X座標 （ここから文字を掘り始めるイメージ）
    inner_x = x1/2;

    // 文字の中心高さ（ブロック中心あるいはそれより少し下げてみる例）
    text_z = block_z; // - 0.6;

    // 「x = x1/2, z = 0」の線を回転軸にするイメージで変換
    translate([x1/2, 0, 0])             // 回転軸を原点に持ってくる
    rotate([0, -tilt_angle, 0])         // Y軸まわりにマイナス方向へ回転 → 原点側へ倒れる
    translate([-x1/2, 0, 0])            // 座標系を元に戻す（ここから先を全部まとめて変換）
    union() {
        // (1) ブロック本体 − 文字を削る
        difference() {
            // 元のブロック（右側に配置）※ block_x/block_z に揃える
            translate([block_x, 0, block_z])
                cube([x3, y3, z3], center=true);

            // X の小さい側（内側の面）から X 正方向へ「text」を彫る
            translate([inner_x - 0.5, 0, text_z])  // text を X軸に沿って inner_x (= x1/2) より 0.5 だけ左に寄せる
                rotate([-90, 0, 0])     // 縦向き
                    rotate([0, 90, 0])  // XY → YZ 面へ
                        #linear_extrude(height = tdepth + 0.5)  // 上で text を 0.5 だけ左に寄せたので、ここで text の厚さを 0.5だけ長く（厚く）する
            
                            mirror([1, 0, 0])   // 左右反転して正しい向きに
                            text(text, size = 9, halign = "center", valign = "center");
        };

        // (2) 溝を埋める「横倒し円柱」を追加（ブロックと union される）
        fillet_r   = x3;       // 円柱の半径（plate_with_hole や side_block1 の厚さと同じ）
        fillet_len = y3 + 0;   // y3 と同じ長さ（必要なら +2 等で延長）

        // 円柱の中心線は、上記の plate_with_hole と side_block1 の「接線」と一致させる
        #translate([inner_x, 0, fillet_r])
            // cylinder は Z 軸方向に伸びるので、X 軸まわりに 90度回転させて Y 軸向きにする
            rotate([90, 0, 0])
                cylinder(r = fillet_r, h = fillet_len, center = true);
        };
        
}

// Type3 では side_block2 は一旦使わないのでコメントアウト
module side_block2() {
    translate([-x1/2, 0, z3/2])
        cube([x3, y3, z3], center=true);
}

// -----------------------------------------------------------------------------

//
// main operations
//
// 3Dプリンタの事情で造形物を回転し side_block1 を印刷面に合わせる
rotate([0, tilt_angle + 90, 0])      // Y軸方向に回転
translate([-x1/2, 0, 0])             // 回転軸を設定
union() {       // plate_with_hole と side_block1 を融合させる
    plate_with_hole();
    side_block1();
    // side_block2();       // Type3 では ブロック2 は未使用
}

// -----------------------------------------------------------------------------
