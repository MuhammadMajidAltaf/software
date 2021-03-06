# ----------------------------------------------------------------------------
#       _____
#      *     *
#     *____   *____
#    * *===*   *==*
#   *___*===*___**  AVNET
#        *======*
#         *====*
# ----------------------------------------------------------------------------
# 
#  This design is the property of Avnet.  Publication of this
#  design is not authorized without written consent from Avnet.
# 
#  Please direct any questions to the UltraZed community support forum:
#     http://www.ultrazed.org/forum
# 
#  Product information is available at:
#     http://www.ultrazed.org/product/ultrazed-EG
# 
#  Disclaimer:
#     Avnet, Inc. makes no warranty for the use of this code or design.
#     This code is provided  "As Is". Avnet, Inc assumes no responsibility for
#     any errors, which may appear in this code, nor does it make a commitment
#     to update the information contained herein. Avnet, Inc specifically
#     disclaims any implied warranties of fitness for a particular purpose.
#                      Copyright(c) 2016 Avnet, Inc.
#                              All rights reserved.
# 
# ----------------------------------------------------------------------------
# 
#  Create Date:         Aug 15, 2016
#  Design Name:         Avnet UltraZed-3EG SOM PetaLinux BSP Generator
#  Module Name:         clean_uz3eg_petalinux_bsp.tcl
#  Project Name:        Avnet UltraZed-3EG SOM  PetaLinux BSP Generator
#  Target Devices:      Xilinx Zynq Ultrascale MPSoC
#  Hardware Boards:     Avnet UltraZed-3EG SOM and IOCC (UZ3EG_IOCC)
# 
#  Tool versions:       Xilinx Vivado 2016.2
# 
#  Description:         Build Script for UZ3EG PetaLinux BSP HW Platform
# 
#  Dependencies:        None
#
#  Revision:            Aug 15, 2016: 1.00 Initial version
# 
# ----------------------------------------------------------------------------

#!/bin/bash

# Set global variables here.
APP_PETALINUX_INSTALL_PATH=/opt/petalinux-v2016.2-final
APP_VIVADO_INSTALL_PATH=/opt/Xilinx/Vivado/2016.2
BUILD_BOOT_EMMC_OPTION=yes
BUILD_BOOT_EMMC_OOB_OPTION=yes
BUILD_BOOT_EMMC_NO_BIT_OPTION=no
BUILD_BOOT_SD_OPTION=yes
BUILD_BOOT_SD_OOB_OPTION=yes
BUILD_BOOT_SD_NO_BIT_OPTION=no
FSBL_PROJECT_NAME=zynqmp_fsbl
HDL_HARDWARE_NAME=uz_petalinux_hw
HDL_PROJECT_NAME=uz_petalinux
HDL_PROJECTS_FOLDER=../../../hdl/Projects
HDL_SCRIPTS_FOLDER=../../../hdl/Scripts
PETALINUX_APPS_FOLDER=../../../software/petalinux/apps
PETALINUX_CONFIGS_FOLDER=../../../software/petalinux/configs
PETALINUX_PROJECTS_FOLDER=../../../software/petalinux/projects
PETALINUX_SCRIPTS_FOLDER=../../../software/petalinux/scripts
START_FOLDER=`pwd`

source_tools_settings ()
{
  # Source the tools settings scripts so that both Vivado and PetaLinux can 
  # be used throughout this build script.
  source ${APP_VIVADO_INSTALL_PATH}/settings64.sh
  source ${APP_PETALINUX_INSTALL_PATH}/settings.sh
}

petalinux_project_restore_boot_config ()
{
  # Restore original PetaLinux project config. Don't forget that the
  # petalinux_project_save_boot_config () should have been called at some
  # point before this function gets called, otherwise there probably is
  # nothing there to restore.
  echo " "
  echo "Restoring original PetaLinux project config ..."
  echo " "
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/
  cp config.orig config
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}

  # Restore original U-Boot config. 
  echo " "
  echo "Restoring original U-Boot project config ..."
  echo " "
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/configs/u-boot/
  cp config.orig config
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}

  # Restore original U-Boot top level configuration.
  echo " "
  echo "Restoring original U-Boot top level configuration..."
  echo " "
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/configs/u-boot
  cp platform-top.h.orig platform-top.h
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}

  # Restore original U-Boot environment configuration.
  echo " "
  echo "Restoring original U-Boot environment configuration ..."
  echo " "
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/configs/u-boot
  cp platform-auto.h.orig platform-auto.h
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}
}

petalinux_project_save_boot_config ()
{
  # Save original PetaLinux project config.
  echo " "
  echo "Saving original PetaLinux project config ..."
  echo " "
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/
  cp config config.orig
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}

  # Save original U-Boot config.
  echo " "
  echo "Saving original U-Boot config ..."
  echo " "
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/configs/u-boot/
  cp config config.orig
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}

  # Save original U-Boot top level configuration.
  echo " "
  echo "Saving original U-Boot top level configuration..."
  echo " "
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/configs/u-boot
  cp platform-top.h platform-top.h.orig
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}

  # Save original U-Boot environment configuration.
  echo " "
  echo "Saving original U-Boot environment configuration ..."
  echo " "
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/configs/u-boot
  cp platform-auto.h platform-auto.h.orig
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}
}

petalinux_project_set_boot_config_emmc ()
{ 
  # Add support for eMMC boot to U-Boot environment configuration.
  echo " "
  echo "Applying patch to add eMMC boot support in U-Boot ..."
  echo " "
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/configs/u-boot
  patch < ${START_FOLDER}/${PETALINUX_CONFIGS_FOLDER}/u-boot/platform-top.h.UZ3EG_IOCC.emmc_boot.patch
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}
}

petalinux_project_set_boot_config_emmc_no_bit ()
{ 
  # Change PetaLinux project config to boot from eMMC (via QSPI).
  echo " "
  echo "Patching project config for eMMC boot support..."
  echo " "
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/
  patch < ${START_FOLDER}/${PETALINUX_CONFIGS_FOLDER}/config.emmc_boot.patch
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}

  # Add support for eMMC commands to U-Boot top level configuration which
  # allows for bistream to be loaded from eMMC instead of BOOT.BIN in QSPI
  # flash.
  echo " "
  echo "Applying patch to add eMMC bitstream load support in U-Boot ..."
  echo " "
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/configs/u-boot
  patch < ${START_FOLDER}/${PETALINUX_CONFIGS_FOLDER}/u-boot/platform-top.h.emmc_boot_no_bit.patch
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}

  # Add support for QSPI + eMMC boot to U-Boot environment configuration.
  echo " "
  echo "Applying patch to add QSPI + eMMC boot support in U-Boot ..."
  echo " "
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/configs/u-boot
  patch < ${START_FOLDER}/${PETALINUX_CONFIGS_FOLDER}/u-boot/platform-auto.h.emmc_boot.patch
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}
}

petalinux_project_set_boot_config_sd ()
{ 
  # Add support for SD commands to U-Boot top level configuration in which
  # bistream has already been loaded from the BOOT.BIN container file.
  # Add support for eMMC boot to U-Boot environment configuration.
  echo " "
  echo "Applying patch to add SD boot support in U-Boot ..."
  echo " "
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/configs/u-boot
  patch < ${START_FOLDER}/${PETALINUX_CONFIGS_FOLDER}/u-boot/platform-top.h.UZ3EG_IOCC.sd_boot.patch
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}
}

petalinux_project_set_boot_config_sd_no_bit ()
{ 
  # Add support for SD commands to U-Boot top level configuration which
  # allows for bistream to be loaded from SD file instead of the BOOT.BIN 
  # container file.
  echo " "
  echo "Applying patch to add SD bitstream load support in U-Boot ..."
  echo " "
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/configs/u-boot
  patch < ${START_FOLDER}/${PETALINUX_CONFIGS_FOLDER}/u-boot/platform-auto.h.sd_boot_no_bit.patch
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}
}

petalinux_project_set_boot_config_qspi ()
{ 
  # Change PetaLinux project config to boot from QSPI.
  echo " "
  echo "Patching project config for QSPI boot support..."
  echo " "
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/
  patch < ${START_FOLDER}/${PETALINUX_CONFIGS_FOLDER}/config.qspi_boot.patch
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}

  # Add support for QSPI boot to U-Boot environment configuration.
  echo " "
  echo "Applying patch to add QSPI boot support in U-Boot ..."
  echo " "
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/configs/u-boot
  patch < ${START_FOLDER}/${PETALINUX_CONFIGS_FOLDER}/u-boot/platform-auto.h.UZ3EG_IOCC.qspi_boot.patch
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}
}

create_petalinux_bsp ()
{ 
  # This function is responsible for creating a PetaLinux BSP around the
  # hardware platform specificed in HDL_PROJECT_NAME variable and build
  # the PetaLinux project within the folder specified by the 
  # PETALINUX_PROJECT_NAME variable.
  #
  # When complete, the BSP should boot from SD card 

  # Check to see if the PetaLinux projects folder even exists because when
  # you clone the source tree from Avnet Github, the projects folder is not
  # part of that tree.
  if [ ! -d ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER} ]; then
    # Create the PetaLinux projects folder.
    mkdir ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}
  fi

  # Change to PetaLinux projects folder.
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}

  # Create the PetaLinux project.
  petalinux-create --type project --template zynqMP --name ${PETALINUX_PROJECT_NAME}

  # Create the hardware definition folder.
  mkdir -p ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/hw_platform

  # Import the hardware definition files and hardware platform bitstream from
  # implemented system products folder.
  cd ${START_FOLDER}/${HDL_PROJECTS_FOLDER}

  echo " "
  echo "Importing hardware definition ${HDL_HARDWARE_NAME} from impl_1 folder ..."
  echo " "

  cp -f ${HDL_PROJECT_NAME}/${HDL_BOARD_NAME}/${HDL_PROJECT_NAME}.runs/impl_1/${HDL_PROJECT_NAME}_wrapper.sysdef \
  ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/hw_platform/${HDL_HARDWARE_NAME}.hdf

  echo " "
  echo "Importing hardware bitstream ${HDL_HARDWARE_NAME} from impl_1 folder ..."
  echo " "

  cp -f ${HDL_PROJECT_NAME}/${HDL_BOARD_NAME}/${HDL_PROJECT_NAME}.runs/impl_1/${HDL_PROJECT_NAME}_wrapper.bit \
  ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/hw_platform/system_wrapper.bit

  # Change directories to the hardware definition folder for the PetaLinux
  # project, at this point the .hdf file must be located in this folder 
  # for the petalinux-config step to be successful.
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}

  # Import the hardware description into the PetaLinux project.
  petalinux-config --oldconfig --get-hw-description=./hw_platform/ -p ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}
 
  # Overwrite the PetaLinux project config with the revision controlled source
  # config.  Use a board specific configuration if available, if not, use the 
  # generic one by default.
  echo " "
  echo "Overwriting PetaLinux project config ..."
  echo " "
  if [ -f ${START_FOLDER}/${PETALINUX_CONFIGS_FOLDER}/config.${HDL_BOARD_NAME} ] 
    then
    cp -rf ${START_FOLDER}/${PETALINUX_CONFIGS_FOLDER}/config.${HDL_BOARD_NAME} \
    ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/config
  else
    cp -rf ${START_FOLDER}/${PETALINUX_CONFIGS_FOLDER}/config.generic \
    ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/config
  fi

  # Create a PetaLinux application named httpd_content.
  petalinux-create --type apps --name httpd_content --enable

  # Copy the httpd_content application information over to the httpd_content 
  # application folder.
  cp -rf ${START_FOLDER}/${PETALINUX_APPS_FOLDER}/httpd_content/* \
  ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/components/apps/httpd_content

  # Create a PetaLinux application named iperf3.
  petalinux-create --type apps --name iperf3 --enable

  # Copy the iperf3 application information over to the iperf3 
  # application folder.
  cp -rf ${START_FOLDER}/${PETALINUX_APPS_FOLDER}/iperf3/* \
  ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/components/apps/iperf3

  # Copy the iperf3 64-bit application binary over to the the iperf3 application
  # folder.
  cp -f ~/demo/iperf/aarch64/src/iperf3 \
  ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/components/apps/iperf3/

  # Create a PetaLinux application named linux_ps_led_blink.
  petalinux-create --type apps --name linux_ps_led_blink --enable

  # Copy the linux_ps_led_blink application information over to the 
  # linux_ps_led_blink application folder.
  cp -rf ${START_FOLDER}/${PETALINUX_APPS_FOLDER}/linux_ps_led_blink/* \
  ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/components/apps/linux_ps_led_blink

  # Create a PetaLinux application named ultrazed_sata_performance_test.
  petalinux-create --type apps --name ultrazed_sata_performance_test --enable

  # Copy the ultrazed_sata_performance_test application information over to the 
  # linux_ps_led_blink application folder.
  cp -rf ${START_FOLDER}/${PETALINUX_APPS_FOLDER}/ultrazed_sata_performance_test/* \
  ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/components/apps/ultrazed_sata_performance_test

  # If the target board is the UZ3EG_IOCC, then build the startup script
  # specific to this board.
  if [ "$HDL_BOARD_NAME" == "UZ3EG_IOCC" ]
  then
    # Create a PetaLinux application named ultrazed_iocc_oob_init.
    petalinux-create --type apps --name ultrazed_iocc_oob_init --enable

    # Copy the ultrazed_oob_init application information over to the 
    # ultrazed_iocc_oob_init application folder.
    cp -rf ${START_FOLDER}/${PETALINUX_APPS_FOLDER}/ultrazed_iocc_oob_init/* \
    ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/components/apps/ultrazed_iocc_oob_init
  fi

  # If the target board is the UZ3EG_PCIEC, then build the startup script
  # specific to this board.
  if [ "$HDL_BOARD_NAME" == "UZ3EG_PCIEC" ]
  then
    # Create a PetaLinux application named ultrazed_pciec_oob_init.
    petalinux-create --type apps --name ultrazed_pciec_oob_init --enable

    # Copy the ultrazed_oob_init application information over to the 
    # ultrazed_pciec_oob_init application folder.
    cp -rf ${START_FOLDER}/${PETALINUX_APPS_FOLDER}/ultrazed_pciec_oob_init/* \
    ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/components/apps/ultrazed_pciec_oob_init
  fi

  # Modify the stock First Stage Boot Loader application source code to 
  # include additional patches specific to the board hardware.

  echo " "
  echo "Modifying stock FSBL code with patches for ${HDL_BOARD_NAME} hardware ..."
  echo " "

  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/components/bootloader/zynqmp_fsbl/
  patch < ${START_FOLDER}/${PETALINUX_CONFIGS_FOLDER}/bootloader/psu_init.c.patch.UZ3EG_IOCC
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}

  # Overwrite the rootfs component config with the revision controlled source
  # config.
  echo " "
  echo "Overwriting rootfs config for ${HDL_BOARD_NAME} hardware ..."
  echo " "
  cp -rf ${START_FOLDER}/${PETALINUX_CONFIGS_FOLDER}/rootfs/config.${HDL_BOARD_NAME} \
  ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/configs/rootfs/config

  # Overwrite the top level devicetree source with the revision controlled
  # source file.
  echo " "
  echo "Overwriting top level devicetree source ..."
  echo " "
  cp -rf ${START_FOLDER}/${PETALINUX_CONFIGS_FOLDER}/device-tree/system-top.dts.uz3eg \
  ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/configs/device-tree/system-top.dts

  # Overwrite the config level devicetree source with the revision controlled
  # source file.
  echo " "
  echo "Overwriting config level devicetree source ..."
  echo " "
  cp -rf ${START_FOLDER}/${PETALINUX_CONFIGS_FOLDER}/device-tree/system-conf.dtsi.uz3eg \
  ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/configs/device-tree/system-conf.dtsi

  # Overwrite the kernel component config with the revision controlled source
  # config.
  echo " "
  echo "Overwriting kernel config ..."
  echo " "
  cp -rf ${START_FOLDER}/${PETALINUX_CONFIGS_FOLDER}/kernel/config.UZ3EG_IOCC \
  ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/subsystems/linux/configs/kernel/config

  # Prepare to modify project configurations.
  petalinux_project_save_boot_config

  # If the QSPI boot option is set, then perform the steps needed to build 
  # BOOT.BIN for booting from QSPI.
  if [ "$BUILD_BOOT_QSPI_OPTION" == "yes" ]
  then
    # Modify the project configuration for QSPI boot.
    petalinux_project_set_boot_config_qspi

    # Make sure that intermediary files get cleaned up.
    petalinux-build -x distclean

    # Build PetaLinux project.
    petalinux-build 

    # Create boot image.
    petalinux-package --boot --fsbl images/linux/${FSBL_PROJECT_NAME}.elf --fpga hw_platform/system_wrapper.bit --uboot --force

    # Copy the boot.bin file and name the new file BOOT_QSPI.bin
    cp ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT.BIN \
    ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT_QSPI.bin
  fi

  # Restore project configurations and wipe out any changes made for special 
  # boot options.
  petalinux_project_restore_boot_config

  # If the EMMC boot option is set, then perform the steps needed to build 
  # BOOT.BIN for booting from eMMC.
  if [ "$BUILD_BOOT_EMMC_OPTION" == "yes" ]
  then
    # Modify the project configuration for EMMC boot.
    petalinux_project_set_boot_config_emmc

    # Make sure that intermediary files get cleaned up.
    petalinux-build -x distclean

    # Build PetaLinux project.
    petalinux-build

    # If the EMMC OOB boot option is set, then perform the steps needed to  
    # build BOOT.BIN for booting from EMMC without any bistream loaded from 
    # the BOOT.BIN container image on the EMMC or from U-Boot during
    # second stage boot.
    if [ "$BUILD_BOOT_EMMC_OOB_OPTION" == "yes" ]
    then
      # Create boot image which does not contain the bistream image.
      petalinux-package --boot --fsbl images/linux/${FSBL_PROJECT_NAME}.elf --uboot --force

      # Copy the boot.bin file and name the new file BOOT_EMMC_OOB.BIN
      cp ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT.BIN \
      ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT_EMMC_OOB.bin
    fi

    # Create boot image.
    petalinux-package --boot --fsbl images/linux/${FSBL_PROJECT_NAME}.elf --fpga hw_platform/system_wrapper.bit --uboot --force

    # Copy the boot.bin file and name the new file BOOT_EMMC.bin
    cp ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT.BIN \
    ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT_EMMC.bin
  fi

  # Restore project configurations and wipe out any changes made for special 
  # boot options.
  petalinux_project_restore_boot_config

  # If the EMMC boot option is set, then perform the steps needed to build 
  # BOOT.BIN for booting from QSPI + eMMC with the bistream loaded from eMMC
  # instead of from BOOT.BIN image in QSPI.
  if [ "$BUILD_BOOT_EMMC_NO_BIT_OPTION" == "yes" ]
  then
    # Modify the project configuration for EMMC boot.
    petalinux_project_set_boot_config_emmc_no_bit

    # Make sure that intermediary files get cleaned up.
    petalinux-build -x distclean

    # Build PetaLinux project.
    petalinux-build 

    # Create boot imagewhich does not contain the bistream image.
    petalinux-package --boot --fsbl images/linux/${FSBL_PROJECT_NAME}.elf --uboot --force

    # Copy the boot.bin file and name the new file BOOT_EMMC_No_Bit.BIN
    cp ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT.BIN \
    ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT_EMMC_No_Bit.BIN

    # Create a temporary Vivado TCL script which take the standard bitstream 
    # file format and modify it to allow u-boot to load it into the 
    # programmable logic on the Zynq device via PCAP interface.
    echo "write_cfgmem -format bin -interface spix1 -loadbit \"up 0x0 hw_platform/system_wrapper.bit\" -force images/linux/system.bit.bin" > swap_bits.tcl
    
    # Launch vivado in batch mode to clean output products from the hardware platform.
    vivado -mode batch -source swap_bits.tcl

    # Remove the temporary Vivado script.
    rm -f swap_bits.tcl
  fi

  # Restore project configurations and wipe out any changes made for special 
  # boot options.
  petalinux_project_restore_boot_config

  # If the SD no bit boot option is set, then perform the steps needed to  
  # build BOOT.BIN for booting from SD with the bistream loaded from a file
  # on the SD card instead of from the BOOT.BIN container image.
  if [ "$BUILD_BOOT_SD_NO_BIT_OPTION" == "yes" ]
  then
    # Modify the project configuration for sd boot.
    petalinux_project_set_boot_config_sd_no_bit

    # Make sure that intermediary files get cleaned up.
    petalinux-build -x distclean

    # Build PetaLinux project.
    petalinux-build 

    # Create boot image which does not contain the bistream image.
    petalinux-package --boot --fsbl images/linux/${FSBL_PROJECT_NAME}.elf --uboot --force

    # Copy the boot.bin file and name the new file BOOT_SD_No_Bit.BIN
    cp ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT.BIN \
    ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT_SD_No_Bit.BIN

    # Create a temporary Vivado TCL script which take the standard bitstream 
    # file format and modify it to allow u-boot to load it into the 
    # programmable logic on the Zynq device via PCAP interface.
    echo "write_cfgmem -format bin -interface spix1 -loadbit \"up 0x0 hw_platform/system_wrapper.bit\" -force images/linux/system.bit.bin" > swap_bits.tcl
    
    # Launch vivado in batch mode to clean output products from the hardware platform.
    vivado -mode batch -source swap_bits.tcl

    # Remove the temporary Vivado script.
    rm -f swap_bits.tcl
  fi

  # Restore project configurations and wipe out any changes made for special 
  # boot options.
  petalinux_project_restore_boot_config

  # If the SD boot option is set, then perform the steps needed to  
  # build BOOT.BIN for booting from SD with the bistream loaded from 
  # the BOOT.BIN container image on the SD card.
  if [ "$BUILD_BOOT_SD_OPTION" == "yes" ]
  then
    # Modify the project configuration for sd boot.
    petalinux_project_set_boot_config_sd

    # Make sure that intermediary files get cleaned up.
    petalinux-build -x distclean

    # Build PetaLinux project.
    petalinux-build 

    # If the SD OOB boot option is set, then perform the steps needed to  
    # build BOOT.BIN for booting from SD without any bistream loaded from 
    # the BOOT.BIN container image on the SD card or from U-Boot during
    # second stage boot.
    if [ "$BUILD_BOOT_SD_OOB_OPTION" == "yes" ]
    then
      # Create boot image which does not contain the bistream image.
      petalinux-package --boot --fsbl images/linux/${FSBL_PROJECT_NAME}.elf --uboot --force

      # Copy the boot.bin file and name the new file BOOT_SD_OOB.BIN
      cp ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT.BIN \
      ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT_SD_OOB.bin
    fi

    # Create boot image which DOES contain the bistream image.
    petalinux-package --boot --fsbl images/linux/${FSBL_PROJECT_NAME}.elf --fpga hw_platform/system_wrapper.bit --uboot --force

    # Copy the boot.bin file and name the new file BOOT_SD.BIN
    cp ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT.BIN \
    ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT_SD.bin
  fi
  
  # Change to HDL scripts folder.
  cd ${START_FOLDER}/${HDL_SCRIPTS_FOLDER}

  # Clean the hardware project output products using the HDL TCL scripts.
  echo "set argv [list board=${HDL_BOARD_NAME} project=${HDL_PROJECT_NAME} clean=yes jtag=yes version_override=yes]" > cleanup.tcl
  echo "set argc [llength \$argv]" >> cleanup.tcl
  echo "source ./make.tcl -notrace" >> cleanup.tcl

  # Launch vivado in batch mode to clean output products from the hardware platform.
  vivado -mode batch -source cleanup.tcl

  # Change to PetaLinux project folder.
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/

  # Package the bitstream within the PetaLinux pre-built folder.
  petalinux-package --prebuilt --fpga hw_platform/system_wrapper.bit

  # Copy the template Makefile over to the PetaLinux project folder. This 
  # Makefile template can later be customized as desired. 
  cp -f ${START_FOLDER}/${PETALINUX_CONFIGS_FOLDER}/Makefile \
  ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/

  # Rename the pre-built bitstream file to download.bit so that the default 
  # format for the petalinux-boot command over jtag will not need the bit file 
  # specified explicitly.
  mv -f pre-built/linux/implementation/system_wrapper.bit \
  pre-built/linux/implementation/download.bit

  # Change to PetaLinux projects folder.
  cd ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/

  # Copy the BOOT_SD.BIN to the pre-built images folder.
  cp ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT_SD.bin \
  ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/pre-built/linux/images/

  # If the BOOT_SD_OOB_OPTION is set, copy the BOOT_SD_OOB.BIN to the 
  # pre-built images folder.
  if [ "$BUILD_BOOT_SD_OOB_OPTION" == "yes" ]
  then
    cp ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT_SD_OOB.bin \
    ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/pre-built/linux/images/
  fi
  
  # If the BOOT_QSPI_OPTION is set, copy the BOOT_QSPI.BIN to the 
  # pre-built images folder.
  if [ "$BUILD_BOOT_QSPI_OPTION" == "yes" ]
  then
    cp ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT_QSPI.bin \
    ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/pre-built/linux/images/
  fi

  # If the BOOT_EMMC_OPTION is set, copy the BOOT_EMMC.BIN to the 
  # pre-built images folder.
  if [ "$BUILD_BOOT_EMMC_OPTION" == "yes" ]
  then
    cp ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT_EMMC.bin \
    ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/pre-built/linux/images/
  fi

  # If the BOOT_EMMC_OOB_OPTION is set, copy the BOOT_EMMC_OOB.BIN to the 
  # pre-built images folder.
  if [ "$BUILD_BOOT_EMMC_OOB_OPTION" == "yes" ]
  then
    cp ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT_EMMC_OOB.bin \
    ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/pre-built/linux/images/

    cp ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/image.ub \
    ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/pre-built/linux/images/image.oob.ub
  fi

  # If the BOOT_EMMC_NO_BIT_OPTION is set, copy the BOOT_EMMC_No_Bit.BIN and 
  # the system.bit.bin files into the pre-built images folder.
  if [ "$BUILD_BOOT_EMMC_NO_BIT_OPTION" == "yes" ]
  then
    cp ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT_EMMC_No_Bit.BIN \
    ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/pre-built/linux/images/

    cp ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/system.bit.bin \
    ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/pre-built/linux/images/
  fi

  # If the BOOT_SD_NO_BIT_OPTION is set, copy the BOOT_SD_No_Bit.BIN and 
  # the system.bit.bin files into the pre-built images folder.
  if [ "$BUILD_BOOT_SD_NO_BIT_OPTION" == "yes" ]
  then
    cp ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/BOOT_SD_No_Bit.BIN \
    ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/pre-built/linux/images/

    cp ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/images/linux/system.bit.bin \
    ${START_FOLDER}/${PETALINUX_PROJECTS_FOLDER}/${PETALINUX_PROJECT_NAME}/pre-built/linux/images/
  fi

  # Package the hardware source into a BSP package output.
  petalinux-package --bsp -p ${PETALINUX_PROJECT_NAME} \
  --hwsource ${START_FOLDER}/${HDL_PROJECTS_FOLDER}/${HDL_PROJECT_NAME}/${HDL_BOARD_NAME}/ \
  --output ${PETALINUX_PROJECT_NAME}

  # Append the template Makefile to the PetaLinux BSP package. 
  gzip -dc ${PETALINUX_PROJECT_NAME}.bsp >${PETALINUX_PROJECT_NAME}.tar
  cp -f ${START_FOLDER}/${PETALINUX_CONFIGS_FOLDER}/Makefile .
  tar --append ${PETALINUX_PROJECT_NAME}/Makefile -f ${PETALINUX_PROJECT_NAME}.tar
  gzip -c ${PETALINUX_PROJECT_NAME}.tar > ${PETALINUX_PROJECT_NAME}.bsp
  rm -f Makefile
  rm -f ${PETALINUX_PROJECT_NAME}.tar

  # Change to PetaLinux scripts folder.
  cd ${START_FOLDER}/${PETALINUX_SCRIPTS_FOLDER}
}

main_make_function ()
{
  # This function is responsible for first creating all of the hardware
  # platforms needed for generating PetaLinux BSPs and once the hardware
  # platforms are ready, they can be specificed in HDL_BOARD_NAME variable 
  # before the call to create_petalinux_bsp.
  #
  # Once the PetaLinux BSP creation is complete, a BSP package file with the
  # name specified in the PETALINUX_PROJECT_NAME variable can be distributed
  # for use to others.

  #
  # Create the hardware platforms for the supported targets.
  #

  # Change to HDL scripts folder.
  cd ${START_FOLDER}/${HDL_SCRIPTS_FOLDER}

  # Launch vivado in batch mode to build hardware platforms for target
  # boards.
  vivado -mode batch -source make_${HDL_PROJECT_NAME}.tcl

  #
  # Create the PetaLinux BSP for the UZ3EG_IOCC target.
  #
  HDL_BOARD_NAME=UZ3EG_IOCC
  PETALINUX_PROJECT_NAME=uz3eg_iocc_2016_2
  create_petalinux_bsp

  #
  # Create the PetaLinux BSP for the UZ3EG_PCIEC target.
  #
  HDL_BOARD_NAME=UZ3EG_PCIEC
  PETALINUX_PROJECT_NAME=uz3eg_pciec_2016_2
  create_petalinux_bsp

}

# First source any tools scripts to setup the environment needed to call both
# PetaLinux and Vivado from this make script.
source_tools_settings

# Call the main_make_function declared above to start building everything.
main_make_function

