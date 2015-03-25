VERSION=`awk -F= '/^version/ {print $2}' snap | cut -d= -f2`

help:
	@awk 'BEGIN{print "Usage\n====="} /^  -/ {print "*"$$0}' ./snap
	@echo 
	@awk 'BEGIN{print ".snaprc options and defaults\n======="} /\(get_conf_var/ {gsub("\x27|\\)", "", $$0); print "**"$$2"**: " "*"$$5"*"}' ./snap
 
release:
	@git tag $(VERSION)
	@git push --tags
