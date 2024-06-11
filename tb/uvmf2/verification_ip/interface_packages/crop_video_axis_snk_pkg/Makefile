# crop_video_axis_snk interface packages source
# pragma uvmf custom additional begin
# pragma uvmf custom additional end

crop_video_axis_snk_PKG         ?= \
	+incdir+$(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_axis_snk_pkg \
	-F $(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_axis_snk_pkg/crop_video_axis_snk_filelist_hvl.f 

crop_video_axis_snk_PKG_HDL         ?= \
	+incdir+$(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_axis_snk_pkg \
	-F $(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_axis_snk_pkg/crop_video_axis_snk_filelist_hdl.f 

crop_video_axis_snk_PKG_XRTL         ?= \
	+incdir+$(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_axis_snk_pkg \
	-F $(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_axis_snk_pkg/crop_video_axis_snk_filelist_xrtl.f 

COMP_crop_video_axis_snk_PKG_TGT_0 = q_comp_crop_video_axis_snk_pkg
COMP_crop_video_axis_snk_PKG_TGT_1 = v_comp_crop_video_axis_snk_pkg
COMP_crop_video_axis_snk_PKG_TGT = $(COMP_crop_video_axis_snk_PKG_TGT_$(USE_VELOCE))

comp_crop_video_axis_snk_pkg: $(COMP_crop_video_axis_snk_PKG_TGT) 

q_comp_crop_video_axis_snk_pkg:
	$(HDL_COMP_CMD) $(crop_video_axis_snk_PKG_HDL)
	$(HVL_COMP_CMD) $(crop_video_axis_snk_PKG)
	$(HDL_COMP_CMD) $(crop_video_axis_snk_PKG_XRTL) 

v_comp_crop_video_axis_snk_pkg:
	$(HVL_COMP_CMD) $(crop_video_axis_snk_PKG_HDL)
	$(HVL_COMP_CMD) $(crop_video_axis_snk_PKG)
	$(VELANALYZE_CMD) $(crop_video_axis_snk_PKG_HDL) 
	$(VELANALYZE_HVL_CMD) $(crop_video_axis_snk_PKG) 
	$(HDL_COMP_CMD) $(crop_video_axis_snk_PKG_XRTL)

ifeq ($(MTI_VCO_MODE),64)
  GCC_COMP_ARCH = -m64
else
  GCC_COMP_ARCH = -m32
endif

export crop_video_axis_snk_IF_DPI_SRC ?= $(UVMF_VIP_LIBRARY_HOME)/interface_packages/crop_video_axis_snk_pkg/dpi

C_FILE_COMPILE_LIST_crop_video_axis_snk_pkg	?= \

O_FILE_COMPILE_LIST_crop_video_axis_snk_pkg ?= $(notdir $(C_FILE_COMPILE_LIST_crop_video_axis_snk_pkg:.c=.o))

GCC_COMP_ARGS_crop_video_axis_snk_pkg	+= -I$(crop_video_axis_snk_IF_DPI_SRC) \
	-fPIC 

GCC_COMP_ARGS_crop_video_axis_snk_pkg	+= $(crop_video_axis_snk_IF_GCC_COMP_ARGUMENTS)

GCC_LINK_ARGS_crop_video_axis_snk_pkg	+= \
	 \
 	-o .so

comp_crop_video_axis_snk_pkg_c_files:
	@echo "--------------------------------"
	@echo "Compiling Interface C source"
	@echo "--------------------------------"
	gcc $(GCC_COMP_ARCH) $(GCC_COMP_ARGS_crop_video_axis_snk_pkg) $(C_FILE_COMPILE_LIST_crop_video_axis_snk_pkg)
	@echo "--------------------------------"
	@echo "Linking Interface C objects into a shared object"
	@echo "--------------------------------"
	gcc $(GCC_COMP_ARCH) $(GCC_LINK_ARGS_crop_video_axis_snk_pkg) $(O_FILE_COMPILE_LIST_crop_video_axis_snk_pkg)
	@echo "--------------------------------"

