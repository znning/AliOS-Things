NAME := bt_mesh

$(NAME)_MBINS_TYPE := kernel
$(NAME)_VERSION := 1.0.0
$(NAME)_SUMMARY := BLE Mesh stack.

$(NAME)_COMPONENTS :=
$(NAME)_INCLUDES := ./src/include/

ifeq ($(bt_mesh_standalone_deploy),1)
GLOBAL_DEFINES += CONFIG_MESH_STACK_ALONE
$(NAME)_COMPONENTS += bluetooth.bt_mesh.util
else
$(NAME)_COMPONENTS += bluetooth.bt_host.bt_common
endif

$(NAME)_COMPONENTS += bluetooth.bt_mesh.ref-impl

$(NAME)_SOURCES := ./src/access.c \
                   ./src/adv.c \
                   ./src/beacon.c \
                   ./src/crypto.c \
                   ./src/cfg_srv.c \
                   ./src/health_srv.c \
                   ./src/main.c \
                   ./src/net.c \
                   ./src/prov.c \
                   ./src/transport.c

$(NAME)_SOURCES-$(CONFIG_BT_MESH_FRIEND) += ./src/friend.c
$(NAME)_SOURCES-$(CONFIG_BT_MESH_LOW_POWER) += ./src/lpn.c
$(NAME)_SOURCES-$(CONFIG_BT_MESH_PROXY) += ./src/proxy.c

$(NAME)_SOURCES-$(CONFIG_BT_MESH_CFG_CLI) += ./src/cfg_cli.c
$(NAME)_SOURCES-$(CONFIG_BT_MESH_HEALTH_CLI) += ./src/health_cli.c

$(NAME)_SOURCES-$(CONFIG_BT_MESH_SHELL) += ./src/shell.c

GLOBAL_INCLUDES += ./inc/

GLOBAL_DEFINES += CONFIG_BT_MESH

# Define your BT version here
#   0 - 1.0b
#   1 - 1.1
#   2 - 1.2
#   3 - 2.0
#   4 - 2.1
#   5 - 3.0
#   6 - 4.0
#   7 - 4.1
#   8 - 4.2
#   9 - 5.0
GLOBAL_CFLAGS-y += -DBT_HCI_VERSION=8
