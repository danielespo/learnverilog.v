---
language: Verilog
filename: learnverilog.v
contributors:
    - ["Daniel Espinosa", "https://github.com/danielespo"]
---


// Single line comments start with two slashes

/* Multiline comments can be written
   using slash-asterisk and are often used
   as documentation.
*/

///////////////////////////////////////////////////
// 1. Basic Data Types and Operators
///////////////////////////////////////////////////

module basic_data_types;
    // Integer numbers
    integer a = 3;  // => 3

    // Basic arithmetic
    initial begin
        a = 1 + 1;   // => 2
        a = 8 - 1;   // => 7
        a = 10 * 2;  // => 20
        a = 35 / 5;  // => 7
    end
endmodule

///////////////////////////////////////////////////
// 2. Modules and Instances
///////////////////////////////////////////////////

// Basic module definition
module adder(input wire a, input wire b, output wire sum);
    assign sum = a + b;
endmodule

module test;
    wire sum;
    adder my_adder(.a(1'b1), .b(1'b1), .sum(sum));
endmodule

module twoBitReg(input wire clk, reset, load, input wire[1:0] inp, output wire [1:0] outp);
	dfrl dfrl_0(clk, reset, load, inp[0], outp[0]); // this is a flip flop in verilog
	dfrl dfrl_1(clk, reset, load, inp[1], outp[1]);
endmodule

///////////////////////////////////////////////////
// 3. Procedural Blocks and Conditional Statements
///////////////////////////////////////////////////

module procedural_blocks;
    reg [7:0] count = 0;

    // Always block
    always @(count) begin
        if (count < 5) begin
            count = count + 1;
        end else begin
            count = 0;
        end
    end
endmodule

///////////////////////////////////////////////////
// 4. Loops
///////////////////////////////////////////////////

module loops;
    integer i;

    initial begin
        for (i = 0; i < 5; i = i + 1) begin
            $display("Loop iteration: %d", i);
        end
    end
endmodule

///////////////////////////////////////////////////
// 5. Testbenches
///////////////////////////////////////////////////

// Testbench for the adder module
module adder_tb;
    reg a, b;
    wire sum;

    // Instantiate the adder
    adder my_adder(.a(a), .b(b), .sum(sum));

    initial begin
        // Test the adder
        a = 0; b = 0;
        #10; // Wait for 10 time units
        a = 1; b = 0;
        #10;
        a = 0; b = 1;
        #10;
        a = 1; b = 1;
        #10;
    end
endmodule

///////////////////////////////////////////////////
// 6. Vector Data Types and Concatenation
///////////////////////////////////////////////////

module vector_example;
    // Vectors (buses)
    reg [7:0] eight_bit_vector;
    reg [15:0] sixteen_bit_vector;

    initial begin
        eight_bit_vector = 8'b10101010; // 8-bit binary number
        // Concatenation
        sixteen_bit_vector = {eight_bit_vector, eight_bit_vector}; // => 1010101010101010
    end
endmodule

///////////////////////////////////////////////////
// 7. More on Conditional Statements - Case
///////////////////////////////////////////////////

module conditional_statements;
    reg [1:0] input_signal;
    reg [3:0] output_signal;

    initial begin
        input_signal = 2'b00;
        #10;
        input_signal = 2'b01;
        #10;
        input_signal = 2'b10;
        #10;
        input_signal = 2'b11;
    end

    always @(input_signal) begin
        case (input_signal)
            2'b00: output_signal = 4'b0001;
            2'b01: output_signal = 4'b0010;
            2'b10: output_signal = 4'b0100;
            2'b11: output_signal = 4'b1000;
            default: output_signal = 4'b0000;
        endcase
    end
endmodule

///////////////////////////////////////////////////
// 8. Instances - Connecting Modules
///////////////////////////////////////////////////

module parent_module;
    wire sum;
    reg a, b;

    // Instance of adder module
    adder my_adder_instance(.a(a), .b(b), .sum(sum));

    initial begin
        a = 1'b0; b = 1'b1;
        #10;
        a = 1'b1; b = 1'b0;
        #10;
    end
endmodule

///////////////////////////////////////////////////
// 9. Functions and Tasks
///////////////////////////////////////////////////

module function_and_task_example;
    reg [3:0] operand1, operand2;
    reg [3:0] result;

    // Function
    function [3:0] add;
        input [3:0] a, b;
        begin
            add = a + b;
        end
    endfunction

    // Task
    task display_result;
        input [3:0] res;
        begin
            $display("Result: %d", res);
        end
    endtask

    initial begin
        operand1 = 4'd5; operand2 = 4'd3;
        result = add(operand1, operand2);
        display_result(result);
    end
endmodule


///////////////////////////////////////////////////
// 10. Parameterized Modules
///////////////////////////////////////////////////

// A module with parameters
module parametrized_adder #(parameter WIDTH = 8) (
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output [WIDTH:0] sum
);
    assign sum = a + b;
endmodule

module test_parametrized_adder;
    wire [8:0] sum;
    reg [7:0] a, b;

    parametrized_adder #(.WIDTH(8)) adder_instance (.a(a), .b(b), .sum(sum));

    initial begin
        a = 8'd15; b = 8'd17;
        #10;
    end
endmodule

///////////////////////////////////////////////////
// 11. Generate Blocks
///////////////////////////////////////////////////

// Generate blocks for creating repetitive hardware structures
module generate_example;
    genvar i;
    generate 
        for (i = 0; i < 4; i = i + 1) begin: gen_block
            // Each iteration creates a new instance of adder
            adder adder_instance(.a(i), .b(i), .sum());
        end
    endgenerate
endmodule

///////////////////////////////////////////////////
// 12. Basic Synthesis Considerations
///////////////////////////////////////////////////

// Understanding synthesisable constructs
module synthesis_example;
    reg clk, reset;
    reg [3:0] counter;

    // Synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end
endmodule

///////////////////////////////////////////////////
// 13. Simple State Machine
///////////////////////////////////////////////////

// A simple state machine example
module state_machine(
    input clk,
    input reset,
    input start,
    output reg done
);
    // State declaration
    typedef enum reg [1:0] {
        IDLE,
        RUN,
        FINISH
    } state_type;

    state_type current_state, next_state;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: next_state = start ? RUN : IDLE;
            RUN: next_state = FINISH;
            FINISH: begin
                next_state = IDLE;
                done = 1;
            end
            default: next_state = IDLE;
        endcase
    end
endmodule

///////////////////////////////////////////////////
// 14. Arrays of Instances
///////////////////////////////////////////////////

// Creating multiple instances of a module using arrays
module array_of_instances;
    reg [7:0] a[0:3];
    reg [7:0] b[0:3];
    wire [7:0] sum[0:3];

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin: adder_array
            adder adder_instance(.a(a[i]), .b(b[i]), .sum(sum[i]));
        end
    endgenerate
endmodule

///////////////////////////////////////////////////
// 15. More on Tasks and Functions
///////////////////////////////////////////////////

// A more complex function
function [7:0] multiply;
    input [3:0] x, y;
    begin
        multiply = x * y; // Simple multiplication
    end
endfunction

// A more complex task
task automatic display_values;
    input [7:0] val1, val2;
    begin
        $display("Value 1: %d, Value 2: %d", val1, val2);
    end
endtask

///////////////////////////////////////////////////
// 16. Timing Control Statements
///////////////////////////////////////////////////

// Demonstrating delay and event control
module timing_control;
    reg signal;
    initial begin
        signal = 0;
        #10 signal = 1; // Delay for 10 time units
        #20 signal = 0; // Delay for another 20 time units
    end
endmodule

///////////////////////////////////////////////////
// 17. File I/O for Testbenches
///////////////////////////////////////////////////

// Reading from and writing to files in a testbench
module file_io_example;
    integer file;
    integer read_data;
    initial begin
        file = $fopen("data.txt", "r"); // Open a file for reading
        while (!$feof(file)) begin
            $fscanf(file, "%d\n", read_data);
            $display("Read Data: %d", read_data);
        end
        $fclose(file);
    end
endmodule

///////////////////////////////////////////////////
// 18. Interfaces
///////////////////////////////////////////////////

// Using interfaces to simplify port connections
interface simple_bus (input logic clk);
    logic [7:0] data;
    logic valid;
    logic ready;

    modport producer (output data, valid, input ready);
    modport consumer (input data, valid, output ready);
endinterface

module producer(input logic clk, simple_bus.producer bus);
    always @(posedge clk) begin
        bus.data <= 8'd255;
        bus.valid <= 1'b1;
    end
endmodule

module consumer(input logic clk, simple_bus.consumer bus);
    always @(posedge clk) begin
        if (bus.valid) begin
            $display("Data received: %d", bus.data);
            bus.ready <= 1'b1;
        end
    end
endmodule

///////////////////////////////////////////////////
// 19. Assertions
///////////////////////////////////////////////////

// Using assertions for verification
module assertion_example;
    reg [3:0] value;

    initial begin
        value = 4'd10;
        #10;
        value = 4'd5;
    end

    // Immediate assertion
    always @(value) begin
        assert (value < 4'd10) else $error("Value is not less than 10!");
    end
endmodule

///////////////////////////////////////////////////
// 20. Clock Domain Crossing (CDC)
///////////////////////////////////////////////////

// A basic example of clock domain crossing
module cdc_example(
    input logic src_clk, dest_clk,
    input logic [7:0] src_data,
    output logic [7:0] dest_data
);
    reg [7:0] intermediate;

    // Synchronizer in destination domain
    always @(posedge dest_clk) begin
        dest_data <= intermediate;
    end

    // Source domain logic
    always @(posedge src_clk) begin
        intermediate <= src_data;
    end
endmodule

///////////////////////////////////////////////////
// 21. Custom Data Types (Typedef)
///////////////////////////////////////////////////

// Using typedef to create custom data types
module typedef_example;
    typedef reg [7:0] byte;
    typedef reg [15:0] word;

    byte myByte;
    word myWord;

    initial begin
        myByte = 8'hAA; // Assigning a value to byte
        myWord = 16'h1234; // Assigning a value to word
    end
endmodule

///////////////////////////////////////////////////
// 22. Advanced Generate Constructs
///////////////////////////////////////////////////

// More advanced usage of generate constructs
module advanced_generate_example;
    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : block
            if (i % 2 == 0) begin : even_block
                // This block will only be generated for even 'i'
                adder even_adder(.a(i), .b(i), .sum());
            end else begin : odd_block
                // This block will only be generated for odd 'i'
                adder odd_adder(.a(i), .b(i), .sum());
            end
        end
    endgenerate
endmodule

///////////////////////////////////////////////////
// 23. Power-Aware Design
///////////////////////////////////////////////////

// Simple example of power-aware design using supply nets
module power_aware_design;
    supply1 vdd; // Represents a connection to a higher voltage (e.g., 1V)
    supply0 gnd; // Represents a connection to ground

    // Example of a simple logic gate with power connections
    pmos (out, gnd, in); // PMOS with source connected to Vdd
    nmos (out, vdd, in); // NMOS with source connected to Gnd

    reg in;
    wire out;

    initial begin
        in = 0;
        #10 in = 1;
        #10 in = 0;
    end
endmodule

///////////////////////////////////////////////////
// 24. Mixed-Signal Modeling
///////////////////////////////////////////////////

// Simple example of mixed-signal modeling
module mixed_signal_modeling;
    // Analog signal
    wire real v_analog;

    // Digital control
    reg digital_control;

    // Mixed-signal interaction
    assign v_analog = digital_control ? 5.0 : 0.0;

    initial begin
        digital_control = 1'b0;
        #10 digital_control = 1'b1;
        #10 digital_control = 1'b0;
    end
endmodule

///////////////////////////////////////////////////
// 25. Attribute Specifications
///////////////////////////////////////////////////

// Using attributes to specify additional information to tools
module attribute_specifications;
    (* dont_touch = "true" *) reg [3:0] critical_reg;

    initial begin
        critical_reg = 4'd0;
        #10 critical_reg = 4'd15;
        #10 critical_reg = 4'd0;
    end
endmodule

///////////////////////////////////////////////////
// 26. SystemVerilog Enhancements
///////////////////////////////////////////////////

// Highlighting some SystemVerilog enhancements
module systemverilog_enhancements;
    // Enhanced data types
    logic [7:0] logic_vector; // Replaces reg/wire dichotomy
    int integer_var;          // 32-bit integer

    // Always_ff block for sequential logic
    always_ff @(posedge clk) begin
        // Sequential logic here
    end

    // Always_comb block for combinational logic
    always_comb begin
        // Combinational logic here
    end
endmodule


///////////////////////////////////////////////////
// 27. Advanced Interfaces with Modports
///////////////////////////////////////////////////

// Advanced usage of interfaces with modports in SystemVerilog
interface advanced_interface(input logic clk);
    logic [31:0] data;
    logic valid, ready;

    modport producer (output data, valid, input ready);
    modport consumer (input data, valid, output ready);
endinterface

module producer(advanced_interface.producer intf);
    always @(posedge intf.clk) begin
        intf.data <= 32'hDEADBEEF;
        intf.valid <= 1'b1;
    end
endmodule

module consumer(advanced_interface.consumer intf);
    always @(posedge intf.clk) begin
        if (intf.valid) begin
            $display("Data received: %h", intf.data);
            intf.ready <= 1'b1;
        end
    end
endmodule

///////////////////////////////////////////////////
// 28. Clocking Blocks
///////////////////////////////////////////////////

// Using clocking blocks in SystemVerilog for synchronization
module clocking_block_example(input logic clk);
    clocking my_clock @(posedge clk);
        default input #1step output #1step;
        inout logic [31:0] data;
        input logic valid;
        output logic ready;
    endclocking

    // Use clocking block in procedural code
    always @(my_clock) begin
        if (my_clock.valid) begin
            my_clock.ready <= 1'b1;
        end
    end
endmodule

///////////////////////////////////////////////////
// 29. Unique and Priority Decision Making
///////////////////////////////////////////////////

// Using unique and priority in decision-making constructs
module decision_making;
    reg [2:0] selector;
    reg [7:0] result;

    always_comb begin
        unique case (selector)
            3'b000: result = 8'd0;
            3'b001: result = 8'd1;
            3'b010: result = 8'd2;
            3'b011, 3'b100: result = 8'd3; // Multiple matches
            default: result = 8'd255;
        endcase
    end

    always_comb begin
        priority case (selector)
            3'b000: result = 8'd0;
            3'b001: result = 8'd1;
            3'b010: result = 8'd2;
            3'b011: result = 8'd3;
            3'b100: result = 8'd4; // Lower priority
            default: result = 8'd255;
        endcase
    end
endmodule


///////////////////////////////////////////////////
// 30. Constrained Random Verification
///////////////////////////////////////////////////

// Using constrained random verification in SystemVerilog
class transaction;
    rand bit [31:0] address;
    rand bit [31:0] data;

    // Constraint example
    constraint valid_address { address >= 32'h1000; address <= 32'h1FFF; }
endclass

module constrained_random_verification;
    transaction trans;

    initial begin
        trans = new();
        repeat (10) begin
            trans.randomize() with { trans.data inside {[32'h0000:32'h00FF]}; };
            $display("Address: %h, Data: %h", trans.address, trans.data);
        end
    end
endmodule

///////////////////////////////////////////////////
// 31. Interface Classes
///////////////////////////////////////////////////

// Using interface classes for polymorphism in SystemVerilog
interface class communication_if;
    pure virtual function void send(bit [31:0] data);
endclass

class uart_comm extends communication_if;
    virtual function void send(bit [31:0] data);
        $display("UART Send: %h", data);
    endfunction
endclass

class spi_comm extends communication_if;
    virtual function void send(bit [31:0] data);
        $display("SPI Send: %h", data);
    endfunction
endclass

module interface_classes_example;
    communication_if comm_if;

    initial begin
        comm_if = new uart_comm();
        comm_if.send(32'hA5A5A5A5);
        
        comm_if = new spi_comm();
        comm_if.send(32'h5A5A5A5A);
    end
endmodule

///////////////////////////////////////////////////
// 32. Advanced Assertions
///////////////////////////////////////////////////

// Advanced use of assertions in SystemVerilog
module advanced_assertions(input logic clk);
    reg [7:0] data;
    reg valid, ready;

    // Simple immediate assertion
    always @(posedge clk) begin
        if (valid && !ready)
            assert (data != 8'h00) else $error("Data is zero when valid and not ready!");
    end

    // Sequence and property for temporal assertions
    sequence s_valid_data;
        valid && (data != 8'h00) ##1 (valid && ready);
    endsequence

    property p_no_invalid_data;
        @(posedge clk) s_valid_data;
    endproperty

    assert property (p_no_invalid_data) else $error("Invalid data sequence detected!");
endmodule

///////////////////////////////////////////////////
// 33. Packaging and Importing
///////////////////////////////////////////////////

// Defining a package in SystemVerilog
package my_package;
    typedef struct {
        int age;
        string name;
    } person_t;
endpackage

// Using the package in a module
module use_package_example;
    import my_package::*;

    person_t person;

    initial begin
        person.age = 30;
        person.name = "Alex";
        $display("Person: %s, Age: %d", person.name, person.age);
    end
endmodule

///////////////////////////////////////////////////
// 34. Interface Inheritance
///////////////////////////////////////////////////

// Demonstrating interface inheritance in SystemVerilog
interface base_if;
    pure virtual task do_something();
endinterface

interface extended_if extends base_if;
    pure virtual task do_something_else();
endinterface

module interface_inheritance_example;
    extended_if intf;

    initial begin
        // intf can be used here
    end
endmodule

///////////////////////////////////////////////////
// 35. Randomized Testing with Coverage
///////////////////////////////////////////////////

// Using randomized testing with coverage in SystemVerilog
module randomized_testing_with_coverage;
    bit [7:0] random_data;
    covergroup cg_data;
        coverpoint random_data {
            bins low = {[0:127]};
            bins high = {[128:255]};
        }
    endgroup

    initial begin
        cg_data cg = new();
        
        repeat (100) begin
            random_data = $urandom_range(0, 255);
            cg.sample();
        end

        $display("Coverage Report:\n");
        cg.report();
    end
endmodule
