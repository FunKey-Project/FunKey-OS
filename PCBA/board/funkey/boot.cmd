setenv bootargs console=ttyS0,115200
setenv fdt_high 0xffffffff
bootm 0x41000000 0x41b00000 0x41800000
