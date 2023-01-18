import argparse
import logging
import sys


logger = logging.getLogger("mac_bootstrap")

"""
I'm re-creating the wheel from:
    - https://github.com/thoughtbot/laptop
    - https://github.com/joshukraine/mac-bootstrap

Need to install:
    - oh-my-zsh
    - powerline
    - metatron-tools (curl)
    - https://sdkman.io/install
    - pyenv (brew)
    - docker (does newt still do this?)
        - https://docs.docker.com/desktop/install/mac-install/
    - 


Nice tools I found along the way:
    - the_silver_searcher (brew)
    - newvim (brew)

Need to configure:
    - zsh
    - oh-my-zsh
    - vim
    - item
"""


def main():
    logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)-8s %(name)s.%(module)s %(lineno)s %(message)s")
    py_ver = ".".join([
        sys.version_info.major,
        sys.version_info.minor,
        sys.version_info.micro
    ])
    logger.info("Using python %s to bootstrap your mac", py_ver)

if __name__ == "__main__":
    main()
