To generate the different metapackages:

    sudo apt-get install equivs
    sudo apt-get install python-yaml
    ./generate_deb.py

To install the generated packages:

    sudo gdebi -n jlefrique-base_1.0_all.deb
