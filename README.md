# Plan
1. Re-style waybar. 
2. Set up wallpaper picker
3. Maybe some way to change between themes
4. pink (catppuccin red?): 
  - hyprland borders 
  - highlighted text
5. add pacman chasing ghosts maybe 
  - to kitty not to nu (otherwise it shows up in tty)

   
# TODO 
- Figure out how to make pandoc use local revealjs instead of going to unpkg.com.
- Set nixvim to persist cursor location on close
- Set nixvim to persist undo on close
 
# System crashed.

The following is some bits from `journalctl -xb`

## Bluetooth

```
░░ The job identifier is 398.
May 08 11:35:54 nixos kernel: Bluetooth: hci0: Device booted in 24512 usecs
May 08 11:35:54 nixos kernel: Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0041-0041.ddc
May 08 11:35:54 nixos kernel: Bluetooth: hci0: Applying Intel DDC parameters completed
May 08 11:35:54 nixos kernel: Bluetooth: hci0: Firmware timestamp 2024.8 buildtype 1 build 79483
May 08 11:35:54 nixos kernel: input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
May 08 11:35:54 nixos kernel: input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
May 08 11:35:54 nixos kernel: input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
May 08 11:35:54 nixos kernel: input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
May 08 11:35:54 nixos kernel: input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input18
May 08 11:35:54 nixos kernel: input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input19
May 08 11:35:54 nixos kernel: input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input20
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: Microcode SW error detected. Restarting 0x0.
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: Start IWL Error Log Dump:
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: Transport status: 0x0000004A, valid: 6
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: Loaded firmware version: 83.e8f84e98.0 ty-a0-gf-a0-83.ucode
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL    
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x000002F0 | trm_hw_status0
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000000 | trm_hw_status1
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x004DC410 | branchlink2
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x004D233E | interruptlink1
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x004D233E | interruptlink2
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x000068E2 | data1
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000010 | data2
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000000 | data3
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00393059 | beacon time
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00086109 | tsf low
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000000 | tsf hi
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000000 | time gp1
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x0009AE91 | time gp2
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000001 | uCode revision type
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000053 | uCode version major
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0xE8F84E98 | uCode version minor
May 08 11:35:54 nixos systemd[1]: Reached target Sound Card.
░░ Subject: A start job for unit sound.target has finished successfully
░░ Defined-By: systemd
░░ Support: https://lists.freedesktop.org/mailman/listinfo/systemd-devel
```

## BlueZ
```
The job identifier is 1009.
May 08 11:36:07 nixos wireplumber[1564]: Failed to get percentage from UPower: org.freedesktop.DBus.Error.NameHasNoOwner
May 08 11:36:07 nixos wireplumber[1564]: BlueZ system service is not available
May 08 11:36:07 nixos wireplumber[1564]: [0:00:19.370806361] [1564]  INFO IPAManager ipa_manager.cpp:143 libcamera is not installed. Adding >
May 08 11:36:07 nixos wireplumber[1564]: [0:00:19.371800506] [1564]  INFO Camera camera_manager.cpp:284 libcamera v0.2.0
May 08 11:36:15 nixos systemd[1]: NetworkManager-dispatcher.service: Deactivated successfully.
░░ Subject: Unit succeeded
░░ Defined-By: systemd
░░ Support: https://lists.freedesktop.org/mailman/listinfo/systemd-devel
```
## iwlwifi

```
The job identifier is 405.
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000420 | hw version
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00C80002 | board version
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x0000001C | hcmd
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00020000 | isr0
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000000 | isr1
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x48F00002 | isr2
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00C3001C | isr3
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000000 | isr4
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x001D0103 | last cmd Id
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x000068E2 | wait_event
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x000073EB | l2p_control
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000020 | l2p_duration
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000003 | l2p_mhvalid
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00001800 | l2p_addr_match
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000009 | lmpm_pmg_sel
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000000 | timestamp
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00003058 | flow_handler
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: Start IWL Error Log Dump:
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: Transport status: 0x0000004A, valid: 7
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x2010190E | ADVANCED_SYSASSERT
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000000 | umac branchlink1
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x8046DA58 | umac branchlink2
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0xC00814E0 | umac interruptlink1
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000000 | umac interruptlink2
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x0101F71C | umac data1
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0xDEADBEEF | umac data2
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0xDEADBEEF | umac data3
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000053 | umac major
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0xE8F84E98 | umac minor
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x0009AE8B | frame pointer
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0xC0886BE0 | stack pointer
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x0025010D | last host cmd
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000000 | isr status reg
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: IML/ROM dump:
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000B03 | IML/ROM error/state
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x000086DD | IML/ROM data1
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x000086DD | IML/ROM data1
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000090 | IML/ROM WFPM_AUTH_KEY_0
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: Fseq Registers:
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x60000000 | FSEQ_ERROR_CODE
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00440007 | FSEQ_TOP_INIT_VERSION
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x0000A652 | FSEQ_OTP_VERSION
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00400410 | FSEQ_CNVI_ID
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00400410 | FSEQ_CNVR_ID
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00080009 | FSEQ_PREV_CNVIO_INIT_VERSION
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00440007 | FSEQ_WIFI_FSEQ_VERSION
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x00440007 | FSEQ_BT_FSEQ_VERSION
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: 0x000000DC | FSEQ_CLASS_TP_VERSION
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: UMAC CURRENT PC: 0x8048da0c
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: LMAC1 CURRENT PC: 0xd0
May 08 11:35:54 nixos kernel: iwlwifi 0000:a6:00.0: WRT: Collecting data: ini trigger 4 fired (delay=0ms).
May 08 11:35:54 nixos kernel: ieee80211 phy0: Hardware restart was requested
May 08 11:35:55 nixos kernel: iwlwifi 0000:a6:00.0: WRT: Invalid buffer destination
May 08 11:35:55 nixos kernel: iwlwifi 0000:a6:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
May 08 11:35:55 nixos kernel: iwlwifi 0000:a6:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
May 08 11:35:55 nixos kernel: iwlwifi 0000:a6:00.0: WFPM_AUTH_KEY_0: 0x90
May 08 11:35:55 nixos kernel: iwlwifi 0000:a6:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
May 08 11:35:55 nixos wpa_supplicant[1109]: wlp166s0: CTRL-EVENT-REGDOM-CHANGE init=DRIVER type=WORLD
May 08 11:35:55 nixos systemd[1]: Finished Network Manager Wait Online.
░░ Subject: A start job for unit NetworkManager-wait-online.service has finished successfully
░░ Defined-By: systemd
░░ Support: https://lists.freedesktop.org/mailman/listinfo/systemd-devel
░░ 
░░ A start job for unit NetworkManager-wait-online.service has finished successfully.
```

## PAM 
```
May 08 11:53:13 nixos sudo[25725]: pam_unix(sudo:auth): conversation failed
May 08 11:53:13 nixos sudo[25725]: pam_unix(sudo:auth): auth could not identify password for [sour]
```


