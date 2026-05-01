module alu_tb;
    typedef enum logic [2:0] {
        OP_ADD = 3'b000,
        OP_SUB = 3'b001,
        OP_AND = 3'b010,
        OP_OR = 3'b011,
        OP_XOR = 3'b100,
        OP_NOT = 3'b101,
        OP_SLL = 3'b110,
        OP_SRL = 3'b111
    } opcode_e;
    logic [7:0] a, b, result;
    logic [2:0] op;
    logic zero, carry;
    alu dut (
    .a(a), .b(b), .op(op),
    .result(result), .zero(zero), .carry(carry)
    );
    int opcode_hit_count[opcode_e];//associative array where the key is enum and the value is int
    typedef struct {
        logic [7:0] operand_a;
        logic [7:0] operand_b;
        opcode_e opcode;
        logic [7:0] expected_result;
        logic expected_carry;
        logic expected_zero;
        logic [7:0] actual_result;
        logic actual_carry;
        logic actual_zero;
        bit pass;
    } alu_transaction_s;
    alu_transaction_s stimulus_q[$];//a queue of transactions
    int pass_count;//default of int is zero
    int fail_count;
    int results_tracker[string];//associative array
    function alu_transaction_s compute_expected(alu_transaction_s txn);
        //this's our golden model
        txn.expected_result = 8'b0;
        txn.expected_carry = 1'b0;
        case (txn.opcode)
        OP_ADD: begin
        txn.expected_result = txn.operand_a + txn.operand_b;
        txn.expected_carry = (txn.expected_result < txn.operand_a);
        end
        OP_SUB: begin
        txn.expected_result = txn.operand_a - txn.operand_b;
        txn.expected_carry = (txn.operand_a < txn.operand_b);
        end
        OP_AND: txn.expected_result = txn.operand_a & txn.operand_b;
        OP_OR: txn.expected_result = txn.operand_a | txn.operand_b;
        OP_XOR: txn.expected_result = txn.operand_a ^ txn.operand_b;
        OP_NOT: txn.expected_result = ~txn.operand_a;
        OP_SLL: begin
        txn.expected_carry = txn.operand_a[7];
        txn.expected_result = txn.operand_a << 1;
        end
        OP_SRL: txn.expected_result = txn.operand_a >> 1;
        default: txn.expected_result = 8'b0;
        endcase
        txn.expected_zero = (txn.expected_result == 8'b0);
        return txn;
    endfunction


initial begin

    pass_count = 0;
    fail_count = 0;
    // --- Directed Tests ---
    $display("");
    $display("=== Running Directed Tests ===");
    generate_directed_stimulus();
    $display("Generated %0d directed transactions",
    stimulus_q.size());
    foreach (stimulus_q[i]) begin
        //here we're driving the DUT and taking its ouptuts
    drive_transaction(stimulus_q[i]);
    stimulus_q[i].actual_result = result;
    stimulus_q[i].actual_carry = carry;
    stimulus_q[i].actual_zero = zero;
    //then we compare the outputs of the DUT with the ouptus of the GM
    check_result(stimulus_q[i]);
    end
    stimulus_q.delete();
    // --- Random Tests ---
    $display("");
    $display("=== Running Random Tests (50 transactions) ===");
    generate_random_stimulus(50);//this not just generate random stimulus, but also apply it to the gm
    $display("Generated %0d random transactions",
    stimulus_q.size());
    foreach (stimulus_q[i]) begin
        //apply inputs to the dut
    drive_transaction(stimulus_q[i]);
    stimulus_q[i].actual_result = result;
    stimulus_q[i].actual_carry = carry;
    stimulus_q[i].actual_zero = zero;
    //check output of DUT against outpu of GM
    check_result(stimulus_q[i]);
    //the following code is for making histogram or frequency count for each opcode
    if (opcode_hit_count.exists(stimulus_q[i].opcode))
        opcode_hit_count[stimulus_q[i].opcode]++;//increment the integer value associated with this opcode
    else
        opcode_hit_count[stimulus_q[i].opcode] = 1;//if it wasn't seen before initialize it to one
    end
    // --- Final Report ---
    print_report();
    $display("=== Coverage Report ===");
    foreach (opcode_hit_count[op])
    $display(" %-8s : %0d hits", op.name(), opcode_hit_count[op]);
    $finish;
end
    task generate_directed_stimulus();
        alu_transaction_s txn;
        opcode_e op_val;
        // Cover all opcodes with a basic operand pair
        //directed test case
        op_val = op_val.first();
        do begin
            txn.operand_a = 8'hA5;
            txn.operand_b = 8'h5A;
            txn.opcode = op_val;
            txn.pass = 0;
            txn = compute_expected(txn);
            stimulus_q.push_back(txn);
            op_val = op_val.next();
        end while (op_val != op_val.first());
        // Edge case: ADD overflow (255 + 1)
            txn.operand_a = 8'hFF; txn.operand_b = 8'h01; txn.opcode = OP_ADD;
            txn = compute_expected(txn); stimulus_q.push_back(txn);
            // Edge case: SUB underflow (0 - 1)
            txn.operand_a = 8'h00; txn.operand_b = 8'h01; txn.opcode = OP_SUB;
            txn = compute_expected(txn); stimulus_q.push_back(txn);
            // Edge case: zero result (equal operands)
            txn.operand_a = 8'h42; txn.operand_b = 8'h42; txn.opcode = OP_SUB;
            txn = compute_expected(txn); stimulus_q.push_back(txn);
            // Edge case: AND with all ones
            txn.operand_a = 8'hFF; txn.operand_b = 8'hFF; txn.opcode = OP_AND;
            txn = compute_expected(txn); stimulus_q.push_back(txn);
            // Edge case: OR with all zeros
            txn.operand_a = 8'h00; txn.operand_b = 8'h00; txn.opcode = OP_OR;
            txn = compute_expected(txn); stimulus_q.push_back(txn);
    endtask
    task generate_random_stimulus(int num_txns);
        alu_transaction_s txn;
        for (int i = 0; i < num_txns; i++) begin
            txn.operand_a = $urandom % 256;
            txn.operand_b = $urandom % 256;
            txn.opcode = opcode_e'($urandom % 8);//casting
            txn.pass = 0;
            txn = compute_expected(txn);
            stimulus_q.push_back(txn);
        end
    endtask
    function void check_result(input alu_transaction_s txn);

        string op_name;
        op_name = txn.opcode.name();
        if (txn.actual_result == txn.expected_result &&
        txn.actual_carry == txn.expected_carry &&
        txn.actual_zero == txn.expected_zero) begin
            pass_count++;
            if (results_tracker.exists({op_name, "_pass"}))
            results_tracker[{op_name, "_pass"}]++;
            else
            results_tracker[{op_name, "_pass"}] = 1;
        end
        else begin
            fail_count++;
            if (results_tracker.exists({op_name, "_fail"}))
            results_tracker[{op_name, "_fail"}]++;
            else
            results_tracker[{op_name, "_fail"}] = 1;
            $display("[FAIL] %s: a=0x%02h b=0x%02h | Expected: r=0x%02h c=%0b z=%0b | Actual: r=0x%02h c=%0b z=%0b",
            op_name, txn.operand_a, txn.operand_b,
            txn.expected_result, txn.expected_carry,
            txn.expected_zero,
            txn.actual_result, txn.actual_carry,
            txn.actual_zero);
        end
    endfunction
    task print_report();
        $display("");
        $display("========================================");
        $display(" TEST REPORT SUMMARY");
        $display("========================================");
        $display(" Total PASS : %0d", pass_count);
        $display(" Total FAIL : %0d", fail_count);
        $display(" Total Tests: %0d", pass_count + fail_count);
        $display("----------------------------------------");
        $display(" Breakdown by Opcode:");
        foreach (results_tracker[key])
        $display(" %-15s : %0d", key, results_tracker[key]);
        $display("========================================");
        $display("");
    endtask

    task drive_transaction(input alu_transaction_s txn);
    a = txn.operand_a;
    b = txn.operand_b;
    op = txn.opcode;
    #10;
    endtask


endmodule