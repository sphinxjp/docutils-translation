# you need setup Environment Variables as:
#
#  PIP_USE_WHEEL=true
#  SPHINXINTL_TRANSIFEX_USERNAME=<YOUR-TRANSIFEX-ID>
#  SPHINXINTL_TRANSIFEX_PASSWORD=<YOUR-TRANSIFEX-PW>
#  SPHINXINTL_LOCALE_DIRS=locale


#hg clone https://bitbucket.org/sphinxjp/docutils-translation
# cwd is cloned from https://bitbucket.org/sphinxjp/docutils-translation

##################################
# get docutils source
svn export --force http://svn.code.sf.net/p/docutils/code/trunk .

################################
# setup sphinx and others
pip install --pre sphinx
pip install sphinx-intl transifex-client

################################
# setup transifex setting files
sphinx-intl create-transifexrc        #create ~/.transifexrc


#######################################
# make pot files and push to transifex
#sphinx-build -b gettext . locales/pot
#sphinx-intl --transifex-project-name=docutils update-txconfig-resources
#tx push -s

###########################
# make translated document
tx pull -l ja                         #pull po files from transifex
sphinx-intl build                     #compile po -> mo
sphinx-build -b html -d _build/doctrees -Dlanguage=ja . _build/html
