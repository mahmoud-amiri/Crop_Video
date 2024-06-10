    
    `timescale 1 ns / 1 ps

	module crop_vid #(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXIS
		parameter C_S00_AXIS_TDATA_WIDTH	= 32,

		// Parameters of Axi Master Bus Interface M00_AXIS
		parameter C_M00_AXIS_TDATA_WIDTH	= 32,
		parameter C_M00_AXIS_START_COUNT	= 32
	)(
		// Users to add ports here
        input wire [15:0] crop_x,
        input wire [15:0] crop_y,
        input wire [15:0] crop_width,
        input wire [15:0] crop_height,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXIS
		input wire  s00_axis_aclk,
		input wire  s00_axis_aresetn,
		output wire  s00_axis_tready,
		input wire [C_S00_AXIS_TDATA_WIDTH-1 : 0] s00_axis_tdata,
		input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1 : 0] s00_axis_tstrb,
		input wire  s00_axis_tlast,
		input wire  s00_axis_tvalid,
        input wire s00_axis_tuser,

		// Ports of Axi Master Bus Interface M00_AXIS
		input wire  m00_axis_aclk,
		input wire  m00_axis_aresetn,
		output wire  m00_axis_tvalid,
		output wire [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata,
		output wire [(C_M00_AXIS_TDATA_WIDTH/8)-1 : 0] m00_axis_tstrb,
		output wire  m00_axis_tlast,
        output wire m00_axis_tuser,
		input wire  m00_axis_tready
	);
    // Instantiation of Axi Bus Interface S00_AXIS
	S00_AXIS # ( 
		.C_S_AXIS_TDATA_WIDTH(C_S00_AXIS_TDATA_WIDTH)
	) S00_AXIS_inst (
		.S_AXIS_ACLK(s00_axis_aclk),
		.S_AXIS_ARESETN(s00_axis_aresetn),
		.S_AXIS_TREADY(s00_axis_tready),
		.S_AXIS_TDATA(s00_axis_tdata),
		.S_AXIS_TSTRB(s00_axis_tstrb),
		.S_AXIS_TLAST(s00_axis_tlast),
		.S_AXIS_TVALID(s00_axis_tvalid)
	);

    // Instantiation of Axi Bus Interface M00_AXIS
	M00_AXIS # ( 
		.C_M_AXIS_TDATA_WIDTH(C_M00_AXIS_TDATA_WIDTH),
		.C_M_START_COUNT(C_M00_AXIS_START_COUNT)
	) M00_AXIS_inst (
		.M_AXIS_ACLK(m00_axis_aclk),
		.M_AXIS_ARESETN(m00_axis_aresetn),
		.M_AXIS_TVALID(m00_axis_tvalid),
		.M_AXIS_TDATA(m00_axis_tdata),
		.M_AXIS_TSTRB(m00_axis_tstrb),
		.M_AXIS_TLAST(m00_axis_tlast),
		.M_AXIS_TREADY(m00_axis_tready)
	);

	
    // Internal signals
	reg [C_S00_AXIS_TDATA_WIDTH-1 : 0] cropped_data;
	reg cropped_valid, cropped_last, cropped_user;
	wire axis_handshake;

	// Coordinates of the current pixel
	reg [15:0] x, y;

	assign axis_handshake = s00_axis_tvalid && s00_axis_tready;

	// Handshaking signals
	assign s00_axis_tready = m00_axis_tready;

	// Output signals
	assign m00_axis_tvalid = cropped_valid;
	assign m00_axis_tdata = cropped_data;
	assign m00_axis_tstrb = {(C_M00_AXIS_TDATA_WIDTH/8){1'b1}};
	assign m00_axis_tlast = cropped_last;
	assign m00_axis_tuser = cropped_user;
	assign m00_axis_aresetn = s00_axis_aresetn;
	assign m00_axis_aclk = s00_axis_aclk;

	// Process the incoming data
	always @(posedge s00_axis_aclk) begin
		if (!s00_axis_aresetn) begin
			x <= 0;
			y <= 0;
			cropped_valid <= 0;
			cropped_last <= 0;
			cropped_user <= 0;
			cropped_data <= 0;
		end else if (axis_handshake) begin
			if (x >= crop_x && x < crop_x + crop_width && y >= crop_y && y < crop_y + crop_height) begin
				cropped_data <= s00_axis_tdata;
				cropped_valid <= 1;
				cropped_last <= s00_axis_tlast;
				cropped_user <= (x == crop_x && y == crop_y) ? s00_axis_tuser : 0;
			end else begin
				cropped_data <= 0;
				cropped_valid <= 0;
				cropped_last <= 0;
				cropped_user <= 0;
			end

			if (s00_axis_tlast) begin
				x <= 0;
				if (y == (crop_y + crop_height - 1)) begin
					y <= 0;
				end else begin
					y <= y + 1;
				end
			end else begin
				x <= x + 1;
			end

			if (s00_axis_tuser) begin
				x <= 0;
				y <= 0;
			end
		end
	end
	endmodule	