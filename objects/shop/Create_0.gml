var SHOP = Flag_Get(FLAG_TYPE.TEMP,FLAG_TEMP.SHOP);
_host_object = Shop_GetHost(SHOP)

_menu_dialog = Shop_GetMenuDialogFromShopCustom(SHOP)
_right_dialog = ""
_itemdesc_dialog = ""

_host_buy = ds_list_create()//内容由一个数组构成，数组结构为[名字(字符串),价格(数值),描述(字符串),是否可购买(布尔)]
_host_talk = ds_list_create()//内容为名字(字符串)

_state = -1
_menu = -1
_menu_buy = -1
_menu_sell = -1

_buy_result = 0
_sell_result = 0

_menu_choice = 0//主菜单选择
_buy_choice = 0
_sell_choice = 0
_talk_choice = 0

_page_buy = 0
_page_talk = 0

_dialog_auto_end = true

_menu_next = -1

_inst_dialog[0] = noone//对话
_inst_dialog[1] = noone//对话
_inst_menu_choice = noone//右侧四个选项
_inst_page = noone//页码显示
_inst_right_dialog = noone//右侧对话
_inst_itemdesc = noone//购买界面物品描述
_itemdesc_dialog = ""