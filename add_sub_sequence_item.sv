
class add_sub_sequence_item extends uvm_sequence_item;

  //------------ i/p || o/p field declaration-----------------

  rand logic  [7:0] in1;  //i/p
  rand logic  [7:0] in2;
  rand logic    add_sub;

  logic [8:0] out;        //o/p

  //---------------- register add_sub_sequence_item class with factory --------
  `uvm_object_utils_begin(add_sub_sequence_item) 
     `uvm_field_int( in1     ,UVM_ALL_ON)
     `uvm_field_int( in2     ,UVM_ALL_ON)
     `uvm_field_int( add_sub ,UVM_ALL_ON)
     `uvm_field_int( out     ,UVM_ALL_ON)
  `uvm_object_utils_end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="add_sub_sequence_item");
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // write DUT inputs here for printing
  function string input2string();
    return($sformatf("in1=%d  in2=%d add_sub=%0b", in1,in2,add_sub));
  endfunction
  
  // write DUT outputs here for printing
  function string output2string();
    return($sformatf("out=%d", out));
  endfunction
    
  function string convert2string();
    return($sformatf({input2string(), "  ", output2string()}));
  endfunction
  //----------------------------------------------------------------------------

endclass:add_sub_sequence_item
