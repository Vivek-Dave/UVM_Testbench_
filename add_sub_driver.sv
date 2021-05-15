
class add_sub_driver extends uvm_driver #(add_sub_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(add_sub_driver)
  //----------------------------------------------------------------------------

  uvm_analysis_port #(add_sub_sequence_item) drv2sb;
  
  //----------------------------------------------------------------------------
  function new(string name="add_sub_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  //---------------------------------------------------------------------------- 

  //--------------------------  virtual interface handel -----------------------  
  virtual interface intf vif;
  //----------------------------------------------------------------------------
  
  //-------------------------  get interface handel from top -------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif))) begin
      `uvm_fatal("driver","unable to get interface");
    end
    drv2sb=new("drv2sb",this);
  endfunction
  //----------------------------------------------------------------------------
  
  //---------------------------- run task --------------------------------------
  task run_phase(uvm_phase phase);
    add_sub_sequence_item txn;
    initilize();
    forever begin
      seq_item_port.get_next_item(txn);
      send_transaction(txn);
      drv2sb.write(txn);
      seq_item_port.item_done();    
    end
  endtask
  //----------------------------------------------------------------------------
  
  task send_transaction(add_sub_sequence_item tr);
    vif.in1     = tr.in1;
    vif.in2     = tr.in2;
    vif.add_sub = tr.add_sub;  // non blocking because there is no clocking block
  endtask

  task initilize();
    vif.in1     =0;
    vif.in2     =0;
    vif.add_sub =0;
  endtask

endclass:add_sub_driver

