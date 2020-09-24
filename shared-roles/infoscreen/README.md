ansible role to set up an infoscreen. An infoscreen is a machine that shows a URL in a web browser that runs fullscreen.

Configurable variables:

    infoscreen__user: (default = infoskjerm) the user that web browser runs under
    infoscreen__url: (default = http://bitraf.no/) the url that the web browser displays

Tested on Raspberry Pi OS (Raspbian) 10, and Debian 10. Works fine with a Raspberry Pi OS Lite image.