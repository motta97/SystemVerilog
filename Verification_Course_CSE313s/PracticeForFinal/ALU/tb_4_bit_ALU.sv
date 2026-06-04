module test(ifc_alu.tb ifc_tb);
    class transaction;
        rand bit signed[3:0] A;
        rand bit signed[3:0] B;
        rand bit reset;
        rand bit opcode;
        function void check(bit signed[3:0]A, B,bit signed [4:0]C, bit [1:0] opcode, logic reset);
        int result;
        if(!reset)begin
            case(opcode)
            0: begin
                result=A+B;
                if(result==int'(C))begin
                    $display("Success!");
                end
                else $display("Failed! at ADD operation where A = %0d and B= %0d Observed C is: %0d, actual is: %0d",A,B,C,result);
            end
            1: begin
                result=A-B;
                if(result==int'(C))begin
                    $display("Success!");
                end
                 else $display("Failed! at SUB operation where A = %0d and B= %0d Observed C is: %0d, actual is: %0d",A,B,C,result);
            end
            2: begin
                result=~A;
                if(result==int'(C))begin
                    $display("Success!");
                end
                 else $display("Failed! at INVERTING operation where A = %0d and B= %0d Observed C is: %0d, actual is: %0d",A,B,C,result);
            end
            3: begin
                result =|B;
                if(result==int'(C))begin
                    $display("Success!");
                end
                 else $display("Failed! at OR REDUCTION operation where A = %0d and B= %0d Observed C is: %0d, actual is: %0d",A,B,C,result);
            end
            default:
                $display("Illegal OPCODE");

            endcase
        end
        endfunction
    endclass
    transaction tr;
initial begin
    tr= new();
    ifc_tb.cb_tb.reset<=1'b1;

    //CHECK ADD
    
    #10;
    ifc_tb.cb_tb.reset<=1'b0;
    ifc_tb.cb_tb.opcode<=2'b00;
    #10;
    ifc_tb.cb_tb.A<=0;
    ifc_tb.cb_tb.B<=3;
    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10;
    ifc_tb.cb_tb.A<=-5;
    ifc_tb.cb_tb.B<=0;
    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10;
    ifc_tb.cb_tb.A<=0;
    ifc_tb.cb_tb.B<=0;
    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10;
    ifc_tb.cb_tb.A<=-8;
    ifc_tb.cb_tb.B<=7;
    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10;

    ifc_tb.cb_tb.A<=7;
    ifc_tb.cb_tb.B<=-8;
    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10;

    ifc_tb.cb_tb.A<=-8;
    ifc_tb.cb_tb.B<=-8;
    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10;
    ifc_tb.cb_tb.A<=7;
    ifc_tb.cb_tb.B<=7;
    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10;
    repeat(100)begin
        tr.reset.rand_mode(0);
        tr.opcode.rand_mode(0);
        tr.opcode=0;
        assert(tr.randomize);
        ifc_tb.cb_tb.opcode<=tr.opcode;
        ifc_tb.cb_tb.A<=tr.A;
        ifc_tb.cb_tb.B<=tr.B;
        tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
        #10;
    end

    //CHECK SUB
        #10;
    ifc_tb.cb_tb.reset<=1'b0;
    ifc_tb.cb_tb.opcode<=2'b01;
    #10;
    ifc_tb.cb_tb.A<=0;
    ifc_tb.cb_tb.B<=3;
    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10
    ifc_tb.cb_tb.A<=-5;
    ifc_tb.cb_tb.B<=0;
    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10
    ifc_tb.cb_tb.A<=0;
    ifc_tb.cb_tb.B<=0;
    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10
    ifc_tb.cb_tb.A<=-8;
    ifc_tb.cb_tb.B<=7;
    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10

    ifc_tb.cb_tb.A<=7;
    ifc_tb.cb_tb.B<=-8;
    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10

    ifc_tb.cb_tb.A<=-8;
    ifc_tb.cb_tb.B<=-8;
    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10
    ifc_tb.cb_tb.A<=7;
    ifc_tb.cb_tb.B<=7;
    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10
    repeat(100)begin
        tr.reset.rand_mode(0);
        tr.opcode.rand_mode(0);
        tr.opcode=0;
        assert(tr.randomize);
        ifc_tb.cb_tb.opcode<=tr.opcode;
        ifc_tb.cb_tb.A<=tr.A;
        ifc_tb.cb_tb.B<=tr.B;
        tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
        #10;
    end

    //CHECK INVERTING 
    // b values are not of intereset here
    #10;
    ifc_tb.cb_tb.reset<=1'b0;
    ifc_tb.cb_tb.opcode<=2'b10;
    #10;
    ifc_tb.cb_tb.A<=0;
    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10
    ifc_tb.cb_tb.A<=-5;

    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10

    ifc_tb.cb_tb.A<=-8;

    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10

    ifc_tb.cb_tb.A<=7;

    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10

    repeat(100)begin
        tr.reset.rand_mode(0);
        tr.opcode.rand_mode(0);
        tr.opcode=0;
        assert(tr.randomize);
        ifc_tb.cb_tb.opcode<=tr.opcode;
        ifc_tb.cb_tb.A<=tr.A;
        tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
        #10;
    end

    //CHECK OR REDUCTION
    //A VLUE IS NOT OF INTEREST HERE
    #10;
    ifc_tb.cb_tb.reset<=1'b0;
    ifc_tb.cb_tb.opcode<=2'b11;
    #10;

    ifc_tb.cb_tb.B<=3;
    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10


    ifc_tb.cb_tb.B<=0;
    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10

    ifc_tb.cb_tb.B<=-8;
    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10

    ifc_tb.cb_tb.B<=7;
    tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
    #10
    repeat(100)begin
        tr.reset.rand_mode(0);
        tr.opcode.rand_mode(0);
        tr.opcode=0;
        assert(tr.randomize);
        ifc_tb.cb_tb.opcode<=tr.opcode;
        ifc_tb.cb_tb.B<=tr.B;
        tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
        #10;
    end


    //RANDOM EVERYTHING
        repeat(200)begin
        tr.reset.rand_mode(1);
        tr.opcode.rand_mode(1);
        assert(tr.randomize);
        ifc_tb.cb_tb.opcode<=tr.opcode;
        ifc_tb.cb_tb.B<=tr.B;
        ifc_tb.cb_tb.A<=tr.A;
        ifc_tb.cb_tb.reset<=tr.reset;
        tr.check(ifc_tb.cb_tb.A, ifc_tb.cb_tb.B, ifc_tb.cb_tb.C, ifc_tb.cb_tb.opcode,ifc_tb.cb_tb.reset);
        #10;
    end

    $finish;
end










endmodule