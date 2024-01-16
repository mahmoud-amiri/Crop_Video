# VHDL Image Cropping Module Testbench

## Overview
This repository contains the VHDL testbench for an image cropping module. The testbench is designed to simulate and validate the functionality of the `crop` entity, which performs image cropping based on the AXI Stream protocol.

## Description
The testbench (`top_tb`) is structured to simulate an end-to-end environment for the image cropping module. It includes components for generating test data, applying cropping parameters, and verifying the output. The main components and their functionalities are as follows:

1. **Clk_Reset_Gen**: Generates a clock signal (`clk`) and a reset signal (`reset`) to synchronize and initialize the testbench components.

2. **Random_Test_Vector_Top**: Generates random test vectors including random crop dimensions and positions (`x_rand`, `y_rand`, `crop_width_rand`, `crop_height_rand`). These vectors are used to set the cropping parameters for each test frame.

3. **Video_Generator**: Simulates a video stream source, generating a sequence of image frames with control signals (`snk_tdata`, `snk_tvalid`, `snk_tlast`, `snk_tuser`) and a ready signal (`snk_tready`).

4. **Crop**: The main cropping entity under test. It receives the video stream and cropping parameters (`cfg_x_offset`, `cfg_y_offset`, `cfg_cols`, `cfg_rows`) and outputs the cropped video stream (`src_tdata`, `src_tvalid`, `src_tlast`, `src_tuser`).

5. **Video_Properties_Extractor**: Extracts properties from the cropped video stream, such as width, height, and the first pixel of each frame.

6. **Comparator**: Compares the expected cropping dimensions and positions with the actual output from the `crop` entity to verify its functionality.

## Simulation Environment
The testbench is set up in a modular fashion, making it adaptable for various frame sizes and cropping scenarios. It is designed to:

- Generate a clock and reset signal for synchronization.
- Produce test video frames and apply random cropping parameters.
- Process the frames through the `crop` entity.
- Extract properties from the cropped video output.
- Compare and validate the output against the expected results.

## Usage
To use this testbench:

1. Clone the repository.
2. Open the project in your VHDL simulation environment.
3. Run the simulation and observe the output.
4. Verify the functionality of the `crop` entity through the testbench reports.

## Requirements
This testbench is designed for VHDL simulation environments and requires components compatible with the AXI Stream protocol.
