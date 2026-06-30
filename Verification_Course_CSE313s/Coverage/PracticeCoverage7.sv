// Assume that you are modelling a processor. It reads data and instructions from memory, 
// performs an operation, which is specified by an opcode, and writes back the result into the 
// memory. The verification plan requires the following: 
// a. Both Read & Write operations should be tested. (2 marks) 
// b. You should try different values for data such that you get at least one value in the 
// range from 1 to 64, and at least one value in the range 65 to 128, and at least one 
// value in the range 129 to 254. The value 0 should be used at least once, and the value 
// 255 should also be used at least once. (4 marks) 
// c. All operations should be tried. The opcode is specified as shown. (4 marks) 
// d. The memory space is divided into 128 pages. An address falling on each of the pages 
// should be used at least once. (4 marks) 
// Write a coverage group to measure the coverage when using random testing. You are 
// NOT asked to write the processor model. You are only asked to write the coverage 
// group, with several cover points, and specify the appropriate bins, and the illegal bins. Use 
// whatever options in your coverage group.

covergroup covprocess;

    coverpoint rd_wr{
        bins read ={0};
        bins write ={1};
    }

    coverpoint data{
        bins lo = {[1:64]};
        bins zero = {0};
        bins med = {[65:128]};
        bins high ={[129:254]};
        bins last_point = {255};

    }
    coverpoint opcode{
       
        illegal_bins ill={ [10: $],0};
        bins  legal_ones[] ={[1:9]};
    }
    coverpoint address{
        options.auto_bin_max=128;
    }



endgroup