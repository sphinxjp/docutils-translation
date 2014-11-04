# you need setup Environment Variables as:
#
#  SPHINXINTL_TRANSIFEX_USERNAME=<YOUR-TRANSIFEX-ID>
#  SPHINXINTL_TRANSIFEX_PASSWORD=<YOUR-TRANSIFEX-PW>
#  SPHINXINTL_LOCALE_DIRS=locale


#hg clone https://bitbucket.org/sphinxjp/docutils-translation
# cwd is cloned from https://bitbucket.org/sphinxjp/docutils-translation

##################################
# get docutils source
svn export --force http://svn.code.sf.net/p/docutils/code/trunk .

##################################
# get wheel packages
curl -L -s https://www.dropbox.com/s/pmxl0g8ghwmrgj0/sphinx-wheelhouse-20140503.tgz | tar vzxf -
curl -L -s https://www.dropbox.com/s/cmy7e6frsv1mf6a/sphinx-intl-wheelhouse-20140503.tgz | tar vzxf -

export PIP_FIND_LINKS=wheelhouse
python wheelhouse/get-pip.py


################################
# setup sphinx and others
pip install --pre sphinx

pip install sphinx-intl transifex-client==0.8
## transifex-client 0.9 has a SSL issue. 0.10 is not fine to upload new resource.

### WHY??
ls -laFd /home/ubuntu/virtualenv/python2.7/bin/tx
chmod +x /home/ubuntu/virtualenv/python2.7/bin/tx


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
tx pull -l ja                         #pull po files from transifex
sphinx-intl build                     #compile po -> mo
sphinx-build -b html -d _build/doctrees -Dlanguage=ja . _build/html
