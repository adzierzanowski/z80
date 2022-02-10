EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 10 10
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
L Connector:Mini-DIN-6 J?
U 1 1 61EACCEC
P 7550 1300
F 0 "J?" H 7550 1667 50  0000 C CNN
F 1 "Mini-DIN-6" H 7550 1576 50  0000 C CNN
F 2 "" H 7550 1300 50  0001 C CNN
F 3 "http://service.powerdynamics.com/ec/Catalog17/Section%2011.pdf" H 7550 1300 50  0001 C CNN
	1    7550 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	7250 1200 6950 1200
Wire Wire Line
	7250 1400 6950 1400
Wire Wire Line
	7850 1400 8150 1400
Wire Wire Line
	7850 1200 8150 1200
NoConn ~ 6950 1400
NoConn ~ 6950 1200
Text Label 7900 1200 0    50   ~ 0
clk
Text Label 7900 1400 0    50   ~ 0
data
$Comp
L power:+5V #PWR?
U 1 1 61EAD698
P 6800 1100
F 0 "#PWR?" H 6800 950 50  0001 C CNN
F 1 "+5V" H 6815 1273 50  0000 C CNN
F 2 "" H 6800 1100 50  0001 C CNN
F 3 "" H 6800 1100 50  0001 C CNN
	1    6800 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	6800 1100 6800 1300
Wire Wire Line
	6800 1300 7250 1300
$Comp
L power:GND #PWR?
U 1 1 61EADF90
P 8400 1550
F 0 "#PWR?" H 8400 1300 50  0001 C CNN
F 1 "GND" H 8405 1377 50  0000 C CNN
F 2 "" H 8400 1550 50  0001 C CNN
F 3 "" H 8400 1550 50  0001 C CNN
	1    8400 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	8400 1300 8400 1550
Wire Wire Line
	7850 1300 8400 1300
$EndSCHEMATC
