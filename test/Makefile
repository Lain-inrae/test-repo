

RHOME = ~/R-versions/R-4.1.2

R = $(RHOME)/bin/R
RSCRIPT = $(RHOME)/bin/Rscript
PACKAGE_NAME = $$(grep "^Package:" DESCRIPTION | cut -d \  -f2)
PACKAGE_VERSION = $$(grep "^Version:" DESCRIPTION | cut -d \  -f2)
PACKAGE_FILE_NAME = $(PACKAGE_NAME)_$(PACKAGE_VERSION).tar.gz

# TARGET = CRAN
# TARGET = BIOCONDUCTOR

CHECK = $(R) -q -e "devtools::check('.')"
ifeq ($(TARGET),CRAN)
	CHECK = $(R) CMD check --as-cran $(PACKAGE_FILE_NAME)
endif
ifeq ($(TARGET),BIOCONDUCTOR)
	CHECK = $(R) CMD BiocCheck $(PACKAGE_FILE_NAME)
endif


all: install test

install: uninstall check
	$(R) CMD INSTALL $(PACKAGE_FILE_NAME)

uninstall:
	- $(R) CMD REMOVE $(PACKAGE_NAME)

check: build
	$(CHECK)

build: clean doc
	$(R) CMD build .

doc: | check_packages
	@echo "Generating doc..."
	@$(R) -q -e "rmarkdown::render('README.Rmd')"
	@$(R) -q -e "devtools::document('.')"
	@$(R) -q -e 'library("roxygen2");roxygenize(".");warnings()'
	@echo "Generated."

test: | check_packages
	@$(R) -q -e "devtools::test('.')"

clean:
	- rm $(PACKAGE_FILE_NAME)
	- rm -rf man ..Rcheck W4MRUtils.Rcheck

check_packages:
	@printf -- "Checking for required packages..."
	@$(R) -q -e "lapply(c('devtools', 'roxygen2', 'rmarkdown'), library, character.only = TRUE)" > /dev/null 2>&1
	@printf -- " [OK]\n"

