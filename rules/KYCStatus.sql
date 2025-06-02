-- Saham Biasa
DELIMITER $$


CREATE TRIGGER trg_check_kyc_before_order
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    DECLARE v_kyc_status ENUM('verified', 'unverified');


    -- Ambil status KYC pengguna dari tabel users berdasarkan NIK pada order baru
    SELECT kyc_status INTO v_kyc_status
    FROM users
    WHERE nik = NEW.nik;


    -- Jika status KYC bukan 'verified', tolak transaksi
    IF v_kyc_status != 'verified' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaksi gagal: Status KYC pengguna belum terverifikasi. Silakan verifikasi KYC Anda terlebih dahulu.';
    END IF;
END$$


DELIMITER ;


-- Saham IPO
DELIMITER $$


CREATE TRIGGER trg_check_kyc_before_order_ipo
BEFORE INSERT ON order_ipo
FOR EACH ROW
BEGIN
    DECLARE v_kyc_status ENUM('verified', 'unverified');


    -- Ambil status KYC pengguna dari tabel users berdasarkan NIK pada order IPO baru
    SELECT kyc_status INTO v_kyc_status
    FROM users
    WHERE nik = NEW.nik;


    -- Jika status KYC bukan 'verified', tolak pesanan IPO
    IF v_kyc_status != 'verified' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pemesanan IPO gagal: Status KYC pengguna belum terverifikasi. Silakan verifikasi KYC Anda terlebih dahulu.';
    END IF;
END$$


DELIMITER ;
