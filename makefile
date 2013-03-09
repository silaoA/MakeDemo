#makefile��ϸ�ڣ�
#1.ÿ��������治Ҫ������Ŀո�
#2.wincmd��linux�µ�shell���Ŀ¼��ʾ��ͬ
#3.CINCS = -I.\includes ��I��.֮�䲻���пո�

#������������ĺ���
 #$@  �������ɹ����У���ʾ��ǰĿ�� 
 #$<  �������ɹ����У���ʾ��ǰĿ��ĵ�һ������Ŀ��
 #$^  �������ɹ����У���ʾ��ǰĿ�����������Ŀ��
 
 #########################################################
 #��makefile��Ӧ�Ĺ���Ŀ¼��֯
 # ./ ------- project root
 #   +sources/
 #   +includes/
 #   +objs/
 #    TARGET
 #    makefile
 #�޸�ʱ������ʵ�ʸı���Ӧ��Ŀ¼������������./sources��Դ�ļ��б�
 #########################################################
 
TARGET = demo.exe 

#SYSTEM = wincmd
SYSTEM = linux

##########Ŀ¼���� ##########
####���̸�Ŀ¼
PROJECT_ROOT = .
###Դ�����Ŀ¼####

ifeq ($(SYSTEM),wincmd)
#CԴ����
SRC_DIR = $(PROJECT_ROOT)\sources

#�м�Ŀ���ļ�Ŀ¼
OBJS_DIR := $(PROJECT_ROOT)\objs
#�����н��������������ò�Ҫ��ĩβ��\��б������addprefix
else
SRC_DIR = $(PROJECT_ROOT)/sources

OBJS_DIR := $(PROJECT_ROOT)/objs
endif


APP_CSRCS = printA.c printB.c main.c

############## ���·�� #############
ifeq ($(SYSTEM),wincmd)

ifdef APP_CSRCS
CSRCS := $(addprefix $(SRC_DIR)\,$(APP_CSRCS))
endif
#CSRCS = $(APP_CSRCS)
#ò�����������Ҳ������ո�

#Ŀ���ļ����壬��·����ӽ���
COBJS := $(addprefix $(OBJS_DIR)\, $(patsubst %.c,%.o,$(notdir $(CSRCS))))

else

ifdef APP_CSRCS
CSRCS := $(addprefix $(SRC_DIR)/,$(APP_CSRCS))
endif
#Ŀ���ļ����壬��·����ӽ���
COBJS := $(addprefix $(OBJS_DIR)/, $(patsubst %.c,%.o,$(notdir $(CSRCS))))

endif


###########�������������#########
CC = gcc 
#ע�� ���ں��൱��C�����еĺ궨��

ifeq ($(SYSTEM),wincmd)
RM = del  
#ע�� wincmd�½����ںź����rm��Ϊdel��linux��RM = rm

#ͷ�ļ�Ŀ¼
INC_DIR := .\includes 
#��������ͷ�ļ�Ŀ¼����ֱ�Ӻ������Ŀ¼���� ע��ǰ���-I

else
RM = rm
#ע�� wincmd�½����ںź����rm��Ϊdel��linux��RM = rm

#ͷ�ļ�Ŀ¼
INC_DIR := ./includes 
endif

#����ѡ��
CFLAGS = -g -Wall
CFLAGS += -I$(INC_DIR)
#all : version $(target)
all : $(TARGET)

version :
	@echo Show GCC Version
	$(CC) --version
	
$(TARGET) : $(COBJS)
	@echo ����Ŀ���ļ�����������target -- $@
	$(CC)  $(COBJS) -o $@ 
	
# ����C���򣬴˹����д������Ҫ������
##################################  ������c��o�ļ��� ##############################
#��1��ֱ����Ŀ¼�����%��������κ�'\'����������ȷ��$(OBJS_DIR)\%.o : $(SRC_DIR)\%.c��д��
#����\%��ת������������(��������win�µ�Ŀ¼�ָ���)������$(OBJS_DIR)\\%.o : $(SRC_DIR)\%.c��ȷ
#��2��ͬʱ��������\\��ȴ���� .\sources\\printA.c --> .\objs\printA.o(�����)��
#��3�б����ǰ�Ŀ���ļ���Դ�ļ���ֱ���г������������make��������
#��4��5�д���ͬ��3�У�makeҲ������
ifeq ($(SYSTEM),wincmd)
$(OBJS_DIR)%.o : $(SRC_DIR)%.c
#$(OBJS_DIR)\\%.o : $(SRC_DIR)\\%.c
#$(COBJS)%.o:$(CSRCS)%.c
#$(COBJS)\\%.o:$(CSRCS)\%.c
else
$(OBJS_DIR)/%.o : $(SRC_DIR)/%.c
#linux��Ҫ��·�����ϣ���д %o %c
endif
	@echo ���ڱ���c�ļ��� $< --> $@
	$(CC) -c $(CFLAGS) $< -o $@

.PHONY:msg clean
msg:
	@echo CSRCS��$(CSRCS)
	@echo COBJS��$(COBJS)
	@echo CFLAGS��$(CFLAGS)
	@echo RM������$(RM)
	
clean:cleanobj cleanexe
	@echo obj�ļ���exe�ļ���ɾ��

cleanobj:
	@echo ɾ������.o�ļ�
	$(RM) $(COBJS)
cleanexe:
	@echo ɾ������.exe�ļ�
	$(RM) $(TARGET)
