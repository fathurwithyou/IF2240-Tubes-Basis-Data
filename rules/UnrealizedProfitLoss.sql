ALTER TABLE portfolios
ADD COLUMN profit_loss DOUBLE;


DELIMITER //


CREATE PROCEDURE UpdateUnrealizedProfitLoss(IN user_nik VARCHAR(100))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE stock_ticker VARCHAR(100);
    DECLARE shares_owned INT;
    DECLARE avg_cost DOUBLE;
    DECLARE current_price DOUBLE;
    DECLARE calculated_profit_loss DOUBLE;


    -- Declare a cursor to iterate through the user's portfolio
    DECLARE cur CURSOR FOR
        SELECT ticker, jumlah_lembar, average_cost
        FROM portfolios
        WHERE nik = user_nik;


    -- Declare continue handler for 'not found' (for the cursor)
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;


    OPEN cur;


    read_loop: LOOP
        FETCH cur INTO stock_ticker, shares_owned, avg_cost;
        IF done THEN
            LEAVE read_loop;
        END IF;


        -- Get the latest price for the stock from live_stock_price_change table
        SELECT price INTO current_price
        FROM live_stock_price_change
        WHERE ticker = stock_ticker
        ORDER BY timestamp DESC
        LIMIT 1;


        -- Calculate profit/loss
        SET calculated_profit_loss = (current_price - avg_cost) * shares_owned;


        -- Update the profit_loss column in the portfolios table
        UPDATE portfolios
        SET profit_loss = calculated_profit_loss
        WHERE nik = user_nik AND ticker = stock_ticker;


    END LOOP;


    CLOSE cur;


END //


DELIMITER ;