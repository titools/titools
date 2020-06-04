-stack 0x1000
-heap 0x0
-l "rts6400.lib"

MEMORY
{
  ISRAM0:     o = 0x00000000 l = 0x40
  ISRAM1:     o = 0x00000040 l = 0xFFFC0
}


SECTIONS
{
  .intvecs> ISRAM0
  .c_int0 > ISRAM1
  .text   > ISRAM1
  .cinit  > ISRAM1
  .stack  : fill=0 > ISRAM1
  .bss    > ISRAM1
  .const  > ISRAM1
  .data   > ISRAM1
  .switch > ISRAM1
  .far    > ISRAM1
  .sysmem > ISRAM1
  .cio    > ISRAM1
  .sconst > ISRAM1
  .pinit  > ISRAM1
}

