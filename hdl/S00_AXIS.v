module S00_AXIS #(
    parameter C_S_AXIS_TDATA_WIDTH = 32,
    parameter C_S_AXIS_FIFO_DEPTH = 16
) (
    input wire S_AXIS_ACLK,
    input wire S_AXIS_ARESETN,
    // AXI Stream slave interface
    input wire S_AXIS_TVALID,
    output wire S_AXIS_TREADY,
    input wire [C_S_AXIS_TDATA_WIDTH-1:0] S_AXIS_TDATA,
	input wire [(C_S_AXIS_TDATA_WIDTH/8)-1 : 0] S_AXIS_TSTRB,
	input wire  S_AXIS_TUSER,
	input wire  S_AXIS_TLAST,
    // Read interface
    input wire rd_en,
    output reg [C_S_AXIS_TDATA_WIDTH-1:0] data_out,
    output reg full,
    output reg empty,
	output reg last_out,
	output reg user_out
);

    // Internal signals
    reg [C_S_AXIS_TDATA_WIDTH-1:0] mem_data [0:C_S_AXIS_FIFO_DEPTH-1];
	reg [0:0] mem_user [0:C_S_AXIS_FIFO_DEPTH-1];
	reg [0:0] mem_last [0:C_S_AXIS_FIFO_DEPTH-1];
    reg [$clog2(C_S_AXIS_FIFO_DEPTH):0] wr_ptr;
    reg [$clog2(C_S_AXIS_FIFO_DEPTH):0] rd_ptr;
    reg [$clog2(C_S_AXIS_FIFO_DEPTH+1):0] fifo_cnt;

    // Write operation with AXI Stream interface
    always @(posedge S_AXIS_ACLK) begin
        if (!S_AXIS_ARESETN) begin
            wr_ptr <= 0;
        end else if (S_AXIS_TVALID && !full) begin
            mem_data[wr_ptr] <= S_AXIS_TDATA;
			mem_user[wr_ptr] <= S_AXIS_TUSER;
			mem_last[wr_ptr] <= S_AXIS_TLAST;
            wr_ptr <= (wr_ptr + 1) % C_S_AXIS_FIFO_DEPTH;
        end
    end

    // Read operation
    always @(posedge S_AXIS_ACLK) begin
        if (!S_AXIS_ARESETN) begin
            rd_ptr <= 0;
            data_out <= 0;
            user_out <= 0;
            last_out <= 0;
        end else if (rd_en && !empty) begin
            data_out <= mem_data[rd_ptr];
			user_out <= mem_user[rd_ptr];
			last_out <= mem_last[rd_ptr];
            rd_ptr <= (rd_ptr + 1) % C_S_AXIS_FIFO_DEPTH;
        end
    end

    // FIFO count management
    always @(posedge S_AXIS_ACLK) begin
        if (!S_AXIS_ARESETN) begin
            fifo_cnt <= 0;
        end else begin
            if (S_AXIS_TVALID && !full && !(rd_en && !empty)) begin
                fifo_cnt <= fifo_cnt + 1;
            end else if (rd_en && !empty && !(S_AXIS_TVALID && !full)) begin
                fifo_cnt <= fifo_cnt - 1;
            end
        end
    end

    // FIFO status flags
    always @(posedge S_AXIS_ACLK) begin
        if (!S_AXIS_ARESETN) begin
            full <= 0;
            empty <= 1;
        end else begin
            full <= (fifo_cnt >= C_S_AXIS_FIFO_DEPTH - 1);
            empty <= (fifo_cnt <= 0);
        end
    end

    // AXI Stream ready signal
    assign S_AXIS_TREADY = !full;

endmodule
