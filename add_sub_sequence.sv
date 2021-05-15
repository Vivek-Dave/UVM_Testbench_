
/***************************************************
** class name  : add_sub_sequence
** description : generate random stimulus 
***************************************************/
class add_sub_sequence extends uvm_sequence#(add_sub_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_object_utils(add_sub_sequence)            
  //----------------------------------------------------------------------------

  add_sub_sequence_item txn;
  int N=10;

  //----------------------------------------------------------------------------
  function new(string name="add_sub_sequence");  
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  virtual task body();
    repeat(N) begin 
      txn=add_sub_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.randomize();
      #5;
      finish_item(txn);
    end
  endtask:body
  //----------------------------------------------------------------------------
endclass:add_sub_sequence

/***************************************************
** class name  : add_only
** description : make add_sub==1 so DUT perform only
                 addition 
***************************************************/
class add_only extends add_sub_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(add_only)      
  //----------------------------------------------------------------------------
  
  add_sub_sequence_item txn;
  int N=20;
  
  //----------------------------------------------------------------------------
  function new(string name="add_only");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    repeat(N) begin 
      txn=add_sub_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.randomize()with{txn.add_sub==1;};
      #5;
      finish_item(txn);
    end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass

/***************************************************
** class name  : sub_only
** description : make add_sub==0 so DUT only perfoem
                 substraction 
***************************************************/
class sub_only extends add_sub_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(sub_only)      
  //----------------------------------------------------------------------------
  
  add_sub_sequence_item txn;
  int N=20;
  
  //----------------------------------------------------------------------------
  function new(string name="sub_only");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    repeat(N) begin 
      txn=add_sub_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.randomize()with{txn.add_sub==0;};
      finish_item(txn);
    end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass