# Sidekick Plugin Installer

This repository contains a script that patches and installs the Sidekick (since renamed [HubSpot Sales](https://www.hubspot.com/products/sales)) Apple Mail Plugin.

Since November 2015, HubSpot [no longer officially supports the plugin](https://knowledge.hubspot.com/articles/kcs_article/email-tracking/what-email-clients-are-supported#apple-mail), and due to the way that Apple Mail Plugin compatibility is handled, the plugin will not work by default on newer versions.

### Usage

Download Install.zip from latest release. Unarchive and run Install, following the instructions.

### What exactly does this do?

The script will download the latest available version of the Sidekick plugin and open the installer. As HubSpot own the copyright to their plugin, it is not included in this repository.

Once the installer has exited, the script will then patch the plugin to add the correct compatibility information to its Info.plist file, move it into place and then restart Mail.
