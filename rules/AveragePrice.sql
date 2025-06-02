DELIMITER //


DROP TRIGGER IF EXISTS AfterTransactionUpdateUpdatePortfolio;
DROP TRIGGER IF EXISTS AfterTransactionInsertUpdatePortfolio; -- Dropping both in case of previous name or for safety


CREATE TRIGGER AfterTransactionInsertUpdatePortfolio
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
    DECLARE v_nik VARCHAR(100);
    DECLARE v_ticker VARCHAR(100);
    DECLARE v_tipe_order ENUM('beli', 'jual');
    DECLARE v_harga INT;
    DECLARE v_status ENUM('pending', 'partial', 'executed');


    DECLARE transaction_shares_executed INT;
    DECLARE transaction_cost DOUBLE;


    DECLARE current_jumlah_lembar INT;
    DECLARE current_average_cost DOUBLE;
    DECLARE new_total_cost DOUBLE;
    DECLARE new_total_lembar INT;
    DECLARE updated_average_cost DOUBLE;


    SELECT
        o.nik,
        o.ticker,
        o.tipe_order,
        o.harga,
        o.status
    INTO
        v_nik,
        v_ticker,
        v_tipe_order,
        v_harga,
        v_status
    FROM
        orders o
    WHERE
        o.order_id = NEW.order_id;


    SET transaction_shares_executed = NEW.jumlah;
    SET transaction_cost = (NEW.jumlah * v_harga);


    IF v_tipe_order = 'beli' AND (v_status = 'executed' OR v_status = 'partial') AND transaction_shares_executed > 0 THEN


        SELECT jumlah_lembar, average_cost
        INTO current_jumlah_lembar, current_average_cost
        FROM portfolios
        WHERE nik = v_nik AND ticker = v_ticker;


        IF current_jumlah_lembar IS NOT NULL THEN
            SET new_total_cost = (current_jumlah_lembar * current_average_cost) + transaction_cost;
            SET new_total_lembar = current_jumlah_lembar + transaction_shares_executed;


            IF new_total_lembar > 0 THEN
                SET updated_average_cost = new_total_cost / new_total_lembar;
            ELSE
                SET updated_average_cost = 0;
            END IF;


            UPDATE portfolios
            SET
                jumlah_lembar = new_total_lembar,
                average_cost = updated_average_cost
            WHERE nik = v_nik AND ticker = v_ticker;
        ELSE
            INSERT INTO portfolios (nik, ticker, jumlah_lembar, average_cost)
            VALUES (v_nik, v_ticker, transaction_shares_executed, v_harga);
        END IF;
    END IF;
END //


DELIMITER ;