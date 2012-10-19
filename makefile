#makefile的细节：
#1.每行命令后面不要带多余的空格
#2.windows和linux下的shell命令、目录表示不同
#3.CINCS = -I.\includes 中I和.之间不能有空格

#几个特殊变量的含义
 #$@  用在生成规则中，表示当前目标 
 #$<  用在生成规则中，表示当前目标的第一个依赖目标
 #$^  用在生成规则中，表示当前目标的所有依赖目标
 
 #########################################################
 #本makefile对应的工程目录组织
 # .\  ------- project root
 #   +sources\
 #   +includes\
 #   +objs\
 #    target
 #    makefile
 #修改时，根据实际改变响应的目录名，另外重填.\sources下源文件列表
 #########################################################
 
TARGET = demo.exe 

##########目录设置 ##########
####工程根目录
PROJECT_ROOT = .
###源代码根目录####
#C源程序
SRC_DIR = $(PROJECT_ROOT)\sources

#中间目标文件目录
OBJS_DIR := $(PROJECT_ROOT)\objs
#从运行结果来看，这里最好不要在末尾加\，斜线留到addprefix

APP_CSRCS = printA.c printB.c main.c

##### 添加路径
ifdef APP_CSRCS
CSRCS := $(addprefix $(SRC_DIR)\,$(APP_CSRCS))
endif

#CSRCS = $(APP_CSRCS)
#貌似是括号左右不能留空格

#目标文件定义
COBJS := $(addprefix $(OBJS_DIR)\, $(patsubst %.c,%.o,$(notdir $(CSRCS))))

#编译器命令相关
CC = gcc 
#注意 等于号相当于C语言中的宏定义
RM = del  
#注意 windows下将等于号后面的rm改为del，linux下RM = rm

#头文件目录
INC_DIR := .\includes 
#如有其他头文件目录可以直接后面添加目录的名 注意前面加-I

#编译选项
CFLAGS = -g -Wall
CFLAGS += -I$(INC_DIR)
#all : version $(target)
all : $(TARGET)

version :
	@echo Show GCC Version
	$(CC) --version

$(TARGET) : $(COBJS)
	@echo 连接目标文件，生成最终target -- $@
	$(CC)  $(COBJS) -o $@ 
	
# 编译C程序，此规则的写法很重要！！！
$(OBJS_DIR)%.o : $(SRC_DIR)%.c
	@echo 正在编译c文件： $< --> $@
	$(CC) -c $(CFLAGS) $< -o $@

.PHONY:msg clean
msg:
	@echo CSRCS是$(CSRCS)
	@echo COBJS是$(COBJS)
	@echo CFLAGS是$(CFLAGS)
	@echo RM命令是$(RM)
	
clean:cleanobj cleanexe
	@echo obj文件和exe文件已删除

cleanobj:
	@echo 删除所有.o文件
	$(RM) $(COBJS)
cleanexe:
	@echo 删除所有.exe文件
	$(RM) $(target)
