fesvr_hdrs = \
  elf.h \
  elfloader.h \
  htif.h \
  dtm.h \
  memif.h \
  syscall.h \
  context.h \
  htif_pthread.h \
  htif_hexwriter.h \
  option_parser.h \
  term.h \
  device.h \
  rfb.h \
  tsi.h \
  htif_proj.h \
  es1x.h \
  demo.h \

fesvr_srcs = \
  elfloader.cc \
  htif.cc \
  memif.cc \
  dtm.cc \
  syscall.cc \
  device.cc \
  rfb.cc \
  context.cc \
  htif_pthread.cc \
  htif_hexwriter.cc \
  dummy.cc \
  option_parser.cc \
  term.cc \
  tsi.cc \
  es1x.cc \
  demo.cc \

fesvr_install_prog_srcs = \
  elf2hex.cc \
