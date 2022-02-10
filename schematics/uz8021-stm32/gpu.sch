EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 5 10
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Sheet
S 3150 2900 1300 950 
U 61D89B0E
F0 "sheet61D89B0C" 50
F1 "vram.sch" 50
F2 "addr_bus" I L 3150 3000 50 
F3 "data_bus" I L 3150 3150 50 
F4 "cs" I L 3150 3300 50 
F5 "oe" I L 3150 3600 50 
F6 "we" I L 3150 3450 50 
$EndSheet
$Sheet
S 5600 3250 1250 350 
U 61D8CD9D
F0 "sheet61D8CD97" 50
F1 "vdiv.sch" 50
F2 "addr_bus" I L 5600 3350 50 
F3 "data_bus" I L 5600 3500 50 
F4 "vdbus_out" B R 6850 3500 50 
F5 "vabus_out" O R 6850 3350 50 
$EndSheet
Text GLabel 10150 1050 2    50   Output ~ 0
elbertv2_p1_1
Text GLabel 10150 1200 2    50   Output ~ 0
elbertv2_p1_2
Text GLabel 10150 1350 2    50   Output ~ 0
elbertv2_p1_3
Text GLabel 10150 1500 2    50   Output ~ 0
elbertv2_p1_4
Text GLabel 10150 1650 2    50   Output ~ 0
elbertv2_p1_5
Text GLabel 10150 2100 2    50   Output ~ 0
elbertv2_p1_8
Text GLabel 10150 1800 2    50   Output ~ 0
elbertv2_p1_6
Text GLabel 10150 1950 2    50   Output ~ 0
elbertv2_p1_7
Text GLabel 10150 2250 2    50   Output ~ 0
elbertv2_p2_1
Text GLabel 10150 2400 2    50   Output ~ 0
elbertv2_p2_2
Text GLabel 10150 2550 2    50   Output ~ 0
elbertv2_p2_3
Text GLabel 10150 2700 2    50   Output ~ 0
elbertv2_p2_4
Text GLabel 10150 2850 2    50   Output ~ 0
elbertv2_p2_5
Text GLabel 10150 3300 2    50   Output ~ 0
elbertv2_p2_8
Text GLabel 10150 3000 2    50   Output ~ 0
elbertv2_p2_6
Text GLabel 10150 3150 2    50   Output ~ 0
elbertv2_p2_7
Text GLabel 10150 3850 2    50   Output ~ 0
elbertv2_p3_1
Text GLabel 10150 4000 2    50   Output ~ 0
elbertv2_p3_2
Text GLabel 10150 4150 2    50   Output ~ 0
elbertv2_p3_3
Text GLabel 10150 4300 2    50   Output ~ 0
elbertv2_p3_4
Text GLabel 10150 4450 2    50   Output ~ 0
elbertv2_p3_5
Text GLabel 10150 4900 2    50   Output ~ 0
elbertv2_p3_8
Text GLabel 10150 4600 2    50   Output ~ 0
elbertv2_p3_6
Text GLabel 10150 4750 2    50   Output ~ 0
elbertv2_p3_7
Text HLabel 2000 3000 0    50   Input ~ 0
addr_bus
Wire Bus Line
	2000 3000 3100 3000
Text HLabel 2000 3150 0    50   Input ~ 0
data_bus
Wire Bus Line
	2000 3150 3050 3150
Text HLabel 2000 3300 0    50   Input ~ 0
cs
Wire Wire Line
	2000 3300 3150 3300
Text HLabel 2000 3450 0    50   Input ~ 0
we
Wire Wire Line
	2000 3450 3150 3450
Wire Bus Line
	3100 3000 3100 2750
Wire Bus Line
	3100 2750 5550 2750
Wire Bus Line
	5550 2750 5550 3350
Wire Bus Line
	5550 3350 5600 3350
Connection ~ 3100 3000
Wire Bus Line
	3100 3000 3150 3000
Wire Bus Line
	3050 3150 3050 2700
Wire Bus Line
	3050 2700 5500 2700
Wire Bus Line
	5500 2700 5500 3500
Wire Bus Line
	5500 3500 5600 3500
Connection ~ 3050 3150
Wire Bus Line
	3050 3150 3150 3150
Entry Wire Line
	9250 1150 9350 1050
Entry Wire Line
	9250 1300 9350 1200
Entry Wire Line
	9250 1450 9350 1350
Entry Wire Line
	9250 1600 9350 1500
Entry Wire Line
	9250 1750 9350 1650
Entry Wire Line
	9250 1900 9350 1800
Entry Wire Line
	9250 2050 9350 1950
Entry Wire Line
	9250 2200 9350 2100
Entry Wire Line
	9250 2350 9350 2250
Entry Wire Line
	9250 2500 9350 2400
Entry Wire Line
	9250 2650 9350 2550
Entry Wire Line
	9250 2800 9350 2700
Entry Wire Line
	9250 2950 9350 2850
Entry Wire Line
	9250 3100 9350 3000
Wire Bus Line
	6850 3350 9250 3350
Wire Wire Line
	10150 3150 9350 3150
Wire Wire Line
	10150 3000 9350 3000
Wire Wire Line
	10150 2850 9350 2850
Wire Wire Line
	10150 2700 9350 2700
Wire Wire Line
	10150 2550 9350 2550
Wire Wire Line
	10150 2400 9350 2400
Wire Wire Line
	10150 2250 9350 2250
Wire Wire Line
	10150 2100 9350 2100
Wire Wire Line
	10150 1950 9350 1950
Wire Wire Line
	10150 1800 9350 1800
Wire Wire Line
	10150 1650 9350 1650
Wire Wire Line
	10150 1500 9350 1500
Wire Wire Line
	10150 1350 9350 1350
Wire Wire Line
	10150 1200 9350 1200
Wire Wire Line
	10150 1050 9350 1050
Text Label 10050 3150 2    50   ~ 0
vabus14
Text Label 10050 3000 2    50   ~ 0
vabus13
Text Label 10050 2850 2    50   ~ 0
vabus12
Text Label 10050 2700 2    50   ~ 0
vabus11
Text Label 10050 2550 2    50   ~ 0
vabus10
Text Label 10050 2400 2    50   ~ 0
vabus9
Text Label 10050 2250 2    50   ~ 0
vabus8
Text Label 10050 2100 2    50   ~ 0
vabus7
Text Label 10050 1950 2    50   ~ 0
vabus6
Text Label 10050 1800 2    50   ~ 0
vabus5
Text Label 10050 1650 2    50   ~ 0
vabus4
Text Label 10050 1500 2    50   ~ 0
vabus3
Text Label 10050 1350 2    50   ~ 0
vabus2
Text Label 10050 1200 2    50   ~ 0
vabus1
Text Label 10050 1050 2    50   ~ 0
vabus0
Entry Wire Line
	9250 3250 9350 3150
Entry Wire Line
	9250 3950 9350 3850
Entry Wire Line
	9250 4100 9350 4000
Entry Wire Line
	9250 4250 9350 4150
Entry Wire Line
	9250 4400 9350 4300
Entry Wire Line
	9250 4550 9350 4450
Entry Wire Line
	9250 4700 9350 4600
Entry Wire Line
	9250 4850 9350 4750
Entry Wire Line
	9250 5000 9350 4900
Wire Wire Line
	10150 4900 9350 4900
Wire Wire Line
	10150 4750 9350 4750
Wire Wire Line
	10150 4600 9350 4600
Wire Wire Line
	10150 4450 9350 4450
Wire Wire Line
	10150 4300 9350 4300
Wire Wire Line
	10150 4150 9350 4150
Wire Wire Line
	10150 4000 9350 4000
Wire Wire Line
	10150 3850 9350 3850
Text Label 10050 4900 2    50   ~ 0
vdbus7
Text Label 10050 4750 2    50   ~ 0
vdbus6
Text Label 10050 4600 2    50   ~ 0
vdbus5
Text Label 10050 4450 2    50   ~ 0
vdbus4
Text Label 10050 4300 2    50   ~ 0
vdbus3
Text Label 10050 4150 2    50   ~ 0
vdbus2
Text Label 10050 3850 2    50   ~ 0
vdbus0
Text Label 10050 4000 2    50   ~ 0
vdbus1
Wire Bus Line
	6850 3500 9250 3500
Wire Bus Line
	9250 3500 9250 5000
Wire Bus Line
	9250 1150 9250 3350
$EndSCHEMATC
