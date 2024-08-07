---
language: SystemVerilog
filename: all-syntax.sv
contributors:
    - ["Daniel Espinosa", "https://github.com/danielespo"]
---


// All of systemverilog syntax in one file
// dae 2024
// ++++++++++++++++++++++++++++++++++++++
// START SYNTHESIZABLE VERILOG BELOW
// ++++++++++++++++++++++++++++++++++++++

// Module declaration
module module_name(port_list);

// Port declarations
input [width-1:0] input_signal;
output [width-1:0] output_signal;
inout [width-1:0] inout_signal;

// Wire and reg declarations
wire [width-1:0] wire_name;
reg [width-1:0] reg_name;

// Parameter and localparam declarations
parameter PARAM_NAME = value;
localparam LOCALPARAM_NAME = value;

// Continuous assignments
assign wire_name = expression;

// Procedural blocks
always @(sensitivity_list) begin
   // Procedural statements
end

// Conditional statements
if (condition) begin
   // Statements
end else if (condition) begin
   // Statements
end else begin
   // Statements
end

// Case statements
case (expression)
   value1: // Statements
   value2: // Statements
   default: // Statements
endcase

// Unique case and priority case
unique case(expression)
   // case items
endcase

priority case(expression)
   // case items
endcase

// Loops (in generate blocks)
generate
   for (genvar i = 0; i < N; i = i + 1) begin : gen_loop
       // Generated instances
   end
endgenerate

// Generate blocks
generate
   if (condition) begin : block_name
       // Generate items
   end else begin : block_name
       // Generate items
   end
endgenerate

// Arithmetic, logical, and bitwise operators
a + b; a - b; a * b; a / b; a % b;
a == b; a != b; a < b; a > b; a <= b; a >= b;
a && b; a || b; !a;
a & b; a | b; a ^ b; ~a;

// Reduction operators
&a; ~&a; |a; ~|a; ^a; ~^a;

// Shift operators
a << b; a >> b;

// Concatenation and replication operators
{signal1, signal2, signal3}
{num_times{signal}}

// Conditional operator
condition ? true_expression : false_expression

// Blocking and non-blocking assignments
variable = expression;  // Blocking
variable <= expression; // Non-blocking

// Module instantiation
module_name instance_name (
   .port1(signal1),
   .port2(signal2)
);

// Packed arrays
logic [7:0] packed_array [0:3];

// Enums (simple ones without methods)
typedef enum {ENUM_VALUE1, ENUM_VALUE2, ENUM_VALUE3} enum_name;

// Structs (simple ones without methods)
typedef struct {
   logic [7:0] field1;
   logic [15:0] field2;
} struct_name;

// Typedef (for simple types)
typedef existing_type new_type_name;

// Always_comb, always_ff, always_latch
always_comb begin
   // Combinational logic
end

always_ff @(posedge clk) begin
   // Sequential logic
end

always_latch begin
   // Latch logic
end

// Packed dimensions
logic [3:0][7:0] packed_2d;

// Multidimensional packed arrays
logic [1:0][3:0][7:0] array_3d;

// Fixed point types (depending on tool support)
shortreal fixed_point;

// Inside operator (in synthesizable contexts)
if (x inside {1, 2, 3, 4})

// Parameterized modules
module parameterized_module #(
   parameter PARAM1 = default_value1,
   parameter PARAM2 = default_value2
) (
   // Port list
);
   // Module body
endmodule

// Local parameters
localparam LOCAL_PARAM = value;

// Endmodule
endmodule


// ============================================================================= #



// More complicated than it needs to be, but still exists if we need it ...
// just use structs ...


// ============================================================================= #


// Interfaces (simple ones without modports)
interface interface_name;
	logic [7:0] data;
	logic valid;
	logic ready;
endinterface

// Function declarations (without automatic variables)
function [7:0] function_name;
	input [7:0] arg1, arg2;
	begin
    	function_name = arg1 + arg2;
	end
endfunction

// Task declarations (without automatic variables)
task task_name;
	input [7:0] in_arg;
	output [7:0] out_arg;
	begin
    	out_arg = in_arg * 2;
	end
endtask

// Assertions (only synthesizable subset)
assert property (@(posedge clk) req |-> ##2 ack);
assert property (@(posedge clk) $rose(req) |-> ##[1:3] ack);

// Finite state machines (explicit state encoding)
typedef enum logic [1:0] {
	IDLE = 2'b00,
	STATE1 = 2'b01,
	STATE2 = 2'b10,
	STATE3 = 2'b11
} state_t;

state_t current_state, next_state;

always_ff @(posedge clk or negedge rst_n) begin
	if (!rst_n)
    	current_state <= IDLE;
	else
    	current_state <= next_state;
end

always_comb begin
	case (current_state)
    	IDLE: // state transition logic
    	STATE1: // state transition logic
    	STATE2: // state transition logic
    	STATE3: // state transition logic
	endcase
end

// Signed and unsigned type specifiers
logic signed [7:0] signed_var;
logic unsigned [7:0] unsigned_var;


// The rest of all of the syntax, unorganized:






// ============================================================================= #
// ============================================================================= #
// ============================================================================= #
// ============================================================================= #


// Module declaration
module module_name(port_list);
// Input port
input [width-1:0] signal_name;
// Output port
output [width-1:0] signal_name;
// Inout port
inout [width-1:0] signal_name;
// Wire declaration
wire [width-1:0] wire_name;
// Reg declaration
reg [width-1:0] reg_name;
// Integer declaration
integer int_name;
// Parameter declaration
parameter PARAM_NAME = value;
// Localparam declaration
localparam LOCALPARAM_NAME = value;
// Continuous assignment
assign wire_name = expression;
// Procedural block (always)
always @(sensitivity_list) begin
// Procedural statements
end
// Procedural block (initial)
initial begin
// Procedural statements
end
// If statement
if (condition) begin
// Statements
end else if (condition) begin
// Statements
end else begin
// Statements
end
// Case statement
case (expression)
value1: // Statements
value2: // Statements
default: // Statements
endcase
// For loop
for (initialization; condition; increment) begin
// Statements
end
// While loop
while (condition) begin
// Statements
end
// Repeat loop
repeat (count) begin
// Statements
end
// Forever loop
forever begin
// Statements
end
// Task declaration
task task_name;
input [width-1:0] input_name;
output [width-1:0] output_name;
begin
// Task body
end
endtask
// Function declaration
function [return_width-1:0] function_name;
input [width-1:0] input_name;
begin
// Function body
end
endfunction
// Generate block
generate
// Generate items
endgenerate
// Conditional generate
generate
if (condition) begin : block_name
// Generate items
end else begin : block_name
// Generate items
end
endgenerate
// Delay (#)
#delay_value
// Non-blocking assignment
variable <= expression;
// Blocking assignment
variable = expression;
// Concatenation
{signal1, signal2, signal3}
// Replication
{num_times{signal}}
// Arithmetic operators
+, -, *, /, %
// Relational operators
==, !=, <, >, <=, >=
// Logical operators
&&, ||, !
// Bitwise operators
&, |, ^, ~
// Reduction operators
&, ~&, |, ~|, ^, ~^
// Shift operators
<<, >>
// Conditional operator
condition ? true_expression : false_expression
// Hierarchical path
module_instance.signal_name
// Parameter override
defparam module_instance.PARAM_NAME = new_value;
// Compiler directive
`define MACRO_NAME value
// Include directive
`include "filename.v"
// Timescale directive
`timescale time_unit/time_precision
// System tasks
$display, $write, $monitor, $strobe, $finish, $stop, $time, $random
// Module instantiation
module_name instance_name (
.port1(signal1),
.port2(signal2)
);
// Endmodule
endmodule

// Class declaration
class class_name;
// Class properties and methods
endclass
// Interface declaration
interface interface_name;
// Interface items
endinterface
// Package declaration
package package_name;
// Package items
endpackage
// Program block
program program_name;
// Program items
endprogram
// Typedef
typedef existing_type new_type_name;
// Enum
enum {ENUM_VALUE1, ENUM_VALUE2, ENUM_VALUE3} enum_name;
// Struct
struct {
type1 member1;
type2 member2;
} struct_name;
// Union
union {
type1 member1;
type2 member2;
} union_name;
// Packed array
logic [7:0] packed_array [0:3];
// Unpacked array
logic unpacked_array [0:3][7:0];
// Dynamic array
int dyn_array[];
// Associative array
int assoc_array[string];
// Queue
int queue[$];
// Fixed size queue
int fixed_queue[$:7];
// Wildcard equality operators
==?, !=?
// Constraint block
constraint constraint_name {
// Constraint expressions
}
// Randomize function
rand_success = object.randomize();
// Covergroup
covergroup covergroup_name;
// Cover points and crosses
endgroup
// Assertion
assert (expression) else $error("Assertion failed");
// Sequence declaration
sequence sequence_name;
// Sequence of events
endsequence
// Property declaration
property property_name;
// Sequence of events or boolean expressions
endproperty
// Clocking block
clocking clocking_name @(posedge clk);
// Clocking items
endclocking
// Modport
modport modport_name (input port1, output port2);
// Fork-join
fork
// Concurrent processes
join
// Fork-join_any
fork
// Concurrent processes
join_any
// Fork-join_none
fork
// Concurrent processes
join_none
// Mailbox declaration
mailbox #(message_type) mbx = new(bound);
// Semaphore declaration
semaphore sem = new(count);
// Event declaration
event evt;
// Wait fork
wait fork;
// Disable fork
disable fork;
// Virtual interface
virtual interface_name vif;
// Interface method
interface_name.modport_name.task_or_function();
// Parameterized class
class parameterized_class #(parameter PARAM = default_value);
// Class body
endclass
// Virtual class
virtual class base_class;
// Class body
endclass
// Class extension
class derived_class extends base_class;
// Class body
endclass
// Pure virtual method
pure virtual function void method_name();
// Abstract class
virtual class abstract_class;
// Class body with at least one pure virtual method
endclass
// Static class member
static int static_member;
// This keyword
this.member = value;
// Super keyword
super.method();
// Casting
derived_type_handle = derived_type'(base_type_handle);
// Streaming operators
{<<{packed_array}}  // Stream left
{>>{packed_array}}  // Stream right
// Let declaration
let name = expression;
// Bind construct
bind module_or_interface_instance : module_or_interface_name bind_target_module(.*);
// Checker declaration
checker checker_name(event_based_port_list);
// Checker body
endchecker
// Global clocking
global clocking @(posedge clk);
// Clocking items
endclocking
// Randcase statement
randcase
probability1: // statement1
probability2: // statement2
default: // default_statement
endcase
// Randsequence
randsequence(main)
main : statement1 statement2;
// Production rules
endsequence
// Soft constraints
soft constraint constraint_name { /* constraint items */ }
// Unique and priority case
unique case(expression)
// case items
endcase
priority case(expression)
// case items
endcase
// Assert, assume, cover statements
assert property (property_spec);
assume property (property_spec);
cover property (property_spec);
// Immediate assertions
assert #0 (expression);
// Concurrent assertions
assert property (@(posedge clk) expression);
// Sequence composition operators
##delay_value
sequence1 |-> sequence2
sequence1 |=> sequence2
sequence1 throughout sequence2
// SystemVerilog DPI (Direct Programming Interface)
import "DPI-C" function int c_function(input int arg);
export "DPI-C" function sv_function;
// Macros
`define MACRO_NAME(arg1, arg2) (expression)
// Macro usage
`MACRO_NAME(value1, value2)
// Conditional compilation
ifdef MACRO_NAME     // Code to compile if MACRO_NAME is defined elsif OTHER_MACRO
// Code to compile if OTHER_MACRO is defined
else     // Code to compile if none of the above are defined endif
// Include guard
ifndef MODULE_NAME_H define MODULE_NAME_H
// Module contents
`endif
// Type definitions
typedef struct {
int a;
bit [7:0] b;
} mystruct_t;
typedef enum {RED, GREEN, BLUE} color_t;
// Forward type declaration
typedef class my_class;
// Casting
int'(4.3)  // Cast real to int
unsigned'(-4)  // Cast signed to unsigned
// Multiline macro
`define COMPLEX_MACRO(a, b) 
begin 
a = a + b; 
b = a - b; 
end
// Parameterized macro
`define PARAMETERIZED_MACRO(NAME, WIDTH) 
reg [WIDTH-1:0] NAME
// Stringification in macros
define STRINGIFY(x) "x`"
// Concatenation in macros
`define CONCAT(a,b) a``b
// Undefine macro
`undef MACRO_NAME
// File operations
int fd = $fopen("filename.txt", "r");
$fclose(fd);
// Assertion control
$assertoff(0);  // Turn off all assertions
$asserton(0);   // Turn on all assertions
// Elaboration-time assertions
initial begin
assert final (expression) else $error("Assertion failed");
end
// Assertion severity system tasks
$fatal(1, "Fatal error message");
$error("Error message");
$warning("Warning message");
$info("Info message");
// Time formatting
$timeformat(-9, 2, " ns", 20);
// Value change dump (VCD)
initial begin
$dumpfile("dump.vcd");
$dumpvars(0, top_module);
end
// Process control
$exit;
$finish;
// Random number generation
int rand_num = $urandom_range(1, 10);
// Soft package import
import pkg_name::*;
// Explicit package import
import pkg_name::item_name;
// Wildcard import
import pkg_name::*;
// Scope resolution operator
pkg_name::item_name
// Compilation unit
begin_keywords "1800-2017"     // SystemVerilog 2017 code end_keywords
// Extern constraint
extern constraint constraint_name;
// Pure virtual class
pure virtual class abstract_base;
// Interface class
interface class interface_class_name;
// Interface class items
endclass
// Out-of-block constraint definitions
class my_class;
rand int x;
constraint c_name;
endclass
constraint my_class::c_name { x > 0; }
// Parameterized interfaces
interface parameterized_if #(parameter WIDTH = 8);

logic [WIDTH-1:0] data;
endinterface
// Typedef of interface
typedef virtual some_interface.master vif_t;
// Packed struct
typedef struct packed {
logic [7:0] field1;
logic [15:0] field2;
} packed_struct_t;
// Unpacked union
union {
int a;
real b;
} unpacked_union;
// Packed union
union packed {
logic [31:0] a;
logic [7:0][3:0] b;
} packed_union;
// Tagged union
typedef union tagged {
void Invalid;
int Valid;
} maybe_int_t;
// Specialized class parameter
class param_class #(type T = int);
T data;
endclass
// Let construct in constraints
constraint c_let {
let tmp = x + y;
z == tmp * 2;
}
// Unique0 case statement
unique0 case(expression)
// case items
endcase
// Always_comb, always_ff, always_latch
always_comb begin
// Combinational logic
end
always_ff @(posedge clk) begin
// Sequential logic
end
always_latch begin
// Latch logic
end
// Implicit port connections
.*
// Explicit in-line port connections
module_name #(.PARAM(value)) instance_name (.*);

// Alias statement
alias alias_name = expression;
// Streaming concatenation
{>>{a, b, c}}
// Streaming unpacked array concatenation
{<<{unpacked_array}}
// Pre-increment and post-increment
++variable;
variable++;
// Bit-stream casting
'{ a, b, c }
// Packed dimensions
bit [3:0][7:0] packed_2d;
// Multidimensional packed arrays
logic [1:0][3:0][7:0] array_3d;
// Array reduction methods
array.sum()
array.product()
array.and()
array.or()
array.xor()
// Array locator methods
array.find_first()
array.find_last()
array.find_index()
// Array ordering methods
array.sort()
array.rsort()
array.reverse()
array.shuffle()
// Array method chaining
array.sort().reverse().slice(2,5)
// Fixed point types
shortreal fixed_point;
// Solve...before constraint
constraint c_solve { solve a before b; }
// Inside operator
if (x inside {1, 2, 3, 4})
// Bins for covergroups
bins my_bins[] = {1, 2, 3};
bins range_bins = {[0:63]};
bins others[] = default;
// Cross coverage
cross variable1, variable2;
// Coverpoint options
coverpoint variable {
option.weight = 2;
option.goal = 90;
}
// Sequence repetition
sequence s;
##[1:3] a ##1 b;
endsequence
// Sequence AND/OR operators
s1 and s2
s1 or s2
// Cycle delay in assertions
a ##2 b |-> c
// Immediate assertion in procedural code
assert #0 (condition) else $error("message");
// Deferred assertion
assert final (condition) else $error("message");
// Data type introspection
$typename(variable)
$bits(variable)
$isunbounded(variable)
// Elaboration time system tasks
$fatal
$error
$warning
$info
// Runtime array manipulation
array.delete()
array.insert()
array.push_front()
array.push_back()
array.pop_front()
array.pop_back()
// Const and rand class properties
const int c = 5;
rand int r;
// Constraint implication
x -> y
// Constraint distribution
x dist {0:=40, [1:3]:/60};
// Randomize with inline constraints
std::randomize(variable) with { variable > 0; };
// Function return type inference
function automatic return_t foo();
// Out-of-block method definitions
function void class_name::method_name();
// Interfaces with modports
interface bus_if;
modport master (output addr, output data);
modport slave (input addr, input data);
endinterface
// Time literals
10ns
20ps
1us
// Unique if
unique if (condition1) statement1;
else if (condition2) statement2;
else statement3;
// Assert property with disable iff
assert property (@(posedge clk) disable iff (reset) expression);
// Concurrent assertion
always @(posedge clk)
cover property (a ##1 b ##1 c);
// Function with lifetime
function static int func_name();
// Task with lifetime
task automatic task_name();
// Parametric classes
class param_class #(type T = int, int W = 8);
// Virtual methods
virtual function void func_name();
// Pure virtual methods
pure virtual function void func_name();
// Abstract classes
virtual class abstract_class;
// Static class methods
static function void func_name();
// Local parameters
localparam LP = 10;
// Generate loops
generate
for (genvar i=0; i<8; i++) begin : gen_loop
// Generated instances
end
endgenerate
// Typedef enum with custom encoding
typedef enum bit [1:0] {RED = 2'b00, GREEN = 2'b01, BLUE = 2'b10} color_t;
// Parameterized typedef
typedef bit [WIDTH-1:0] param_type_t;
// Packed unions
union packed {
struct packed {
bit [3:0] a;
bit [3:0] b;
} ab;
bit [7:0] flat;
} packed_union_t;
// Timescale declaration
`timescale 1ns / 1ps
// Compiler directives
pragma protect begin_protected pragma protect end_protected
// Assertion clock declaration
default clocking @(posedge clk); endclocking
// Functional coverage
covergroup cg @(posedge clk);
coverpoint signal {
bins low = {[0:31]};
bins mid = {[32:223]};
bins high = {[224:255]};
}
endgroup
// Sampling in covergroups
cg_inst = new();
always @(posedge clk) cg_inst.sample();


// If you think I skipped any syntax, please suggest more below! - Dan :)
