program AnalisisBahanBakar;
uses crt;
type
 Kendaraan = record
 jenisKendaraan : string;
 merek : string;
 ccmesin : integer;
 jenisBBM : string;
 hari : integer;
 jam : integer;
 bahanbakar: real;
 harga : real;
 konsumsi : real;
 biaya : real;
 waktuperliterjam : real;
 waktuperlitermenit: real;
 kategoriCC : string;
 kategoriEfesiensi: string;
 end;

 var
 daftar : array[1..20] of kendaraan;
 n,i : integer;
 ulang : char;

function inputJenisKendaraan : string;
var
pilihan:integer;
begin
repeat
clrscr;
writeln('pilih jenis kendaraan anda : ');
writeln('1. Roda 2(motor)');
writeln('2. Roda 4(mobil)');
write('pilihan (1-2) :');
readln(pilihan);
case pilihan of 
1 := inputjeniskendaraan := 'Roda 2';
2 := inputjeniskendaraan := 'Roda 4';
else
begin
writeln('pilihan tidak ada Tekan Enter Untuk Ulangin...');
readln;
continue;
end;
break;
until false;
end;

function inputmerek(jenis: string) string:
var 
pilihan : integer;
begin
repeat
clrscr;
writeln( 'Pilih Merek Kendaraan Anda', jenis, ':');
if jenis = 'Roda 2' then
begin
writeln('1.Honda');
writeln('2.Yamaha');
writeln('3.Suzuki');
writeln('4.Kawasaki');
writeln('5.isiSendiri');
end;
else
begin
writeln('1.Honda');
writeln('2.Toyota');
writeln('3.Daihatsu');
writeln('4.Mistubishi');
writeln('5.Suzuki');
writeln('5.isiSendiri');
end;
write('pilihan : ');
readln(pilihan);

if jenis = ' Roda 2 ' then
case pilihan of
1 : InputMerek := 'Honda';
2 : InputMerek := 'Yamaha';
3 : InputMerek := 'Suzuki';
4 : InputMerek := 'Kawasaki';
5: begin write('Masukkan merek: '); readln(inputMerek); end;
      else begin writeln('Pilihan tidak valid! Tekan ENTER untuk ulangi...'); readln; continue; end;
      end
else
      case pilihan of
        1: inputMerek := 'Honda';
        2: inputMerek := 'Toyota';
        3: inputMerek := 'Daihatsu';
        4: inputMerek := 'Mitsubishi';
        5: inputMerek := 'Suzuki';
        6: begin write('Masukkan merek: '); readln(inputMerek); end;
      else begin writeln('Pilihan tidak valid! Tekan ENTER untuk ulangi...'); readln; continue; end;
      end;
    break;
function inputCC: integer;
var cc: integer;
begin
  repeat
    write('Masukkan kapasitas mesin (cc): '); readln(cc);
    if cc <= 0 then begin writeln('CC harus lebih dari 0! ENTER untuk ulangi...'); readln; end
    else break;
  until false;
  inputCC := cc;
end;

function analisisCC(cc: integer): string;
begin
  if cc < 150 then analisisCC := 'Tenaga rendah, sangat irit'
  else if cc < 1000 then analisisCC := 'Tenaga sedang, cukup irit'
  else if cc < 2000 then analisisCC := 'Tenaga menengah, konsumsi wajar'
  else if cc < 3000 then analisisCC := 'Tenaga besar, cenderung boros'
  else analisisCC := 'Tenaga sangat besar, boros BBM';
end;

function inputBBM(var harga: real): string;
var pilihan: integer;
begin
  repeat
    clrscr;
    writeln('Pilih jenis BBM Pertamina:');
    writeln('1. Pertalite       (Rp 10.000/liter)');
    writeln('2. Pertamax        (Rp 12.500/liter)');
    writeln('3. Pertamax Turbo  (Rp 14.000/liter)');
    writeln('4. Solar Subsidi   (Rp 6.800/liter)');
    writeln('5. Bio Solar       (Rp 7.000/liter)');
    writeln('6. Dexlite         (Rp 13.000/liter)');
    writeln('7. Pertamina Dex   (Rp 14.500/liter)');
    write('Pilihan (1-7): '); readln(pilihan);

    case pilihan of
      1: begin inputBBM := 'Pertalite';       harga := 10000; end;
      2: begin inputBBM := 'Pertamax';        harga := 12500; end;
      3: begin inputBBM := 'Pertamax Turbo';  harga := 14000; end;
      4: begin inputBBM := 'Solar Subsidi';   harga := 6800;  end;
      5: begin inputBBM := 'Bio Solar';       harga := 7000;  end;
      6: begin inputBBM := 'Dexlite';         harga := 13000; end;
      7: begin inputBBM := 'Pertamina Dex';   harga := 14500; end;
    else begin writeln('Pilihan tidak valid! ENTER untuk ulangi...'); readln; continue; end;
    end;
    break;
  until false;
end;

function inputHari: integer;
var h: integer;
begin
  repeat
    write('Masukkan berapa hari perjalanan ditempuh : '); readln(h);
    if h < 0 then begin writeln('Hari tidak boleh negatif! ENTER untuk ulangi...'); readln; end
    else break;
  until false;
  inputHari := h;
end;

function inputJam: integer;
var j: integer;
begin
  repeat
    write('Masukkan berapa jam perjalanan ditempuh : '); readln(j);
    if (j < 0) or (j > 23) then begin writeln('Jam harus 0-23! ENTER untuk ulangi...'); readln; end
    else break;
  until false;
  inputJam := j;
end;

function inputJarak: real;
var j: real;
begin
  repeat
    write('Masukkan jarak tempuh (km) : '); readln(j);
    if j <= 0 then begin writeln('Jarak harus > 0! ENTER untuk ulangi...'); readln; end
    else break;
  until false;
  inputJarak := j;
end;

function inputBahanBakar: real;
var b: real;
begin
  repeat
    write('Masukkan bahan bakar terpakai (liter) : '); readln(b);
    if b <= 0 then begin writeln('Bahan bakar harus > 0! ENTER untuk ulangi...'); readln; end
    else break;
  until false;
  inputBahanBakar := b;
end;

function kategoriEfisiensi(kmpl: real): string;
begin
  if kmpl >= 15 then kategoriEfisiensi := 'Sangat Efisien'
  else if kmpl >= 10 then kategoriEfisiensi := 'Cukup Efisien'
  else kategoriEfisiensi := 'Boros';
end;

procedure inputData(var k: kendaraan);
var totalJam: real;
begin
  clrscr;
  writeln('--- INPUT DATA PERJALANAN ---');
  k.jenisKendaraan := inputJenisKendaraan;
  k.merek := inputMerek(k.jenisKendaraan);
  k.ccMesin := inputCC;
  k.kategoriCC := analisisCC(k.ccMesin);
  k.jenisBBM := inputBBM(k.harga);
  k.hari := inputHari;
  k.jam := inputJam;
  k.jarak := inputJarak;
  k.bahanBakar := inputBahanBakar;

  k.konsumsi := k.jarak / k.bahanBakar;
  k.biaya := k.bahanBakar * k.harga;

  totalJam := (k.hari * 24) + k.jam;
  k.waktuPerLiterJam := totalJam / k.bahanBakar;
  k.waktuPerLiterMenit := k.waktuPerLiterJam * 60;


  k.kategoriEfisiensi := kategoriEfisiensi(k.konsumsi);
end;

