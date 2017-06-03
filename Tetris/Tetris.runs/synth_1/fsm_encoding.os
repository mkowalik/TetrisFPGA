
 add_fsm_encoding \
       {Altera_UP_PS2_Data_In.s_ps2_receiver} \
       { }  \
       {{000 000} {001 001} {010 010} {011 011} {100 100} }

 add_fsm_encoding \
       {Altera_UP_PS2_Command_Out.s_ps2_transmitter} \
       { }  \
       {{000 000} {001 001} {010 010} {011 011} {100 101} {101 110} {110 111} {111 100} }

 add_fsm_encoding \
       {PS2_Controller.s_ps2_transceiver} \
       { }  \
       {{000 00001} {001 10000} {010 00010} {011 00100} {100 01000} }
