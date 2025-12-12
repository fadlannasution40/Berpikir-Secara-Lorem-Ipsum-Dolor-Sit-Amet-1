program AnalisisBahanBakar;
uses crt, SysUtils;
type
  kendaraan = record
    jenisKendaraan : string;
    merek          : string;
    ccMesin        : integer;
    jenisBBM       : string;
    hari           : integer;
    jam            : integer;
    jarak          : real;
    bahanBakar     : real;
    harga          : real;
    konsumsi       : real;
    biaya          : real;
    waktuPerLiterJam   : real;
    waktuPerLiterMenit : real;
    kategoriCC     : string;
    kategoriEfisiensi  : string;
  end;

 var
  daftar : array[1..20] of kendaraan;
  n, i, pos: integer;
  tombol: char;


function swipeMenu(title: string; options: array of string): integer;
var p, max: integer; k: char;
begin
  p := 0; max := High(options);
  repeat
    clrscr;
    writeln('=== ', title, ' ===');
    writeln;
    writeln('< ', options[p], ' >');
    writeln;
    writeln('Gunakan panah kiri/kanan lalu ENTER');
    k := readkey;
    if k = #0 then begin
      k := readkey;
      case k of
        #75: if p > 0 then dec(p) else p := max;    
        #77: if p < max then inc(p) else p := 0;    
      end;
    end else if k = #13 then begin
      swipeMenu := p;
      exit;
    end;
  until false;
end;

function swipeMenuVertical(title: string; options: array of string; prices: array of integer): integer;
var p, max, i: integer; k: char;
begin
  p := 0; max := High(options);
  repeat
    clrscr;
    writeln('=== ', title, ' ===');
    writeln;
    for i := 0 to max do
    begin
      if i = p then
        writeln('> ', options[i], ' (Rp', prices[i], '/liter)')
      else
        writeln('  ', options[i], ' (Rp', prices[i], '/liter)');
    end;
    writeln;
    writeln('Gunakan panah atas/bawah lalu ENTER');
    k := readkey;
    if k = #0 then begin
      k := readkey;
      case k of
        #72: if p > 0 then dec(p) else p := max;   
        #80: if p < max then inc(p) else p := 0;   
      end;
    end else if k = #13 then begin
      swipeMenuVertical := p;
      exit;
    end;
  until false;
end;

function inputCC: integer; var x: integer; begin write('CC mesin: '); readln(x); inputCC := x; end;

function inputHari: integer;
var x: integer;
begin
  repeat
    write('Hari perjalanan (>=0): '); readln(x);
    if x < 0 then writeln('Tidak boleh negatif!');
  until x >= 0;
  inputHari := x;
end;
