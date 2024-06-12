    
    `timescale 1 ns / 1 ps

	module crop_vid #(
		parameter C_AXIS_TDATA_WIDTH = 32,
		parameter C_AXIS_FIFO_DEPTH	= 16
	)(
		// Users to add ports here
        input wire [15:0] crop_x,
        input wire [15:0] crop_y,
        input wire [15:0] crop_width,
        input wire [15:0] crop_height,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXIS
		input wire  clk,
		input wire  resetn,
		output wire  s00_axis_tready,
		input wire [C_AXIS_TDATA_WIDTH-1 : 0] s00_axis_tdata,
		input wire [(C_AXIS_TDATA_WIDTH/8)-1 : 0] s00_axis_tstrb,
		input wire  s00_axis_tlast,
		input wire  s00_axis_tvalid,
        input wire s00_axis_tuser,

		// Ports of Axi Master Bus Interface M00_AXIS
		output wire  m00_axis_tvalid,
		output wire [C_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata,
		output wire [(C_AXIS_TDATA_WIDTH/8)-1 : 0] m00_axis_tstrb,
		output wire  m00_axis_tlast,
        output wire m00_axis_tuser,
		input wire  m00_axis_tready
	);

	// Internal signals
	reg [C_AXIS_TDATA_WIDTH-1 : 0] data_in;
	reg user_in;
	reg last_in;
	reg empty;
	reg read_en;
	reg [C_AXIS_TDATA_WIDTH-1 : 0] data_out;
	reg user_out;
	reg last_out;
	reg wr_en;
	reg full;


    // Crop logic
    reg [15:0] x, y;
    reg cropping;
    reg [C_AXIS_TDATA_WIDTH-1 : 0] cropped_data;
    reg cropped_valid, cropped_last, cropped_user;

    // Instantiation of Axi Bus Interface S00_AXIS
	S00_AXIS # ( 
		.C_S_AXIS_TDATA_WIDTH(C_AXIS_TDATA_WIDTH),
		.C_S_AXIS_FIFO_DEPTH(C_AXIS_FIFO_DEPTH)
	) S00_AXIS_inst (
		.S_AXIS_ACLK(clk),
		.S_AXIS_ARESETN(resetn),
		.S_AXIS_TREADY(s00_axis_tready),
		.S_AXIS_TDATA(s00_axis_tdata),
		.S_AXIS_TSTRB(s00_axis_tstrb),
		.S_AXIS_TLAST(s00_axis_tlast),
		.S_AXIS_TVALID(s00_axis_tvalid),
		.S_AXIS_TUSER(s00_axis_tuser),
		.data_out(data_in),
		.user_out(user_in),
		.last_out(last_in),
		.empty(empty),
		.rd_en(read_en)
	);

    // Instantiation of Axi Bus Interface M00_AXIS
	M00_AXIS # ( 
		.C_M_AXIS_TDATA_WIDTH(C_AXIS_TDATA_WIDTH),
		.C_M_AXIS_FIFO_DEPTH(C_AXIS_FIFO_DEPTH)
	) M00_AXIS_inst (
		.M_AXIS_ACLK(clk),
		.M_AXIS_ARESETN(resetn),
		.M_AXIS_TVALID(m00_axis_tvalid),
		.M_AXIS_TDATA(m00_axis_tdata),
		.M_AXIS_TSTRB(m00_axis_tstrb),
		.M_AXIS_TLAST(m00_axis_tlast),
		.M_AXIS_TREADY(m00_axis_tready),
		.M_AXIS_TUSER(m00_axis_tuser),
		.data_in(data_out),
		.user_in(user_out),
		.last_in(last_out),
		.wr_en(wr_en),
		.full(full)
	);

	


	 // FSM states
    // Reading and cropping data

	assign cropped_last = ((x == (crop_x + crop_width - 1)) ? 1 : 0) & cropped_valid;
	assign cropped_user = ((x == crop_x && y == crop_y) ? 1 : 0) & cropped_valid;

    always @(posedge clk) begin
        if (!resetn) begin
            x <= 0;
            y <= 0;
            cropping <= 0;
            cropped_valid <= 0;
            // cropped_last <= 0;
            // cropped_user <= 0;
        end else begin
            if (!empty && !full) begin
                read_en <= 1;
				// cropped_last <= 0;
				// cropped_user <= 0;
                if (x >= crop_x && x < crop_x + crop_width &&
                    y >= crop_y && y < crop_y + crop_height) begin
                    cropped_data <= data_in;
                    cropped_valid <= 1;

					// if (x == crop_x && y == crop_y) begin
					// 	cropped_user <= 1;	
					// end else begin
					// 	cropped_user <= 0;
					// end

					// if (x == (crop_x + crop_width - 1)) begin
					// 	cropped_last <= 1;	
					// end else begin
					// 	cropped_last <= 0;
					// end

                end else begin
                    cropped_valid <= 0;
                end

				

                if (last_in) begin
                    x <= 0;
                    y <= y + 1;
				end else if (user_in) begin	
					x <= 0;
                    y <= 0;
                end else begin
                    x <= x + 1;
                end
            end else begin
                read_en <= 0;
            end

			last_out <= cropped_last;
			user_out <= cropped_user;
			data_out <= cropped_data;
            if (cropped_valid && !full) begin
                wr_en <= 1;
            end else begin
                wr_en <= 0;
            end
        end
    end

	endmodule	