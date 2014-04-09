# I get quite a few of my gems via Git (including some I could get from rubygems.)
# The rest come from:
source "https://rubygems.org"

# IIRC, at least one gem needs ruby >= 1.9, and one gem needs ruby <= 1.9,
# but I cannot remember which.  Regardless, 1.9.3 is the only version I test with.
#ruby "1.9"


# Jekyll
# ======

# Jekyll, the blog-aware static-site generator + plugins
# Version 1.4.3 has a bug on windows-only that will not be patched until next version.
# Version 2.0.0.alpha has problems running under grunt-jekyll
# So, we use version:
gem "jekyll", "=1.5.1"


# Jekyll Plugins
# --------------

# I have forked this one, and am bending it to suit my will.
gem "jekyll-pandoc-multiple-formats", :github => "pprince/jekyll-pandoc-multiple-formats", :branch => "ppdevel"


# Sass and Compass
# ================

# Sass 3.3 is out!  w00t!
gem "sass", "~>3.3.4"

# I have forked this one, only for a tiny change; see compass issue #1306
gem "compass", :github => "pprince/compass", :branch => "gemspec_ruby_listen"
#gem "compass", "=1.0.0.alpha.19"


# Compass Extensions
# ------------------

# All of the following gems, in both the automatically imported and other lists,
# should be in the list of gems for compass to require.  This list is currently
# maintained in the Gruntfile (`gruntfile.coffee`), and this should be
# synchronized with that one.

# ### Auto-Imported ###

# I wanted to use both sass-globbing and compass-import-once, but they
# interfere with each other; compass-import-once has been disabled elsewhere.
# See: https://github.com/chriseppstein/compass/issues/1529
gem "compass-import-once", "~>1.0.4", :require => "compass/import-once/activate"
gem "sass-globbing", "~>1.1.0"


# Breakpoint is out!
gem "breakpoint", "~>2.4"

# SusyNext aka Susy 2 is out!  w00t!
gem "susy", "~>2.1.1"

# This one seems OK to include in global import because it's specifically
# non-conflicting.
gem "scut"

gem "sassy-buttons"


# ### Additionally Available ###

gem "sassy_noise"
gem "bluesy-noise", :github => "pprince/bluesy-noise", :branch => "ppdevel"

# Other Gems
# ==========

# chunky_png is the pure-ruby PNG generation/manipulation library.
# oily_png is a ruby native C code extension that significantly
# speeds up chunky_png.
gem "chunky_png", "~> 1.3.0"
gem "oily_png", "~> 1.1.1"

# for git psdiff
gem "psd", "~> 2.1.2"

# For Listen to work for GruntJS on Windows...
# see: http://jekyllrb.com/docs/windows/#installation
require 'rbconfig'
gem 'wdm', '~> 0.1.0' if RbConfig::CONFIG['target_os'] =~ /mswin|mingw/i
