#makefile��ϸ�ڣ�
#1.ÿ��������治Ҫ������Ŀո�
#2.windows��linux�µ�shell���Ŀ¼��ʾ��ͬ
#3.CINCS = -I.\includes ��I��.֮�䲻���пո�
#4. windows��ʹ��mingw32-make

#������������ĺ���
 #$@  �������ɹ����У���ʾ��ǰĿ�� 
 #$<  �������ɹ����У���ʾ��ǰĿ��ĵ�һ������Ŀ��
 #$^  �������ɹ����У���ʾ��ǰĿ�����������Ŀ��
 
 #########################################################
 #��makefile��Ӧ�Ĺ���Ŀ¼��֯
 # .\  ------- project root
 #   +sources\
 #   +includes\
 #   +objs\
 #    target
 #    makefile
 #�޸�ʱ������ʵ�ʸı���Ӧ��Ŀ¼������������.\sources��Դ�ļ��б�
 #########################################################
 
TARGET = demo.exe 

##########Ŀ¼���� ##########
####���̸�Ŀ¼
PROJECT_ROOT = .
###Դ�����Ŀ¼####
#CԴ����
SRC_DIR = $(PROJECT_ROOT)\sources

#�м�Ŀ���ļ�Ŀ¼
OBJS_DIR := $(PROJECT_ROOT)\objs
#�����н��������������ò�Ҫ��ĩβ��\��б������addprefix

APP_CSRCS = printA.c printB.c main.c

##### ���·��
ifdef APP_CSRCS
CSRCS := $(addprefix $(SRC_DIR)\,$(APP_CSRCS))
endif

#CSRCS = $(APP_CSRCS)
#ò�����������Ҳ������ո�

#Ŀ���ļ����壬��·����ӽ���
COBJS := $(addprefix $(OBJS_DIR)\, $(patsubst %.c,%.o,$(notdir $(CSRCS))))
#COBJS := $(addprefix $(OBJS_DIR)\, $(patsubst %.c,%.o,$(APP_CSRCS)))

#�������������
CC = gcc 
#ע�� ���ں��൱��C�����еĺ궨��
RM = del  
#ע�� windows�½����ںź����rm��Ϊdel��linux��RM = rm

#ͷ�ļ�Ŀ¼
INC_DIR := .\includes 
#��������ͷ�ļ�Ŀ¼����ֱ�Ӻ������Ŀ¼���� ע��ǰ���-I

#����ѡ��
CFLAGS = -g -Wall
CFLAGS += -I$(INC_DIR)
#all : version $(target)
all : $(TARGET)

version :
	@echo Show CC Version
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
$(OBJS_DIR)%.o : $(SRC_DIR)%.c
#$(OBJS_DIR)\\%.o : $(SRC_DIR)\\%.c
#$(COBJS)%.o:$(CSRCS)%.c
#$(COBJS)\\%.o:$(CSRCS)\%.c
	@echo ���ڱ���c�ļ��� $< --> $@
	$(CC) -c $(CFLAGS) $< -o $@

.PHONY:msg clean
msg:
	@echo CSRCS��$(CSRCS)
	@echo COBJS��$(COBJS)
	@echo CFLAGS��$(CFLAGS)
	@echo RM������$(RM)
	@echo $(notdir $(CSRCS))
	
clean:cleanobj cleanexe
	@echo obj�ļ���exe�ļ���ɾ��

cleanobj:
	@echo ɾ������.o�ļ�
	$(RM) $(COBJS)
cleanexe:
	@echo ɾ������.exe�ļ�
	$(RM) $(TARGET)
