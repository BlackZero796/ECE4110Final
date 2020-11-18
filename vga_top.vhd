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
USE ieee.numeric_std.all;

ENTITY hw_image_generator IS
  GENERIC(
    
	col_a : INTEGER := 80;
	col_b : INTEGER := 160;
	col_c : INTEGER := 240;
	col_d : INTEGER := 320;
	col_e : INTEGER := 400;
	col_f : INTEGER := 480;
	col_g : INTEGER := 560;
	col_h : INTEGER := 640;
	
	topBar : INTEGER := 99;
	playField : INTEGER := 381;
	bottomBar : INTEGER := 480

	);  
  PORT(
    disp_ena :  IN   STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
    row      :  IN   INTEGER;    --row pixel coordinate
    column   :  IN   INTEGER;    --column pixel coordinate
    red      :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
    green    :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
    blue     :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0')); --blue magnitude output to DAC
END hw_image_generator;

ARCHITECTURE behavior OF hw_image_generator IS
BEGIN
  PROCESS(disp_ena, row, column)
  VARIABLE col_val, row_val, redVal, greenVal, blueVal : INTEGER ;
  VARIABLE manStartHeight : INTEGER := 31;
  
  --This will be changed later by the rotary encoder
  VARIABLE topOfHat : INTEGER := 100;
  VARIABLE topOfHatLength : INTEGER := 8;
  VARIABLE fatHat : INTEGER := topOfHat-4;
  VARIABLE fatHatLength : INTEGER := 16;
  VARIABLE mask : INTEGER := fatHat-4;
  VARIABLE maskLength : INTEGER := 24;
  VARIABLE eyeHole : INTEGER := mask + 6;
  VARIABLE eyeHoleLength: INTEGER := 4;
  VARIABLE nose : INTEGER := topOfHat+2;
  VARIABLE noseLength : INTEGER := 4;
  BEGIN
	
	--For drawing the top of hat
	if(row = manStartHeight and column >= topOfHat and column <= topOfHat + topOfHatLength) then
		redVal := 5;
		greenVal := 2;
		blueVal := 0;
	--For drawing the wide part of the hat
	elsif((row = manStartHeight+1 or row = manStartHeight+2) and column >= fatHat and column <= fatHat + fatHatLength) then
		redVal := 9;
		greenVal := 4;
		blueVal := 1;
	--For the different shade of the wide part of hat
	elsif(row = manStartHeight+3 and column >= fatHat and column <= fatHat + fatHatLength) then
		redVal := 3;
		greenVal := 3;
		blueVal := 3;
	--For drawing the mask
	elsif((row = manStartHeight+4 or row = manStartHeight+5 or row = manStartHeight+6) and column >= mask and column <= mask + maskLength and not (column >= eyeHole and column <= eyeHole + eyeHoleLength) and not (column >= eyeHole + 9 and column <= eyeHole + eyeHoleLength + 9)) then
		redVal := 3;
		greenVal := 3;
		blueVal := 3;
	elsif(row = manStartHeight+7 and column >= mask and column <= mask + maskLength) then
		redVal := 3;
		greenVal := 3;
		blueVal := 3;
	--Draws the top of the man with skin color
	elsif(row = manStartHeight+8 and column >= mask and column <= mask + maskLength and not (column >= nose and column <= nose + noseLength)) then
		redVal := 15;
		greenVal := 8;
		blueVal := 8;
	--Draws face with nose hole
	elsif((row >= manStartHeight + 9 and row <= manStartHeight+11) and column >= fatHat and column <= fatHat + fatHatLength and not (column >= nose and column <= nose + noseLength)) then
		redVal := 15;
		greenVal := 8;
		blueVal := 8;
	--Draws lines between nose and mouth
	elsif((row >= manStartHeight + 12 and row <= manStartHeight+15) and column >= fatHat and column <= fatHat + fatHatLength) then
		redVal := 15;
		greenVal := 8;
		blueVal := 8;
	--Draws top of mouth
	elsif((row >= manStartHeight+16 and row <= manStartHeight+17) and column >= fatHat and column <= fatHat + fatHatLength and not (column >= nose and column <= nose + noseLength)) then
		redVal := 15;
		greenVal := 8;
		blueVal := 8;
	elsif((row >= manStartHeight+18 and row <= manStartHeight+19) and column >= fatHat and column <= fatHat + fatHatLength and not (column >= eyeHole and column <= eyeHole + eyeHoleLength)  and not (column >= eyeHole + 8 and column <= eyeHole + eyeHoleLength + 9)) then
		redVal := 15;
		greenVal := 8;
		blueVal := 8;
	elsif((row >= manStartHeight+20 and row <= manStartHeight+23) and column >= topOfHat and column <= topOfHat + topOfHatLength) then
		redVal := 15;
		greenVal := 8;
		blueVal := 8;
	
	--Draws the striped shirt
	elsif((row >= manStartHeight+24 and row <= manStartHeight+25) and column >= topOfHat and column <= topOfHat + topOfHatLength) then
		redVal := 8;
		greenVal := 8;
		blueVal := 8;
	elsif((row >= manStartHeight+26 and row <= manStartHeight+27) and column >= fatHat and column <= fatHat + fatHatLength) then
		redVal := 9;
		greenVal := 9;
		blueVal := 9;
	elsif((row >= manStartHeight+28 and row <= manStartHeight+29) and column >= mask and column <= mask + maskLength) then
		redVal := 8;
		greenVal := 8;
		blueVal := 8;
	elsif((row >= manStartHeight+30 and row <= manStartHeight+31) and column >= mask and column <= mask + maskLength) then
		redVal := 9;
		greenVal := 9;
		blueVal := 9;
	elsif((row >= manStartHeight+32 and row <= manStartHeight+33) and column >= mask and column <= mask + maskLength) then
		redVal := 8;
		greenVal := 8;
		blueVal := 8;
	elsif((row >= manStartHeight+34 and row <= manStartHeight+35) and column >= mask and column <= mask + maskLength) then
		redVal := 9;
		greenVal := 9;
		blueVal := 9;
	elsif((row >= manStartHeight+36 and row <= manStartHeight+37) and column >= mask and column <= mask + maskLength) then
		redVal := 8;
		greenVal := 8;
		blueVal := 8;
	elsif((row >= manStartHeight+38 and row <= manStartHeight+39) and column >= mask and column <= mask + maskLength) then
		redVal := 9;
		greenVal := 9;
		blueVal := 9;
	elsif((row >= manStartHeight+40 and row <= manStartHeight+41) and column >= mask and column <= mask + maskLength) then
		redVal := 8;
		greenVal := 8;
		blueVal := 8;
	elsif((row >= manStartHeight+42 and row <= manStartHeight+43) and column >= mask and column <= mask + maskLength) then
		redVal := 9;
		greenVal := 9;
		blueVal := 9;
	elsif((row >= manStartHeight+44 and row <= manStartHeight+45) and column >= mask and column <= mask + maskLength) then
		redVal := 8;
		greenVal := 8;
		blueVal := 8;
	elsif((row >= manStartHeight+46 and row <= manStartHeight+47) and column >= mask and column <= mask + maskLength) then
		redVal := 9;
		greenVal := 9;
		blueVal := 9;
	elsif((row >= manStartHeight+48 and row <= manStartHeight+49) and column >= mask and column <= mask + maskLength) then
		redVal := 8;
		greenVal := 8;
		blueVal := 8;
	elsif((row >= manStartHeight+50 and row <= manStartHeight+51) and column >= mask and column <= mask + maskLength) then
		redVal := 9;
		greenVal := 9;
		blueVal := 9;
	elsif((row >= manStartHeight+52 and row <= manStartHeight+53) and column >= mask and column <= mask + maskLength) then
		redVal := 8;
		greenVal := 8;
		blueVal := 8;
	elsif((row >= manStartHeight+54 and row <= manStartHeight+55) and column >= mask and column <= mask + maskLength) then
		redVal := 9;
		greenVal := 9;
		blueVal := 9;
	elsif((row >= manStartHeight+56 and row <= manStartHeight+57) and column >= mask and column <= mask + maskLength) then
		redVal := 8;
		greenVal := 8;
		blueVal := 8;
	elsif((row >= manStartHeight+58 and row <= manStartHeight+59) and column >= mask and column <= mask + maskLength) then
		redVal := 9;
		greenVal := 9;
		blueVal := 9;
	elsif((row >= manStartHeight+60 and row <= manStartHeight+61) and column >= mask and column <= mask + maskLength) then
		redVal := 8;
		greenVal := 8;
		blueVal := 8;
	elsif((row >= manStartHeight+62 and row <= manStartHeight+63) and column >= mask and column <= mask + maskLength) then
		redVal := 9;
		greenVal := 9;
		blueVal := 9;
	elsif((row >= manStartHeight+64 and row <= manStartHeight+65) and column >= mask and column <= mask + maskLength) then
		redVal := 8;
		greenVal := 8;
		blueVal := 8;
	elsif((row >= manStartHeight+66 and row <= manStartHeight+69) and column >= mask and column <= mask + maskLength and not (column >= mask+6 and column <= mask + maskLength - 6)) then
		redVal := 15;
		greenVal := 8;
		blueVal := 8;
	elsif((row >= manStartHeight+70 and row <= manStartHeight+71) and column >= mask+6 and column <= mask + maskLength-6 and not (column >= mask+12 and column <= mask + maskLength - 12)) then
		redVal := 15;
		greenVal := 8;
		blueVal := 8;
	
		
	--All for drawing the background
	elsif(row < topBar) then
		redVal := 11;
		greenVal := 11;
		blueVal := 11;
	elsif(row > topBar and row < playField) then
		redVal := 5;
		greenVal := 7;
		blueVal := 2;
	elsif(row > playField and row < bottomBar) then
		redVal := 0;
		greenVal := 0;
		blueVal := 0;
	end if;
	
	if(disp_ena = '1') THEN
		red <= std_logic_vector(to_unsigned(redVal, red'length));
		green <= std_logic_vector(to_unsigned(greenVal, green'length));
		blue <= std_logic_vector(to_unsigned(blueVal, blue'length));
	else
		red <= (OTHERS => '0');
		blue <= (OTHERS => '0');
		green <= (OTHERS => '0');
	end if;
  
  END PROCESS;
END behavior;
