svg := $(wildcard svg/*.svg)

# Clean that source code up
.PHONY: lint
lint: $(svg)
	dos2unix --keepdate --quiet $^
	perl -0777 -pi -e '\
		s/\s+(id|viewBox|xml:space)="[^"]*"/ /gmi; \
		s/<\?xml.*?\?>//gi; \
		s/<!--.*?-->//gm; \
		s/ style="enable-background:.*?;"//gmi; \
		s/"\s+>/">/g; \
		s/\x20{2,}/ /g; \
		s/[\t\n]+//gm;' $^

.PHONY: reset
reset:
	@git checkout -- svg/


# Convert each SVG's filename to lowercase
.PHONY: downcase
downcase: $(svg)
	@f=($(svg)); for i in "$${f[@]}"; do d=$$(echo "$$i" | tr '[A-Z]' '[a-z]'); mv "$$i" "$$d"; done
