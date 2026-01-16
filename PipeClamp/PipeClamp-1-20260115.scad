
// PipeClamp-1-20260115.scad

// First version: 2026-01-15(Thu) 12:48 JST / 2026-01-15(Thu) 03:48 UTC
// Last update: 2026-01-15(Thu) 21:41 JST / 2026-01-15(Thu) 12:41 UTC

$fn = 128;

od = 40.0;          // Pipe Clamp の外径
len = 40.0;         // Pipe Clamp の高さ
t1 = 4.5;           // Pipe Clamp の肉厚
offset = 0.0;       // Pipe Clamp になる円柱をを半分に切り落とす際の微調整量

bw = 72.0;          // 板の幅
t2 = 4.0;           // 板の肉厚

tdepth = 2.0;                       // 文字を掘る深さ（mm）
text   = "PipeClamp-1-20260115";

hole_pos = [
  [ -25.0, 0,   0.0, 4.5 ],
  [ -30.0, 0,  12.5, 4.5 ],
  [ -30.0, 0, -12.5, 4.5 ],
  [  25.0, 0,   0.0, 4.5 ],
  [  30.0, 0,  12.5, 4.5 ],
  [  30.0, 0, -12.5, 4.5 ]
];

module main() {
    difference() {
        union() {
            difference() {
                #cylinder(d=od, h=len, center = true);                       // 円柱を作る
                translate([0, -(od/2+offset), -1.0]) cube([od, od, len+3.0], center=true);
                // ↑ 円柱の半分を切り落とすための立方体。切り落とし量は offset を使ってここで調整する
            }
            translate([0, t2/2-offset, 0]) cube([bw, t2, len], center=true);
            // 最終的に二つの「耳」になる側の立方体。こちらも offset の値を反映させる
            translate([0, od/2, 0]) cube([bw, t2, len], center=true);       // 半分の円柱の頂点側の立方体
        }
        translate([0, 0, -1]) cylinder(d=od-t1*2, h=len+3.0, center=true);  // 円柱の内側をくり抜く
        for (_pos = hole_pos) {                                             // ネジ穴をあける
            _x = _pos[0]; _y = _pos[1]; _z = _pos[2]; _d = _pos[3];
            translate([_x, _y, _z]) rotate([90, 0, 0]) #cylinder(d=_d, h=od+2*t2+2.0, center=true);
        }
        // テキストを掘る
        
        #translate([0, od/2-t2/2+1.0, -7.5])
          rotate([90, 0, 180])
            // 文字の高さを tdepth + 1.0 に指定しているので、 プレート表面より 1.0 だけ飛び出す
            linear_extrude(height = tdepth + 1.0)
                text(text, size = 4, halign = "center", valign = "center"); 
        
    }
}

main();