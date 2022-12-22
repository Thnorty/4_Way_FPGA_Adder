`timescale 1ns / 1ps

module bil265_proje_top(
input clk,
input rst_n,
input btnl_i,
input btnu_i,
input btnr_i,
input btnd_i,
input rx_i,

output reg tx_o = 1
);

reg [4:0] durum = 5'd0; // 0: bekliyor, 1: veri aliniyor, 2: veri yaziliyor, 3: veri okunuyor, 4: hata
reg [8:0] bitSayisi = 0;
reg [151:0] okunanVeri = 152'b0;
reg [127:0] sayilar = 127'b0;
reg [7:0] checksumTemp = 0;
wire [63:0] rca, cla, csa, ppa;
reg [63:0] sonuc;
reg [1:0] islem;
reg btnl_i_old, btnu_i_old, btnr_i_old, btnd_i_old;
reg check = 0;

// Kodun okunur olmaini saglamak icin kullanilan localparam'lar
localparam WRITE = 16'hBACD;
localparam REVERSEWRITE = 16'hCDBA;
localparam READ = 16'hBAFD;
localparam REVERSEREAD = 16'hFDBA;
localparam ERROR = 16'hBAEE;
localparam REVERSEERROR = 16'hEEBA;
localparam RCA = 2'b00;
localparam CLA = 2'b01;
localparam CSA = 2'b10;
localparam PPA = 2'b11;

// Toplayicilar
ripple_carry_adder(sayilar[127:64], sayilar[63:0], rca);
carry_lookahead_adder(sayilar[127:64], sayilar[63:0], cla);
carry_save_adder(sayilar[127:64], sayilar[63:0], csa);
parallel_prefix_adder(sayilar[127:64], sayilar[63:0], ppa);

reg [13:0] sayac = 0;

// Clock vurusu geldiginde
always @(posedge clk) begin

    // Eger resetlemek gerekiyorsa
    if (rst_n == 0) begin
        sayac = 0;
        durum = 0;
        bitSayisi = 0;
        okunanVeri = 0;
        sayilar = 0;
        islem = 0;
        checksumTemp = 0;
        btnl_i_old = 0;
        btnu_i_old = 0;
        btnr_i_old = 0;
        btnd_i_old = 0;
        check = 0;
    end

    // Clock vurusu geldiyse ve resetlemek gerekmiyorsa
    else begin

        // Bir sayac tutuyoruz ve bu sayacin 10415'e gelmesini bekliyoruz
        // 10415 olmasinin sebebi ise baud rate'i 9600 yapmak istememiz ve 100Mhz/9600 = 10415
        // Yani saniyede 9600 bit alip gonderiyoruz 
        sayac = sayac+1;
        if (sayac >= 10415) begin
            sayac = 0;

            // Eger bir tus basiliysa ve bir onceki durumda o tus basili degilse o tusun islemi yapilacak ve bilgisayara veri gonderme durumuna gecilecek
            
            // Soldaki buton basili (RCA islemi)
            if (btnl_i == 1 && btnl_i_old == 0) begin
                durum = 2;
                islem = RCA;
                bitSayisi = 0;
            end
            btnl_i_old = btnl_i;

            // Yukaridaki buton basili (CLA islemi)
            if (btnu_i == 1 && btnu_i_old == 0) begin
                durum = 2;
                islem = CLA;
                bitSayisi = 0;
            end
            
            // Sagdaki buton basili (CSA islemi)
            btnu_i_old = btnu_i;
            if (btnr_i == 1 && btnr_i_old == 0) begin
                durum = 2;
                islem = CSA;
                bitSayisi = 0;
            end

            // Asagidaki buton basili (PPA islemi)
            btnr_i_old = btnr_i;
            if (btnd_i == 1 && btnd_i_old == 0) begin
                durum = 2;
                islem = PPA;
                bitSayisi = 0;
            end
            btnd_i_old = btnd_i;

            // Veri almayi bekleme durumu
            if (durum == 0) begin
                // Veri gelmeye basladiysa veri almayi baslat
                if (rx_i == 0) begin
                    durum = 1;
                end
            end

            // Veriyi fpga'e gonder
            else if (durum == 1) begin
                // Okunan verileri sirasiyla okunanVeri degiskenine kaydet
                okunanVeri[bitSayisi] = rx_i;
                bitSayisi = bitSayisi+1;
                // Eger 152 bit okunduysa
                if (bitSayisi == 152) begin
                    bitSayisi = 0;
                    // Gelen verinin ilk 16 biti READ ise
                    if (okunanVeri[15:0] == REVERSEWRITE) begin
                        // Gelen verinin son 8 biti checksum ile eslesiyorsa 
                        if (okunanVeri[151:144] == (WRITE + {okunanVeri[23:16],okunanVeri[31:24],okunanVeri[39:32],okunanVeri[47:40],okunanVeri[55:48],okunanVeri[63:56],okunanVeri[71:64],okunanVeri[79:72]} + {okunanVeri[87:80],okunanVeri[95:88],okunanVeri[103:96],okunanVeri[111:104],okunanVeri[119:112],okunanVeri[127:120],okunanVeri[135:128],okunanVeri[143:136]})%256)
                            // Veriyi sayilar'a kaydet
                            sayilar = {okunanVeri[23:16],okunanVeri[31:24],okunanVeri[39:32],okunanVeri[47:40],okunanVeri[55:48],okunanVeri[63:56],okunanVeri[71:64],okunanVeri[79:72],okunanVeri[87:80],okunanVeri[95:88],okunanVeri[103:96],okunanVeri[111:104],okunanVeri[119:112],okunanVeri[127:120],okunanVeri[135:128],okunanVeri[143:136]};

                        // Gelen verinin son 8 biti checksum ile eslesmiyorsa
                        else
                            durum = 4;
                    end
                end
                // Eger 1 byte okunduysa durum 0'a don ve veri almayi beklemeye devam et
                else if (bitSayisi%8 == 0 && bitSayisi != 0 && check == 0) begin
                    durum = 0;
                    check = 1;
                end
                check = 0;
            end

            // Veriyi bilgisayara gonder
            else if (durum == 2) begin
                // Buraya ilk gelisimizse tx_o'yu 0 yap ki verinin baslangic bitini gonderelim
                if (bitSayisi == 0) begin
                    tx_o = 0;
                    bitSayisi = bitSayisi+1;
                end
                // Ilk gelisimiz degilse 
                else begin
                    // Eger 88 bit gonderildiyse
                    if (bitSayisi == 89) begin
                        tx_o = 1;
                        durum = 0;
                        bitSayisi = 0;
                    end
                    // Eger 1 byte gonderildiyse tx_o'yu 1 yap ki verinin bitis bitini gonderelim ve durum 3'e gec ki sonraki veri gonderisimizde balangic bitini gonderelim
                    else if ((bitSayisi-1) % 8 == 0 && bitSayisi != 1 && check == 0) begin
                        tx_o = 1;
                        durum = 3;
                        check = 1;
                    end
                    // Eger baslangic veya bitis biti gondermeyeceksek
                    else begin
                        // Basta READ basligini gonder
                        if (bitSayisi < 17) begin
                            tx_o = REVERSEREAD[bitSayisi-1];
                        end
                        // Sonra secilen isleme gore sonucu gonder
                        else if (bitSayisi < 81) begin
                            if (islem == RCA)
                                sonuc = {rca[7:0],rca[15:8],rca[23:16],rca[31:24],rca[39:32],rca[47:40],rca[55:48],rca[63:56]};
                            else if (islem == CLA)
                                sonuc = {cla[7:0],cla[15:8],cla[23:16],cla[31:24],cla[39:32],cla[47:40],cla[55:48],cla[63:56]};
                            else if (islem == CSA)
                                sonuc = {csa[7:0],csa[15:8],csa[23:16],csa[31:24],csa[39:32],csa[47:40],csa[55:48],csa[63:56]};
                            else if (islem == PPA)
                                sonuc = {ppa[7:0],ppa[15:8],ppa[23:16],ppa[31:24],ppa[39:32],ppa[47:40],ppa[55:48],ppa[63:56]};
                            tx_o = sonuc[bitSayisi-17];
                        end
                        // Ondan sonra checksum'i gonder
                        else begin
                            checksumTemp = (READ + sonuc)%256;
                            tx_o = checksumTemp[bitSayisi-81];
                        end
                        bitSayisi = bitSayisi+1;
                        check = 0;
                    end
                end
            end

            // 1 byte vermeye tekrar baslamak icin tx pinine 0 ver ve tekrar veri gonderme kısmına gec 
            else if (durum == 3) begin
                tx_o = 0;
                durum = 2;
            end

            // Hata durumunu bilgisayara ilet
            else if (durum == 4) begin
                // Buraya ilk gelisimizse tx_o'yu 0 yap ki verinin baslangic bitini gonderelim
                if (bitSayisi == 0) begin
                    tx_o = 0;
                    bitSayisi = bitSayisi+1;
                end
                // Ilk gelisimiz degilse
                else begin
                    // Eger 24 bit gonderildiyse
                    if (bitSayisi == 25) begin
                        tx_o = 1;
                        durum = 0;
                        bitSayisi = 0;
                    end
                    // Eger 1 byte gonderildiyse tx_o'yu 1 yap ki verinin bitis bitini gonderelim ve durum 5'e gec ki sonraki veri gonderisimizde balangic bitini gonderelim
                    else if ((bitSayisi-1) % 8 == 0 && bitSayisi != 1 && check == 0) begin
                        tx_o = 1;
                        durum = 5;
                        check = 1;
                    end
                    // Eger baslangic veya bitis biti gondermeyeceksek
                    else begin
                        // Basta ERROR basligini gonder
                        if (bitSayisi < 17)
                            tx_o = REVERSEERROR[bitSayisi-1];
                        // Sonra hata kodunu gonder
                        else begin
                            checksumTemp = ERROR%256;
                            tx_o = checksumTemp[bitSayisi-17];
                        end 
                        bitSayisi = bitSayisi+1;
                        check = 0;
                    end
                end
            end
            
            // 8 bit vermeye tekrar baslamak icin tx pinine 0 ver ve tekrar hata gonderme kismina gec 
            else if (durum == 5) begin
                tx_o = 0;
                durum = 4;
            end
        end
    end
end


endmodule
