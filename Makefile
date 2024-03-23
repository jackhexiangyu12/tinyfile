INCDIR := utils
OBJDIR := obj
BINDIR := bin

CC := gcc
CCFLAGS  := -Wall -g -c -DDEBUG=0 -O3
INCLUDES := -I$(INCDIR)
LIBS := -lrt -lpthread

CLIENT := $(BINDIR)/sample_app
SERVER := $(BINDIR)/tinyfile
LIB := $(BINDIR)/libtinyfile.a

.PHONY: all lib client server clean

all: lib client server

client: $(CLIENT)

server: $(SERVER)

lib: $(LIB)

$(LIB): $(OBJDIR)/tinyfile_api.o | $(BINDIR)
	ar rcs $(LIB) $(OBJDIR)/tinyfile_api.o

$(CLIENT): $(OBJDIR)/client.o | $(BINDIR)
	$(CC) -L$(BINDIR) $^ -o $@ -ltinyfile $(LIBS)

$(SERVER): $(OBJDIR)/tinyfile_server.o | $(BINDIR)
	$(CC) utils/snappy-c/snappy.c $^ -o $@ $(LIBS)

$(OBJDIR)/client.o:  client.c | $(OBJDIR)
	$(CC) $(CCFLAGS) $(INCLUDES) client.c -o $@

$(OBJDIR)/tinyfile_api.o:  library.c utils/tinyfile/library.h | $(OBJDIR)
	$(CC) $(CCFLAGS) $(INCLUDES) library.c -o $@ $(LIBS)

$(OBJDIR)/tinyfile_server.o: $(LIB) server.c utils/tinyfile/server.h | $(OBJDIR)
	$(CC) $(CCFLAGS) $(INCLUDES) server.c -o $@

$(BINDIR):
	mkdir -p $@

$(OBJDIR):
	mkdir -p $@

clean:
	rm -f $(OBJDIR)/*.o
	rm $(BINDIR)/* || true
