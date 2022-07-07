SRCS = $(wildcard *.md)

all: $(patsubst %.md,%.html,$(SRCS))

%.html: %.md
	cmark $< -t html > $@

clean:
	rm *.html *.pdf
