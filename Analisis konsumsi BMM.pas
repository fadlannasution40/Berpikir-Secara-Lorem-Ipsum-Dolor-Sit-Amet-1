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

function inputJam: integer;
var x: integer;
begin
  repeat
    write('Jam perjalanan (0-23): '); readln(x);
    if (x < 0) or (x > 23) then writeln('Jam harus antara 0 sampai 23!');
  until (x >= 0) and (x <= 23);
  inputJam := x;
end;

function inputJarak: real; var r: real; begin write('Jarak (km): '); readln(r); inputJarak := r; end;
function inputBahanBakar: real; var r: real; begin write('Bahan bakar (liter): '); readln(r); inputBahanBakar := r; end;

function analisisCC(cc: integer): string;
begin
  if cc < 150 then analisisCC := 'Tenaga rendah, sangat irit'
  else if cc < 1000 then analisisCC := 'Tenaga sedang, cukup irit'
  else if cc < 2000 then analisisCC := 'Tenaga menengah, konsumsi wajar'
  else if cc < 3000 then analisisCC := 'Tenaga besar, cenderung boros'
  else analisisCC := 'Tenaga sangat besar, boros BBM';
end;

function kategoriEfisiensi(kmpl: real): string;
begin
  if kmpl >= 15 then kategoriEfisiensi := 'Sangat Efisien'
  else if kmpl >= 10 then kategoriEfisiensi := 'Cukup Efisien'
  else kategoriEfisiensi := 'Boros';
end;

procedure inputData(var k: kendaraan);
const
  jenisList: array[0..1] of string = ('RODA 2','RODA 4');
  merekMotor: array[0..4] of string = ('HONDA','YAMAHA','SUZUKI','KAWASAKI','LAINNYA');
  merekMobil: array[0..5] of string = ('TOYOTA','HONDA','DAIHATSU','MITSUBISHI','SUZUKI','LAINNYA');
  bbmList: array[0..6] of string = (
    'PERTALITE','PERTAMAX','PERTAMAX TURBO',
    'SOLAR SUBSIDI','BIO SOLAR','DEXLITE','DEX'
  );
  bbmHarga: array[0..6] of integer = (
    10000,12500,14000,6800,7000,13000,14500
  );
var totalJam: real; idx: integer;
begin
  clrscr;
  writeln('--- INPUT DATA PERJALANAN ---');

  idx := swipeMenu('PILIH JENIS KENDARAAN', jenisList);
  k.jenisKendaraan := jenisList[idx];


  if k.jenisKendaraan = 'RODA 2' then
    idx := swipeMenu('PILIH MEREK RODA 2', merekMotor)
  else
    idx := swipeMenu('PILIH MEREK RODA 4', merekMobil);

  if ((k.jenisKendaraan='RODA 2') and (merekMotor[idx]='LAINNYA'))
     or ((k.jenisKendaraan='RODA 4') and (merekMobil[idx]='LAINNYA')) then
  begin
    write('Masukkan merek manual: '); readln(k.merek);
  end else begin
    if k.jenisKendaraan='RODA 2' then k.merek := merekMotor[idx]
    else k.merek := merekMobil[idx];
  end;

  k.ccMesin := inputCC;
  k.kategoriCC := analisisCC(k.ccMesin);

 
  idx := swipeMenuVertical('PILIH JENIS BBM', bbmList, bbmHarga);
  k.jenisBBM := bbmList[idx];
  k.harga := bbmHarga[idx];

  k.hari := inputHari;
  k.jam := inputJam;
  k.jarak := inputJarak;
  k.bahanBakar := inputBahanBakar;

  if k.bahanBakar > 0 then k.konsumsi := k.jarak / k.bahanBakar else k.konsumsi := 0;
  k.biaya := k.bahanBakar * k.harga;

  totalJam := (k.hari * 24) + k.jam;
  if k.bahanBakar > 0 then begin
    k.waktuPerLiterJam := totalJam / k.bahanBakar;
    k.waktuPerLiterMenit := k.waktuPerLiterJam * 60;
  end else begin
    k.waktuPerLiterJam := 0;
    k.waktuPerLiterMenit := 0;
  end;

  k.kategoriEfisiensi := kategoriEfisiensi(k.konsumsi);
end;

procedure tampilSemua;
begin
  clrscr;
  writeln('=== DAFTAR ANALISIS PERJALANAN ===');
  if n = 0 then begin writeln('Belum ada data.'); readln; exit; end;
  for i := 1 to n do begin
    with daftar[i] do begin
      writeln('Perjalanan ', i, ':');
      writeln('  Jenis kendaraan : ', jenisKendaraan);
      writeln('  Merek           : ', merek);
      writeln('  CC mesin        : ', ccMesin, ' cc');
      writeln('  Analisis CC     : ', kategoriCC);
      writeln('  Jenis BBM       : ', jenisBBM, ' (Rp', harga:0:0, '/liter)');
      writeln('  Lama perjalanan : ', hari, ' hari ', jam, ' jam');
      writeln('  Jarak           : ', jarak:0:2, ' km');
      writeln('  Bahan Bakar     : ', bahanBakar:0:2, ' liter');
      writeln('  Konsumsi        : ', konsumsi:0:2, ' km/liter');
      writeln('  Waktu per liter : ', waktuPerLiterJam:0:2, ' jam (', waktuPerLiterMenit:0:0, ' menit)');
      writeln('  Biaya           : Rp', biaya:0:0);
      writeln('  Efisiensi       : ', kategoriEfisiensi);
      writeln;
    end;
  end;
  writeln('Total data: ', n);
  writeln('Tekan ENTER untuk kembali...'); readln;
end;

procedure hapusData;
var idx: integer;
begin
  clrscr;
  if n = 0 then begin writeln('Belum ada data untuk dihapus.'); readln; exit; end;
  writeln('=== HAPUS DATA PERJALANAN ===');
  for i := 1 to n do
    writeln(i, '. ', daftar[i].jenisKendaraan, ' - ', daftar[i].merek,
            ' - ', daftar[i].jenisBBM, ' - Jarak: ', daftar[i].jarak:0:2, ' km');
  writeln;
  write('Masukkan nomor perjalanan yang ingin dihapus (1-', n, '): ');
  readln(idx);
  if (idx < 1) or (idx > n) then begin
    writeln('Nomor tidak valid! Tekan ENTER...'); readln; exit;
  end;
  if idx < n then
    Move(daftar[idx+1], daftar[idx], (n-idx)*SizeOf(kendaraan));
  dec(n);
  writeln('Data perjalanan ke-', idx, ' berhasil dihapus.');
  writeln('Tekan ENTER...'); readln;
end;

procedure tampilMenu(p: integer);
begin
  clrscr;
  writeln('=== MENU UTAMA ===');
  if p = 1 then writeln('> Input Data Kendaraan') else writeln('  Input Data Kendaraan');
  if p = 2 then writeln('> Tampilkan Semua Data') else writeln('  Tampilkan Semua Data');
  if p = 3 then writeln('> Hapus Data') else writeln('  Hapus Data');
  if p = 4 then writeln('> Keluar') else writeln('  Keluar');
end;

begin
  n := 0;
  pos := 1;
  repeat
    tampilMenu(pos);
    tombol := readkey;
    if tombol = #0 then begin
      tombol := readkey;
      case tombol of
        #75: if pos > 1 then dec(pos) else pos := 4; 
        #77: if pos < 4 then inc(pos) else pos := 1; 
      end;
    end else if tombol = #13 then begin
      case pos of
        1: begin
             if n < 20 then begin
               inc(n);
               inputData(daftar[n]);
               writeln('Analisis berhasil dicatat! Tekan ENTER...');
               readln;
             end else begin
               writeln('Data penuh (maks 20)! Tekan ENTER...');
               readln;
             end;
           end;
        2: tampilSemua;
        3: hapusData;
        4: begin
             clrscr;
             writeln('Terima kasih telah menggunakan sistem analisis bahan bakar.');
             halt(0);
           end;
      end;
    end;
  until false;
end.
