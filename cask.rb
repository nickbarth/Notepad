cask 'notepad' do
  version '1.0.0'
  sha256 '0a588c86d4484855caff06cf3dbb2f1059e42423dae90f69d4e1b371130696a8'

  url "https://github.com/nickbarth/Notepad/releases/download/v1.0.0/notepad-mac.zip"
  name 'Notepad'

  app 'Notepad.app'
  binary "#{appdir}/Notepad.app/Contents/MacOS/Notepad.app"
end