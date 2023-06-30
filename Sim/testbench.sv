//-------------------------[NOTE]---------------------------------
//Particular testcase can be run by uncommenting, and commenting the rest
//`include "random_test.sv"
//`include "test_hready_high.sv"
// `include "test_slave_select.sv"
//`include "test_hprot.sv"
//`include "test_htrans_idle.sv"
//`include "test_htrans_busy.sv"
// `include "test_non_seq_write_word.sv"
`include "test_non_seq_write_halfword.sv"
//`include "test_write.sv"
//`include "test_read.sv"

//----------------------------------------------------------------

`include "interface.sv"
module tb();

  //clock and HRESETn signal declaration
  bit HCLK;
  bit HRESETn;
  
  //clock generation
  always #5 HCLK = ~HCLK;
  
  //HRESETn Generation
  initial begin
    HRESETn = 0;
    #5
    HRESETn  = 1;
  end
  
  //creatinng instance of interface, inorder to connect DUT and testcase
  mem_intf vif(HCLK , HRESETn);

  //Testcase instance, interface handle is passed to test as an argument
  test t1(vif);

//instantiate the dut
 ahb3lite_sram1rw dut ( 
    .HCLK      (vif.HCLK),
    .HRESETn   (vif.HRESETn),
    .HSEL      (vif.HSEL),
    .HADDR     (vif.HADDR),
    .HWDATA    (vif.HWDATA),
    .HRDATA    (vif.HRDATA),
    .HWRITE    (vif.HWRITE),
    .HSIZE     (vif.HSIZE),
    .HBURST    (vif.HBURST),
    .HPROT     (vif.HPROT),
    .HTRANS    (vif.HTRANS),
    .HREADYOUT (vif.HREADYOUT),
    .HREADY    (vif.HREADY),
    .HRESP     (vif.HRESP)
 );

  //enabling the wave dump
  // initial begin 
  //   $dumpfile("dump.vcd"); $dumpvars;
  // end

endmodule 