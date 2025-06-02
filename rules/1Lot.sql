DELIMITER $$


CREATE TRIGGER trg_enforce_lot_rule_orders
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    IF NEW.jumlah_lembar <= 0 OR NEW.jumlah_lembar % 100 != 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Order failed: Jumlah lembar saham harus merupakan kelipatan 100 (1 lot) dan lebih besar dari 0.';
    END IF;
END$$


DELIMITER ;
