/***************************************************
  analysis_port from driver
  analysis_port from monitor
***************************************************/

`uvm_analysis_imp_decl( _drv )
`uvm_analysis_imp_decl( _mon )

class add_sub_scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(add_sub_scoreboard)
  
  uvm_analysis_imp_drv #(add_sub_sequence_item, add_sub_scoreboard) aport_drv;
  uvm_analysis_imp_mon #(add_sub_sequence_item, add_sub_scoreboard) aport_mon;
  
  uvm_tlm_fifo #(add_sub_sequence_item) expfifo;
  uvm_tlm_fifo #(add_sub_sequence_item) outfifo;
  
  int VECT_CNT, PASS_CNT, ERROR_CNT;
  //-------------------------------------------------
  bit [7:0] t_in1,t_in2;
  bit         t_add_sub;
  bit [8:0]       t_out;
  //--------------------------------------------------

  function new(string name="add_sub_scoreboard",uvm_component parent);
    super.new(name,parent);
  endfunction
    
  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	aport_drv = new("aport_drv", this);
	aport_mon = new("aport_mon", this);
	expfifo= new("expfifo",this);
	outfifo= new("outfifo",this);
  endfunction


  function void write_drv(add_sub_sequence_item tr);
    `uvm_info("write_drv STIM", tr.input2string(), UVM_MEDIUM)
    t_in1 = tr.in1;
    t_in2 = tr.in2;
    t_add_sub = tr.add_sub;
    if(t_add_sub==1) begin 
      t_out = t_in1 + t_in2;
    end
    else if(t_add_sub==0) begin 
      t_out = t_in1 - t_in2;
    end
    else begin 
      `uvm_info("write_drv STIM","unknown value of add_sub detected",UVM_LOW)
    end
    tr.out = t_out;
    //write scoreboard code here
    void'(expfifo.try_put(tr));
  endfunction

  function void write_mon(add_sub_sequence_item tr);
    `uvm_info("write_mon OUT ", tr.convert2string(), UVM_MEDIUM)
    void'(outfifo.try_put(tr));
  endfunction
  int constraint_on_count=0;
  task run_phase(uvm_phase phase);
	add_sub_sequence_item exp_tr, out_tr;
	forever begin
	    `uvm_info("scoreboard run task","WAITING for expected output", UVM_DEBUG)
	    expfifo.get(exp_tr);
	    `uvm_info("scoreboard run task","WAITING for actual output", UVM_DEBUG)
	    outfifo.get(out_tr);
        
      if (out_tr.out===exp_tr.out) begin
            PASS();
           `uvm_info ("PASS ",out_tr.convert2string() , UVM_MEDIUM)
	      end
      
      else if(out_tr.out!==exp_tr.out && constraint_on_count>1) begin
	        ERROR();
          `uvm_info ("ERROR [ACTUAL_OP]",out_tr.convert2string() , UVM_MEDIUM)
          `uvm_info ("ERROR [EXPECTED_OP]",exp_tr.convert2string() , UVM_MEDIUM)
          `uvm_warning("ERROR",exp_tr.convert2string())
	      end
      	constraint_on_count++;
    end
  endtask

  function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        if (VECT_CNT && !ERROR_CNT)
            `uvm_info("PASSED",
            $sformatf("*** TEST PASSED - %0d vectors ran, %0d vectors passed ***",
            VECT_CNT, PASS_CNT), UVM_LOW)
        else
            `uvm_info("FAILED",
            $sformatf("*** TEST FAILED - %0d vectors ran, %0d vectors passed, %0d vectors failed ***",
            VECT_CNT, PASS_CNT, ERROR_CNT), UVM_LOW)
  endfunction

  function void PASS();
	VECT_CNT++;
	PASS_CNT++;
  endfunction

  function void ERROR();
  	VECT_CNT++;
  	ERROR_CNT++;
  endfunction

endclass

