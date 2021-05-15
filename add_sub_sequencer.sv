

class add_sub_sequencer extends uvm_sequencer#(add_sub_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(add_sub_sequencer)  
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="add_sub_sequencer",uvm_component parent);  
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------
  
endclass:add_sub_sequencer

