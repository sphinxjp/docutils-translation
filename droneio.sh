#hg clone https://bitbucket.org/sphinxjp/docutils-translation
# cwd is cloned from https://bitbucket.org/sphinxjp/docutils-translation

##################################
# get docutils source
svn export --force http://svn.code.sf.net/p/docutils/code/trunk .

################################
# setup sphinx and others
pip install sphinx boto_rsync babel sphinx-intl transifex-client

################################
# setup transifex setting files
sphinx-intl create-transifexrc        #create ~/.transifexrc


#######################################
# make pot files and push to transifex
sphinx-build -b gettext . locales/pot
sphinx-intl --transifex-project-name=docutils update-txconfig-resources
tx push -s

###########################
# make translated document
tx pull --all                         #pull po files from transifex
sphinx-intl build                     #compile po -> mo
sphinx-build -b html -d _build/doctrees -Dlanguage=ja . _build/html

##################################
# deploy to s3
boto-rsync --delete -g public-read _build/html s3://docutils.sphinx-users.jp/
