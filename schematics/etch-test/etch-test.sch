EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CPU:Z80CPU U1
U 1 1 6172B40F
P 2900 2450
F 0 "U1" H 2900 4131 50  0000 C CNN
F 1 "Z80CPU" H 2900 4040 50  0000 C CNN
F 2 "Package_DIP:DIP-40_W25.4mm_Socket_LongPads" H 2900 2850 50  0001 C CNN
F 3 "www.zilog.com/manage_directlink.php?filepath=docs/z80/um0080" H 2900 2850 50  0001 C CNN
	1    2900 2450
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x06_Male J1
U 1 1 6172C3D3
P 4100 1550
F 0 "J1" H 4072 1432 50  0000 R CNN
F 1 "Conn_01x06_Male" H 4072 1523 50  0000 R CNN
F 2 "" H 4100 1550 50  0001 C CNN
F 3 "~" H 4100 1550 50  0001 C CNN
	1    4100 1550
	-1   0    0    1   
$EndComp
Wire Wire Line
	3900 1250 3600 1250
Wire Wire Line
	3600 1350 3900 1350
Wire Wire Line
	3600 1450 3900 1450
Wire Wire Line
	3600 1550 3900 1550
Wire Wire Line
	3600 1650 3900 1650
Wire Wire Line
	3600 1750 3900 1750
$EndSCHEMATC
