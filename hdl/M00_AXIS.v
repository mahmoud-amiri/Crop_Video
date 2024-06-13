module M00_AXIS #(
	parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
	parameter integer C_M_AXIS_FIFO_DEPTH	= 16
) (

    input wire wr_en,
    output reg full,
    input wire [C_M_AXIS_TDATA_WIDTH-1:0] data_in,
    input wire last_in,
	input wire user_in,
    // AXI Stream Interface
	input wire M_AXIS_ACLK,
    input wire M_AXIS_ARESETN,
	output reg [C_M_AXIS_TDATA_WIDTH-1:0] M_AXIS_TDATA,
    output reg M_AXIS_TVALID,
    input wire M_AXIS_TREADY,
	output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] M_AXIS_TSTRB,
	output reg  M_AXIS_TLAST,
	output reg  M_AXIS_TUSER
    
);

    // Internal signals
    reg [C_M_AXIS_TDATA_WIDTH-1:0] mem_data [0:C_M_AXIS_FIFO_DEPTH-1];
	reg [0:0] mem_user [0:C_M_AXIS_FIFO_DEPTH-1];
	reg [0:0] mem_last [0:C_M_AXIS_FIFO_DEPTH-1];
    reg [$clog2(C_M_AXIS_FIFO_DEPTH):0] wr_ptr;
    reg [$clog2(C_M_AXIS_FIFO_DEPTH):0] rd_ptr;
    reg [$clog2(C_M_AXIS_FIFO_DEPTH+1):0] fifo_cnt;
	// wire rd_en;
	// reg [C_M_AXIS_TDATA_WIDTH-1:0] data_out;
	reg empty;
    // Write operation
    always @(posedge M_AXIS_ACLK) begin
        if (!M_AXIS_ARESETN) begin
            wr_ptr <= 0;
        end else if (wr_en && !full) begin
            mem_data[wr_ptr] <= data_in;
			mem_user[wr_ptr] <= user_in;
			mem_last[wr_ptr] <= last_in;
            wr_ptr <= (wr_ptr + 1) % C_M_AXIS_FIFO_DEPTH;
        end
    end

    // Read operation
    always @(posedge M_AXIS_ACLK) begin
        if (!M_AXIS_ARESETN) begin
            rd_ptr <= 0;
            M_AXIS_TDATA <= 0;
			M_AXIS_TVALID <= 0;
            M_AXIS_TLAST <= 0;
            M_AXIS_TUSER <= 0;
        end else begin
			M_AXIS_TVALID <= !empty;
            M_AXIS_TDATA <= mem_data[rd_ptr];
            M_AXIS_TLAST <= mem_last[rd_ptr];
            M_AXIS_TUSER <= mem_user[rd_ptr];
			if (M_AXIS_TREADY && !empty) begin
				rd_ptr <= (rd_ptr + 1) % C_M_AXIS_FIFO_DEPTH;
			end
        end
    end

    // FIFO count management
    always @(posedge M_AXIS_ACLK) begin
        if (!M_AXIS_ARESETN) begin
            fifo_cnt <= 0;
        end else begin
            if (wr_en && !full && !(M_AXIS_TREADY && !empty) && fifo_cnt<C_M_AXIS_FIFO_DEPTH) begin
                fifo_cnt <= fifo_cnt + 1;
            end else if (M_AXIS_TREADY && !empty && !(wr_en && !full) && fifo_cnt>0) begin
                fifo_cnt <= fifo_cnt - 1;
            end
        end
    end

    // FIFO status flags
    assign full = (fifo_cnt > C_M_AXIS_FIFO_DEPTH) ? 1 : 0;
    assign empty = (fifo_cnt < 1) ? 1 : 0;
    // always @(posedge M_AXIS_ACLK) begin
    //     if (!M_AXIS_ARESETN) begin
    //         full <= 0;
    //         empty <= 1;
    //     end else begin
    //         full <= (fifo_cnt >= C_M_AXIS_FIFO_DEPTH - 1);
    //         empty <= (fifo_cnt <= 0);
    //     end
    // end

    // AXI Stream Interface
    // always @(posedge M_AXIS_ACLK) begin
    //     if (!M_AXIS_ARESETN) begin
    //         M_AXIS_TVALID <= 0;
    //         M_AXIS_TDATA <= 0;
    //     end else begin
    //         M_AXIS_TVALID <= !empty;
    //         if (M_AXIS_TVALID && M_AXIS_TREADY) begin
    //             M_AXIS_TDATA <= data_out;
    //         end
    //     end
    // end

    // Read enable logic for AXI Stream
    // assign rd_en = M_AXIS_TVALID && M_AXIS_TREADY;

endmodule
