// The module delays the input data 'din' by the number of clock cycles
// set by CLK_DEL input parameter
module delay
    #( parameter
        WIDTH   = 8, // bit width of the input/output data
        CLK_DEL = 1  // number of clock cycles the data is delayed
    )
    (
        input  wire                   clk, // posedge active clock
        input  wire                   rst, // ASYNC reset active HIGH
        input  wire [ WIDTH - 1 : 0 ] din, // data to be delayed
        output wire [ WIDTH - 1 : 0 ] dout // delayed data
    );

    reg    [ WIDTH - 1 : 0 ] del_mem [ CLK_DEL - 1 : 0 ];

    assign dout = del_mem[ CLK_DEL - 1 ];

//------------------------------------------------------------------------------
// The first delay stage
    always @(posedge clk or posedge rst)
    begin:delay_stage_0
        if(rst)
            del_mem[0] <= 0;
        else
            del_mem[0] <= din;
    end


//------------------------------------------------------------------------------
// All the other delay stages
    genvar                   i;
    generate

        for (i = 1; i < CLK_DEL ; i = i + 1 )
        begin:delay_stage

            always @(posedge clk or posedge rst)
            begin
                if(rst)
                    del_mem[i] <= 0;
                else
                    del_mem[i] <= del_mem[i-1];
            end

        end

    endgenerate

endmodule
