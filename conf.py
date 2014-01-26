import sys, os
sys.path.insert(0, 'docutils')
import docutils

release = version = docutils.__version__
project = u'Docutils documentation in Japanese'
copyright = u'2014, docutils'

source_suffix = '.txt'
master_doc = 'index'
html_use_smartypants = False
exclude_patterns = ['prest', 'sandbox', 'docutils/docutils', 'docutils/licenses', 'docutils/test', 'docutils/tools', 'locale', '*.egg-info']
pygments_style = 'sphinx'
language = 'en'

locale_dirs = ['locale']
gettext_compact = False
