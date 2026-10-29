rex.bind("ctrl+a>c", "client.tab.new")
rex.bind("ctrl+a>n", "client.tab.next")
rex.bind("ctrl+a>p", "client.tab.previous")
-- % and " on a US layout
rex.bind("ctrl+a>shift+5", "pane.split", { direction = "right" })
rex.bind("ctrl+a>shift+2", "pane.split", { direction = "down" })
rex.bind("ctrl+a>z", "pane.zoom")
rex.bind("ctrl+a>x", "pane.close")
-- % Focus Pane vim style
rex.bind("ctrl+a>h", function()
	rex.session.focus_direction({ direction = "left" })
	return true
end)
rex.bind("ctrl+a>j", function()
	rex.session.focus_direction({ direction = "down" })
	return true
end)
rex.bind("ctrl+a>k", function()
	rex.session.focus_direction({ direction = "up" })
	return true
end)
rex.bind("ctrl+a>l", function()
	rex.session.focus_direction({ direction = "right" })
	return true
end)

-- Press Ctrl+B twice to send one to the terminal

rex.bind("ctrl+a>ctrl+a", "pane.send_key", { key = "ctrl+a" })
