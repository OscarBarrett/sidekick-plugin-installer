# Version 1.0.0

# Find compatibility uuid for the current version of Mail
set uuid to do shell script "defaults read /Applications/Mail.app/Contents/Info.plist PluginCompatibilityUUID"

set macOSMajorVersion to do shell script "sw_vers -productVersion | cut -d . -f 1"
set macOSMinorVersion to do shell script "sw_vers -productVersion | cut -d . -f 2"

# Download the Sidekick package
do shell script "curl -f http://dl.getsidekick.com/applemail/2.6.1/Sidekick.pkg -o /tmp/Sidekick.pkg"

tell application "Finder"
  # Begin the install
  do shell script "open /tmp/Sidekick.pkg"
  delay 5

  # Wait for the installer to exit
  repeat while application process "Installer" exists
    delay 1
  end repeat

  try
    set bundlepath to do shell script "find ~/Library/Mail -name 'Sidekick.mailbundle' -print -quit"

    # For OS versions older than 10.12, use the old Plugin compatibility key that does not contain version info.
    if macOSMajorVersion <= 10 and macOSMinorVersion < 12 then
      do shell script "defaults write " & quoted form of bundlepath & "/Contents/Info.plist SupportedPluginCompatibilityUUIDs -array-add " & uuid
    else
      # Otherwise, use the new format
      do shell script "defaults write " & quoted form of bundlepath & "/Contents/Info.plist Supported" & macOSMajorVersion & "." & macOSMinorVersion & "PluginCompatibilityUUIDs -array-add " & uuid
    end if

    # Move the plugin into place
    do shell script "mv " & quoted form of bundlepath & " ~/Library/Mail/Bundles/Sidekick.mailbundle"

    # Restart Mail
    tell application "Mail"
      quit
    end tell
    delay 2
    tell application "Mail" to activate

    display alert "The Sidekick plugin was successfully patched and should now be installed. Look for the tab in Mail -> Preferences."

  on error errStr number errorNumber
    display alert "Failed to patch the Sidekick plugin; the installation may have failed."
    display alert errStr
  end try
end tell
