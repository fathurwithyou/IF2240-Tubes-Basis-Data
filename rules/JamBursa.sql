DELIMITER $$


CREATE TRIGGER trg_before_insert_check_market_hours_transactions
BEFORE INSERT ON transactions
FOR EACH ROW
BEGIN
    DECLARE execution_day_of_week INT; -- Minggu=1, Senin=2, ..., Sabtu=7
    DECLARE execution_time_val TIME;
    DECLARE is_market_open BOOLEAN DEFAULT FALSE;
    DECLARE error_message VARCHAR(255);


    -- Ambil hari dan waktu dari kolom waktu_eksekusi pada data BARU yang akan dimasukkan
    -- DAYOFWEEK(date): 1 = Minggu, 2 = Senin, ..., 7 = Sabtu
    SET execution_day_of_week = DAYOFWEEK(NEW.waktu_eksekusi);
    SET execution_time_val = TIME(NEW.waktu_eksekusi);


    -- Cek untuk hari Senin - Kamis (DAYOFWEEK: 2 sampai 5)
    IF execution_day_of_week >= 2 AND execution_day_of_week <= 5 THEN
        IF (execution_time_val >= '09:00:00' AND execution_time_val < '12:00:00') OR -- Sesi 1
           (execution_time_val >= '13:30:00' AND execution_time_val <= '16:00:00') THEN -- Sesi 2
            SET is_market_open = TRUE;
        END IF;
    -- Cek untuk hari Jumat (DAYOFWEEK: 6)
    ELSEIF execution_day_of_week = 6 THEN
        IF (execution_time_val >= '09:00:00' AND execution_time_val < '11:30:00') OR -- Sesi 1 Jumat
           (execution_time_val >= '14:00:00' AND execution_time_val <= '16:00:00') THEN -- Sesi 2 Jumat
            SET is_market_open = TRUE;
        END IF;
    END IF;


    IF NOT is_market_open THEN
        SET error_message = CONCAT(
            'Transaksi untuk Order ID ', 
            NEW.order_id, 
            ' ditolak. Pasar saham tidak beroperasi pada ', 
            DATE_FORMAT(NEW.waktu_eksekusi, '%W, %d-%b-%Y'), -- %W: Nama hari lengkap, %d: tgl, %b: nama bulan singk.
            ' pukul ', 
            DATE_FORMAT(NEW.waktu_eksekusi, '%H:%i:%s'), 
            ' (Waktu Eksekusi).'
        );
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    END IF;


END$$


DELIMITER ;