--------------------------------------------------------------------------------
--
--   FileName:         hw_image_generator.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-bit Version 12.1 Build 177 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 05/10/2013 Scott Larson
--     Initial Public Release
--    
--------------------------------------------------------------------------------
--
-- Altered 10/13/19 - Tyler McCormick 
-- Test pattern is now 8 equally spaced 
-- different color vertical bars, from black (left) to white (right)


LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;

ENTITY hw_image_generator IS

	GENERIC (row_top : INTEGER := 100;
				row_bot : INTEGER := 440;
				row_tot : INTEGER := 480;
				
				col_ttul : INTEGER := 220;
				col_ttur : INTEGER := 420;
				
				col_tot : INTEGER := 640);
	
	PORT (disp_ena : IN STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
			row, column : IN INTEGER;    --row/column pixel coordinate
			red, green, blue : OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0'));  --rgb magnitude output to DAC
			
END hw_image_generator;

ARCHITECTURE behavior OF hw_image_generator IS

BEGIN

	PROCESS(disp_ena, row, column)
	
	BEGIN

	IF(disp_ena = '1') THEN	--display time
		
		IF(row < row_top) THEN --background start
		--sky
		red <= "00001010";
		green  <= "00001010";
		blue <= "00001010";
		
		ELSIF(row < row_bot AND row > row_top) THEN
		--middle
		red <= "00000101";
		green  <= "00000111";
		blue <= "00000010";
		
		ELSIF(row < row_tot AND row > row_bot) THEN
		--bottom
		red <= (OTHERS => '0');
		green  <= (OTHERS => '0');
		blue <= (OTHERS => '0');
		
		END IF;
			
		ELSE --blanking time
		
		red <= (OTHERS => '0');
		green <= (OTHERS => '0');
		blue <= (OTHERS => '0');
		
	END IF; --background end
	
	IF(row < (row_tot - 25) AND row > (row_bot + 5)) THEN --top third
	
		--TNTech ECE	
		IF(column > col_ttul AND column < (col_ttur - 185)) THEN --T
			
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
			
		ELSIF((column > (col_ttul + 20) AND column < (col_ttur - 174)) OR (column > (col_ttul + 31) AND column < (col_ttur - 165))) THEN --N
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF(column > (col_ttul + 40) AND column < (col_ttur - 145)) THEN --T
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF(column > (col_ttul + 60) AND column < (col_ttur - 125)) THEN --e
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF(column > (col_ttul + 80) AND column < (col_ttur - 105)) THEN --c
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF((column > (col_ttul + 100) AND column < (col_ttur - 94)) OR (column > (col_ttul + 109) AND column < (col_ttur - 85))) THEN --h
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF(column > (col_ttul + 115) AND column < (col_ttur - 55)) THEN --" "
		
		red <= (OTHERS => '0');
		green <= (OTHERS => '0');
		blue <= (OTHERS => '0');
		
		ELSIF(column > (col_ttul + 145) AND column < (col_ttur - 40)) THEN --E
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF(column > (col_ttul + 165) AND column < (col_ttur - 20)) THEN --C
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF(column > (col_ttul + 185) AND column < col_ttur) THEN --E
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSE --blanking time
	
		red <= (OTHERS => '0');
		green <= (OTHERS => '0');
		blue <= (OTHERS => '0');
		
		END IF;
		
	END IF; --Top third end
		
	IF(row < (row_tot - 15) AND row > (row_bot + 15)) THEN --Middle third
	
		--TNTech ECE	
		IF(column > (col_ttul + 5) AND column < (col_ttur - 190)) THEN --T
			
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
			
		ELSIF((column > (col_ttul + 20) AND column < (col_ttur - 176)) OR (column > (col_ttul + 25) AND column < (col_ttur - 170)) OR (column > (col_ttul + 31) AND column < (col_ttur - 165))) THEN --N
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF(column > (col_ttul + 45) AND column < (col_ttur - 150)) THEN --T
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF(column > (col_ttul + 60) AND column < (col_ttur - 125)) THEN --e
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF(column > (col_ttul + 80) AND column < (col_ttur - 114)) THEN --c
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF(column > (col_ttul + 100) AND column < (col_ttur - 85)) THEN --h
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF(column > (col_ttul + 115) AND column < (col_ttur - 55)) THEN --" "
		
		red <= (OTHERS => '0');
		green <= (OTHERS => '0');
		blue <= (OTHERS => '0');
		
		ELSIF(column > (col_ttul + 145) AND column < (col_ttur - 40)) THEN --E
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF(column > (col_ttul + 165) AND column < (col_ttur - 29)) THEN --C
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF(column > (col_ttul + 185) AND column < col_ttur) THEN --E
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSE --blanking time
	
		red <= (OTHERS => '0');
		green <= (OTHERS => '0');
		blue <= (OTHERS => '0');
		
		END IF;
		
	END IF; --Middle third end
		
	IF(row < (row_tot - 5) AND row > (row_bot + 25)) THEN --Bottom third
	
		--TNTech ECE	
		IF(column > (col_ttul + 5) AND column < (col_ttur - 190)) THEN --T
			
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
			
		ELSIF((column > (col_ttul + 20) AND column < (col_ttur - 176)) OR (column > (col_ttul + 29) AND column < (col_ttur - 165))) THEN --N
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF(column > (col_ttul + 45) AND column < (col_ttur - 150)) THEN --T
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF(column > (col_ttul + 60) AND column < (col_ttur - 125)) THEN --e
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF(column > (col_ttul + 80) AND column < (col_ttur - 105)) THEN --c
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF((column > (col_ttul + 100) AND column < (col_ttur - 94)) OR (column > (col_ttul + 109) AND column < (col_ttur - 85))) THEN --h
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF(column > (col_ttul + 115) AND column < (col_ttur - 55)) THEN --" "
		
		red <= (OTHERS => '0');
		green <= (OTHERS => '0');
		blue <= (OTHERS => '0');
		
		ELSIF(column > (col_ttul + 145) AND column < (col_ttur - 40)) THEN --E
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF(column > (col_ttul + 165) AND column < (col_ttur - 20)) THEN --C
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSIF(column > (col_ttul + 185) AND column < col_ttur) THEN --E
		
		red <= "00001000";
		green  <= "00001000";
		blue <= "00001111";
		
		ELSE --blanking time
		
		red <= (OTHERS => '0');
		green <= (OTHERS => '0');
		blue <= (OTHERS => '0');
		
		END IF;
		
	END IF; --Bottom third end

	END PROCESS;
	
END behavior;
