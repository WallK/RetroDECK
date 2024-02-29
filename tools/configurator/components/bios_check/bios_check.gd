extends Control

var file := FileAccess
var bios_tempfile := "bios_test_file"
var BIOS_COLUMNS_BASIC := ["BIOS File Name", "System", "Found", "Hash Match", "Description"]
var BIOS_COLUMNS_EXPERT := ["BIOS File Name", "System", "Found", "Hash Match", "Description", "Subdirectory", "Hash"]

func _ready():
	var table = $Table
	if true:
		table.columns = BIOS_COLUMNS_BASIC.size()
		for i in BIOS_COLUMNS_BASIC.size():
			table.set_column_title(i, BIOS_COLUMNS_BASIC[i])
	else:
		table.columns = BIOS_COLUMNS_EXPERT.size()
		for i in BIOS_COLUMNS_EXPERT.size():
			table.set_column_title(i, BIOS_COLUMNS_EXPERT[i])

	var root = table.create_item()
	table.hide_root = true
	if file.file_exists(bios_tempfile): #File to be removed after script is done
		var bios_list := file.open(bios_tempfile, FileAccess.READ)
		var bios_line := []
		while ! bios_list.eof_reached():
			bios_line = bios_list.get_csv_line("^")
			var table_line: TreeItem = table.create_item(root)
			for i in bios_line.size():
				table_line.set_text(i, bios_line[i])
				if table_line.get_index() % 2 == 1:
					table_line.set_custom_bg_color(i,Color(1, 1, 1, 0.1),false)
