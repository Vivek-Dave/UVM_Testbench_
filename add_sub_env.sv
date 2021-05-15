
class add_sub_env extends uvm_env;

   //---------------------------------------------------------------------------
   `uvm_component_utils(add_sub_env)
   //---------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="add_sub_env",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------

  //-------------------- class handles -----------------------------------------
  add_sub_agent    agent_h;
  add_sub_coverage coverage_h;
  add_sub_scoreboard scoreboard_h;
  //----------------------------------------------------------------------------

  //---------------------- build phase -----------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent_h    = add_sub_agent::type_id::create("agent_h",this);
    coverage_h = add_sub_coverage::type_id::create("coverage_h",this);
    scoreboard_h = add_sub_scoreboard::type_id::create("scoreboard_h",this);
  endfunction
  //----------------------------------------------------------------------------

  //-------------------------- connect phase -----------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent_h.monitor_h.ap_mon.connect(coverage_h.analysis_export);

    // .. scoreboard connection 
    agent_h.driver_h.drv2sb.connect(scoreboard_h.aport_drv);
    agent_h.monitor_h.ap_mon.connect(scoreboard_h.aport_mon);
  endfunction
  //----------------------------------------------------------------------------
endclass:add_sub_env

