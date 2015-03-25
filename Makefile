VERSION=`awk -F= '/^version/ {print $2}' snap | cut -d= -f2`

help:
	@echo "parse the script to produce a list of options"

release:
	@git tag $(VERSION)
