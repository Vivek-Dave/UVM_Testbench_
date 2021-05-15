
class add_sub_test extends uvm_test;

    //--------------------------------------------------------------------------
    `uvm_component_utils(add_sub_test)
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function new(string name="add_sub_test",uvm_component parent);
    	super.new(name,parent);
    endfunction
    //--------------------------------------------------------------------------

    add_sub_env env_h;
    int file_h;

    //--------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env_h = add_sub_env::type_id::create("env_h",this);
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function void end_of_elobartion_phase(uvm_phase phase);
      //factory.print();
      $display("End of eleboration phase in agent");
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function void start_of_simulation_phase(uvm_phase phase);
      $display("start_of_simulation_phase");
      file_h=$fopen("LOG_FILE.log","w");
      set_report_default_file_hier(file_h);
      set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY+UVM_LOG);
      set_report_verbosity_level_hier(UVM_MEDIUM);
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        add_sub_sequence seq;
        add_only seq2;
        sub_only seq3;
	      phase.raise_objection(this);
            seq= add_sub_sequence::type_id::create("seq");
            seq2=add_only::type_id::create("seq2");
            seq3=sub_only::type_id::create("seq3");
            seq2.N=40;
            seq3.N=40;
            seq.start(env_h.agent_h.sequencer_h);
            seq2.start(env_h.agent_h.sequencer_h);
            seq3.start(env_h.agent_h.sequencer_h);
            #10;
	      phase.drop_objection(this);
    endtask
    //--------------------------------------------------------------------------

endclass:add_sub_test

