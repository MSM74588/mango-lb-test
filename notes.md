# NOTES:

## 1:
In live-build, which is a tool used to build live CD/DVD/USB images of Debian-based systems, there are several package lists that you can configure to customize the packages included in the resulting image. These package lists determine which packages are installed in the live system.

Here are some of the commonly used package lists in live-build:

1. `config/package-lists/live.list.chroot`: This list contains packages that are installed in the live system's chroot environment. These packages are included in the live image.

2. `config/package-lists/install.list.chroot`: Packages listed here are installed in the target system when the live system is installed on a hard drive or other storage medium. These packages are not included in the live image itself but are installed when the system is installed from the live image.

3. `config/package-lists/build.list`: This list specifies packages that are needed during the build process but are not included in the final live system.

4. `config/package-lists/includes.chroot`: This list includes additional package lists that are merged together to form the final package list for the live system. It allows you to organize packages into separate files for better maintainability.

You can customize these package lists to include or exclude specific packages according to your requirements. By modifying these lists, you can control the software packages that are included in your live system or installed on the target system.

It's worth noting that the specific names and locations of these package lists may vary depending on the version of live-build and the configuration of your project. You can refer to the documentation or configuration files of your live-build setup for more detailed information about the available package lists and their locations.

## 2:
To use live-build with the Calamares installer, you need to configure the following files:

1. `auto/config`: Open this file in a text editor. Look for the line starting with `lb config`, and ensure that the `--bootappend-live` option includes `boot=live components`, which is needed for using Calamares. The line should look like this:

   ```
   lb config --mode <mode> --bootappend-live "boot=live components"
   ```

   Replace `<mode>` with the desired mode you are using (e.g., `debian`, `ubuntu`, etc.).

2. `config/package-lists/install.list.chroot`: Add the Calamares package to the list of packages that are installed in the target system. Add the following line to include the Calamares package:

   ```
   calamares
   ```

   You can also include other necessary packages that Calamares requires for proper functionality.

3. `config/includes.chroot/99-calamares-settings`: Create a new file named `99-calamares-settings` in the `config/includes.chroot` directory. This file contains the configuration settings for Calamares.

   Here's an example content for the `99-calamares-settings` file:

   ```
   #!/bin/sh

   # Set the desktop environment to use
   echo "exec calamares" > /etc/skel/.xsession

   # Set the default language for Calamares
   echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
   locale-gen
   echo "LANG=en_US.UTF-8" > /etc/default/locale
   ```

   This example sets the desktop environment to use Calamares and configures the default language.

4. `config/hooks/05-calamares`: Create a new file named `05-calamares` in the `config/hooks` directory. This file contains the hook script that runs during the build process.

   Here's an example content for the `05-calamares` file:

   ```
   #!/bin/sh

   mkdir -p "$DESTDIR/usr/share/live/config"
   cp -a "$CWD/config/includes.binary" "$DESTDIR/usr/share/live/config/includes"
   ```

   This example copies the `config/includes.binary` directory to the appropriate location so that Calamares can find the necessary configuration files.

After configuring these files, you can run the live-build command (`sudo lb build`) to build the live image with the Calamares installer. Make sure you have the Calamares package available in your package repositories or added as a local package source.

Remember that the specific configuration and file paths may vary depending on your live-build setup and version. Consult the documentation or configuration files specific to your live-build version for more detailed instructions.

## 3
https://live-team.pages.debian.net/live-manual/html/live-manual/customizing-package-installation.en.html

## 4
https://live-team.pages.debian.net/live-manual/html/live-manual/customizing-contents.en.html

## 5
https://live-team.pages.debian.net/live-manual/html/live-manual/customization-overview.en.html#354
Stages of live build

# 6, Binary Hooks
To run commands in the binary stage, create a hook script with a .hook.binary suffix containing the commands either in the config/hooks/live or config/hooks/normal directories. The hook will run after all other binary commands are run, but before binary_checksums, the very last binary command. The commands in your hook do not run in the chroot, so take care not to modify any files outside of the build tree, or you may damage your build system! See the example binary hook scripts for various common binary customization tasks provided in /usr/share/doc/live-build/examples/hooks which you can copy or symlink to use them in your own configuration. 

This hook will run when the binary build stage will run (when the iso file will be genrated), it will NOT run in CHROOT ENV. And will run in HOST ENV. So run carefully, it can damage the host system. It is useful for tasks like renaming the iso.
It runs before binary_checksum which is the last stage of binary stage.

# 7, Run Time Behavior
https://live-team.pages.debian.net/live-manual/html/live-manual/customizing-run-time-behaviours.en.html

# 8, Customizing the Binary Image
https://live-team.pages.debian.net/live-manual/html/live-manual/customizing-binary.en.html
- Explains installing Syslinux/isolinux/grub-pc (and how to customise the Boot Selection screen)

# 9
Multiverse is ubuntu repo and not debian, so it will not work as archive area for DEBIAN based system

# 10
auto/config > https://live-team.pages.debian.net/live-manual/html/live-manual/examples.en.html#807

## NOTE:
Dont forget to give executable permission in hooks 