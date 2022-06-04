module tb_axi_dma
  import utils_pkg::*;
(
  input                     clk,
  input                     rst,
  // Slave AXI I/F
  // AXI Interface - MOSI
  // Write Address channel
  input axi_tid_t           dma_s_awid,
  input axi_addr_t          dma_s_awaddr,
  input axi_alen_t          dma_s_awlen,
  input axi_size_t          dma_s_awsize,
  input axi_burst_t         dma_s_awburst,
  input logic               dma_s_awlock,
  input logic        [3:0]  dma_s_awcache,
  input axi_prot_t          dma_s_awprot,
  input logic        [3:0]  dma_s_awqos,
  input logic        [3:0]  dma_s_awregion,
  input axi_user_req_t      dma_s_awuser,
  input logic               dma_s_awvalid,
  // Write Data channel
  input axi_data_t          dma_s_wdata,
  input axi_wr_strb_t       dma_s_wstrb,
  input logic               dma_s_wlast,
  input axi_user_data_t     dma_s_wuser,
  input logic               dma_s_wvalid,
  // Write Response channel
  input logic               dma_s_bready,
  // Read Address channel
  input logic               dma_s_arid,
  input axi_addr_t          dma_s_araddr,
  input axi_alen_t          dma_s_arlen,
  input axi_size_t          dma_s_arsize,
  input axi_burst_t         dma_s_arburst,
  input logic               dma_s_arlock,
  input logic        [3:0]  dma_s_arcache,
  input axi_prot_t          dma_s_arprot,
  input logic        [3:0]  dma_s_arqos,
  input logic        [3:0]  dma_s_arregion,
  input axi_user_req_t      dma_s_aruser,
  input logic               dma_s_arvalid,
  // Read Data channel
  input  logic              dma_s_rready,

  // AXI Interface - MISO
  // Write Addr channel
  output logic              dma_s_awready,
  // Write Data channel
  output logic              dma_s_wready,
  // Write Response channel
  output axi_tid_t          dma_s_bid,
  output axi_error_t        dma_s_bresp,
  output axi_user_rsp_t     dma_s_buser,
  output logic              dma_s_bvalid,
  // Read addr channel
  output logic              dma_s_arready,
  // Read data channel
  output axi_tid_t          dma_s_rid,
  output axi_data_t         dma_s_rdata,
  output axi_error_t           dma_s_rresp,
  output logic              dma_s_rlast,
  output axi_user_data_t    dma_s_ruser,
  output logic              dma_s_rvalid,

  // Master AXI I/F
  // AXI Interface - MOSI
  // Write Address channel
  output axi_tid_t          dma_m_awid,
  output axi_addr_t         dma_m_awaddr,
  output axi_alen_t         dma_m_awlen,
  output axi_size_t         dma_m_awsize,
  output axi_burst_t        dma_m_awburst,
  output logic              dma_m_awlock,
  output logic        [3:0] dma_m_awcache,
  output axi_prot_t         dma_m_awprot,
  output logic        [3:0] dma_m_awqos,
  output logic        [3:0] dma_m_awregion,
  output axi_user_req_t     dma_m_awuser,
  output logic              dma_m_awvalid,
  // Write Data channel
  output axi_data_t         dma_m_wdata,
  output axi_wr_strb_t      dma_m_wstrb,
  output logic              dma_m_wlast,
  output axi_user_data_t    dma_m_wuser,
  output logic              dma_m_wvalid,
  // Write Response channel
  output logic              dma_m_bready,
  // Read Address channel
  output logic              dma_m_arid,
  output axi_addr_t         dma_m_araddr,
  output axi_alen_t         dma_m_arlen,
  output axi_size_t         dma_m_arsize,
  output axi_burst_t        dma_m_arburst,
  output logic              dma_m_arlock,
  output logic        [3:0] dma_m_arcache,
  output axi_prot_t         dma_m_arprot,
  output logic        [3:0] dma_m_arqos,
  output logic        [3:0] dma_m_arregion,
  output axi_user_req_t     dma_m_aruser,
  output logic              dma_m_arvalid,
  // Read Data channel
  output  logic             dma_m_rready,

  // AXI Interface - MISO
  // Write Addr channel
  input logic               dma_m_awready,
  // Write Data channel
  input logic               dma_m_wready,
  // Write Response channel
  input axi_tid_t           dma_m_bid,
  input axi_error_t         dma_m_bresp,
  input axi_user_rsp_t      dma_m_buser,
  input logic               dma_m_bvalid,
  // Read addr channel
  input logic               dma_m_arready,
  // Read data channel
  input axi_tid_t           dma_m_rid,
  input axi_data_t          dma_m_rdata,
  input axi_error_t         dma_m_rresp,
  input logic               dma_m_rlast,
  input axi_user_data_t     dma_m_ruser,
  input logic               dma_m_rvalid
);
  s_axi_mosi_t dma_s_mosi;
  s_axi_miso_t dma_s_miso;

  s_axi_mosi_t dma_m_mosi;
  s_axi_miso_t dma_m_miso;

  always_comb begin
    // AXI4 Lite interface
    dma_s_mosi.awid     = dma_s_awid;
    dma_s_mosi.awaddr   = dma_s_awaddr;
    dma_s_mosi.awlen    = dma_s_awlen;
    dma_s_mosi.awsize   = dma_s_awsize;
    dma_s_mosi.awburst  = dma_s_awburst;
    dma_s_mosi.awlock   = dma_s_awlock;
    dma_s_mosi.awcache  = dma_s_awcache;
    dma_s_mosi.awprot   = dma_s_awprot;
    dma_s_mosi.awqos    = dma_s_awqos;
    dma_s_mosi.awregion = dma_s_awregion;
    dma_s_mosi.awuser   = dma_s_awuser;
    dma_s_mosi.awvalid  = dma_s_awvalid;
    dma_s_mosi.wdata    = dma_s_wdata;
    dma_s_mosi.wstrb    = dma_s_wstrb;
    dma_s_mosi.wlast    = dma_s_wlast;
    dma_s_mosi.wuser    = dma_s_wuser;
    dma_s_mosi.wvalid   = dma_s_wvalid;
    dma_s_mosi.bready   = dma_s_bready;
    dma_s_mosi.arid     = dma_s_arid;
    dma_s_mosi.araddr   = dma_s_araddr;
    dma_s_mosi.arlen    = dma_s_arlen;
    dma_s_mosi.arsize   = dma_s_arsize;
    dma_s_mosi.arburst  = dma_s_arburst;
    dma_s_mosi.arlock   = dma_s_arlock;
    dma_s_mosi.arcache  = dma_s_arcache;
    dma_s_mosi.arprot   = dma_s_arprot;
    dma_s_mosi.arqos    = dma_s_arqos;
    dma_s_mosi.arregion = dma_s_arregion;
    dma_s_mosi.aruser   = dma_s_aruser;
    dma_s_mosi.arvalid  = dma_s_arvalid;
    dma_s_mosi.rready   = dma_s_rready;

    dma_s_awready  = dma_s_miso.awready;
    dma_s_wready   = dma_s_miso.wready;
    dma_s_bid      = dma_s_miso.bid;
    dma_s_bresp    = dma_s_miso.bresp;
    dma_s_buser    = dma_s_miso.buser;
    dma_s_bvalid   = dma_s_miso.bvalid;
    dma_s_arready  = dma_s_miso.arready;
    dma_s_rid      = dma_s_miso.rid;
    dma_s_rdata    = dma_s_miso.rdata;
    dma_s_rresp    = dma_s_miso.rresp;
    dma_s_rlast    = dma_s_miso.rlast;
    dma_s_ruser    = dma_s_miso.ruser;
    dma_s_rvalid   = dma_s_miso.rvalid;

    // AXI4 Master interface
    dma_m_awid     = dma_m_mosi.awid;
    dma_m_awaddr   = dma_m_mosi.awaddr;
    dma_m_awlen    = dma_m_mosi.awlen;
    dma_m_awsize   = dma_m_mosi.awsize;
    dma_m_awburst  = dma_m_mosi.awburst;
    dma_m_awlock   = dma_m_mosi.awlock;
    dma_m_awcache  = dma_m_mosi.awcache;
    dma_m_awprot   = dma_m_mosi.awprot;
    dma_m_awqos    = dma_m_mosi.awqos;
    dma_m_awregion = dma_m_mosi.awregion;
    dma_m_awuser   = dma_m_mosi.awuser;
    dma_m_awvalid  = dma_m_mosi.awvalid;
    dma_m_wdata    = dma_m_mosi.wdata;
    dma_m_wstrb    = dma_m_mosi.wstrb;
    dma_m_wlast    = dma_m_mosi.wlast;
    dma_m_wuser    = dma_m_mosi.wuser;
    dma_m_wvalid   = dma_m_mosi.wvalid;
    dma_m_bready   = dma_m_mosi.bready;
    dma_m_arid     = dma_m_mosi.arid;
    dma_m_araddr   = dma_m_mosi.araddr;
    dma_m_arlen    = dma_m_mosi.arlen;
    dma_m_arsize   = dma_m_mosi.arsize;
    dma_m_arburst  = dma_m_mosi.arburst;
    dma_m_arlock   = dma_m_mosi.arlock;
    dma_m_arcache  = dma_m_mosi.arcache;
    dma_m_arprot   = dma_m_mosi.arprot;
    dma_m_arqos    = dma_m_mosi.arqos;
    dma_m_arregion = dma_m_mosi.arregion;
    dma_m_aruser   = dma_m_mosi.aruser;
    dma_m_arvalid  = dma_m_mosi.arvalid;
    dma_m_rready   = dma_m_mosi.rready;

    dma_m_miso.awready = dma_m_awready;
    dma_m_miso.wready  = dma_m_wready;
    dma_m_miso.bid     = dma_m_bid;
    dma_m_miso.bresp   = dma_m_bresp;
    dma_m_miso.buser   = dma_m_buser;
    dma_m_miso.bvalid  = dma_m_bvalid;
    dma_m_miso.arready = dma_m_arready;
    dma_m_miso.rid     = dma_m_rid;
    dma_m_miso.rdata   = dma_m_rdata;
    dma_m_miso.rresp   = dma_m_rresp;
    dma_m_miso.rlast   = dma_m_rlast;
    dma_m_miso.ruser   = dma_m_ruser;
    dma_m_miso.rvalid  = dma_m_rvalid;
  end

endmodule