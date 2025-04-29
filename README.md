# power-offset-modification
this script build to only modify the power offset on all amps cards without the need to use CBP

poweroffsetdata
Syntax
poweroffsetdata <direction> [<OTUBitRate> <Encoding> [<value>]]
Values
For <direction>:
{in, out} - selects the direction being configured
For <OTUBitRate>:
1..9000 - rate enumeration for a defined technology type; used in combination with
<Encoding> to identify technology type.
For <Encoding>:
1..9000 - line encoding enumeration for a defined technology type; used in combination
with <OTUBitRate> to identify technology type.
For <value>:
-6.00..6.00 - specifies the optical power offset in dB from the nominal value.
Default
0.00 dB
Used to configure the channel target power offset corresponding to a technology type.
Technology types must be previously defined in the technology type table (see "config
powermgmt general techtypes").
• For bidirectional (LINE) ports direction can be in for configuring the ingress direction or
out for configuring the egress direction. For unidirectional LINEIN and LINEOUT ports,
direction must correspond to the port direction.
• See "config powermgmt general techtypes" for definition of technology types in the NE.
If command is given without [<OTUBitRate> <Encoding> [<value>]] argument, the table of data
is displayed.
<OTUBitRate> <Encoding> <value> - sets the offset value for the technology type defined by
OTUBitRate and Encoding (both are enumerated values, and integers are expected).
If the technology is not defined, the NE will report an error.
If value is out of range, the NE will report an error and not set the value.
Technology type using OTUBitRate in range 9001..10000, and Encoding in range 9001..10000
cannot be assigned a value.
<OTUBitRate> <Encoding> omitting <value> - displays the value for the technology type
defined by OTUBitRate and Encoding (both are enumerated values, and integers are
expected).
If the technology type is not defined, the NE will report an error.
e.g.
config interface powermgmt 1/2/lineout poweroffsetdata out 1 1 -2
config interface powermgmt 1/3/linein poweroffsetdata in 1 1 -2

the power offset should apply on both egress and ingress amps , so I need to apply two command , but good news is that both values always be the same  


channel type
130G_coh_qpsk_abs_addxs
 
Bit Rate	Encoding
otm129G280 (12)	  cohpmqpsk (8) 		XXX
otm134G463 (16)	  cohpmqpsk-add3 (13)		XXX
otm131G679 (20)	  cohpmqpsk-add2l (18)		XXX
otm131G718 (23)	  cohpmqpsk-addxs (34)
otm133G101 (26)	  cohpmqpsk-addxs (34)
 
Bit Rate	Encoding
otm129G280 (12)	cohpmqpsk-hperf2 (10)		XXX
otm134G463 (16)	cohpmqpsk-add3 (13)		XXX
otm134G463 (16)	cohspqpsk-add3 (15)		XXX
otm134G463 (16)	cohpmqpsk-add3-superchannel (20)XXX
otm134G463 (16)	cohspqpsk-add3-superchannel (22)XXX
otm134G463 (16)	cohpmqpsk-add3-alien (28)	XXX
otm134G463 (16)	cohspqpsk-add3-alien (30)	XXX
otm131G718 (23)	cohpmqpsk-addxs (34)
otm131G718 (23)	cohpmqpsk-addxs-superchannel (35)
otm131G718 (23)	cohpmqpsk-addxs-alien (36)
otm133G101 (26)	cohpmqpsk-addxs (34)
otm133G101 (26)	cohpmqpsk-addxs-superchannel (35)
otm133G101 (26)	cohpmqpsk-addxs-alien (36)


to work around this bug 
1- if you are doing "scan" , just make the IP file with only IPs of the nodes 
2- if you are doing "update" , just make the IP file as normal  IP , shelf , slot
